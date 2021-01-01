-- lib. make sure this is included first.

-- Globals - a table with every global variable in the program.
_g = {}

-- util functions:
-- 7661 -> 7650
function nf() end
function identity(...) return ... end

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function _g.plus(a,b) return a + b end

function bool_to_num(condition) return condition and 0xffff or 1 end

function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end

function xbtnp() return btn_helper(btnp, 0, 1) end
function ybtnp() return btn_helper(btnp, 2, 3) end

function zsgn(num) return num == 0 and 0 or sgn(num) end
function round(num) return flr(num + .5) end

-- -1, 0, or 1
function rnd_one(val) return (flr_rnd'3'-1)*(val or 1) end

function ti(period, length)
   return t() % period < length
end

function flr_rnd(x)
   return flr(rnd(x))
end

-- A random item from the list.
function rnd_item(...)
   local list = {...}
   return list[flr_rnd(#list)+1]
end

-- Recursively copies table attributes.
function tabcpy(src, dest)
   dest = dest or {}

   for k,v in pairs(src or {}) do
      if type(v) == 'table' and not v.is_tabcpy_disabled then
         dest[k] = tabcpy(v)
      else
         dest[k] = v
      end
   end
   return dest
end

-- Call a function if the table and the table key are not nil
function call_not_nil(table, key, ...)
   if table and table[key] then
      return table[key](...)
   end
end

function batch_call_table(func,table)
   foreach(table, function(t) func(unpack(t)) end)
end

function batch_call_new(func, ...)
   batch_call_table(func, ztable(...))
end

-- fails if key is empty.
function zsplitkv(str, item_delim, kv_delim, val_func, expandable)
   local tbl, items = {}, split(str, item_delim)

   for item in all(items) do
      local kvs = split(item, kv_delim)
      local k,v = kvs[#kvs-1] or #tbl+1, kvs[#kvs]

      if expandable and #items == 1 then
         return val_func(v)
      else
         tbl[k] = val_func(v,k)
      end
   end

   return tbl
end

g_ztable_cache = {}
function ztable(str, ...)
   str = g_gunvals[0+str]
   local params = {...}
   foreach(params, disable_tabcpy)

   if g_ztable_cache[str] == nil then
      local operations = {}
      local tbl = zsplitkv(str, ';', ':', identity)
      for k, v in pairs(tbl) do
         local val_func = function(sub_val, sub_key)
            return queue_operation(tbl, k, sub_key, sub_val, operations)
         end

         tbl[k] = zsplitkv(v, ',', '=', val_func, true)
      end
      g_ztable_cache[str] = {tbl, operations}
   end

   local table = g_ztable_cache[str][1]
   local ops = g_ztable_cache[str][2]
   foreach(ops, function(op)
      local t, k = op.t, op.k
      if op.sk then
         t = t[op.k]
         k = op.sk
      end
      t[k] = op.f(params)
   end)
   return g_ztable_cache[str][1]
end

function queue_operation(tbl, k, sub_key, v, operations)
   local rest = sub(v,2)
   if ord(v) == 64 then -- @ param
      add(operations, {t=tbl, k=k, sk=sub_key, f=function(p)
         return p[rest+0]
      end})
   elseif ord(v) == 33 then -- ! func
      local ft=split(rest, '/')
      local ftparams = {}
      for i=2,#ft do
         add(ftparams,queue_operation(ftparams, i-1, nil, ft[i], operations))
      end

      add(operations, {t=tbl, k=k, sk=sub_key, f=function()
         return _g[ft[1]](unpack(ftparams))
      end})
   end

   local vlist = {}
   for x in all(split(v, '/')) do
      if x == 'true' or x == 'false' then x = x=='true'
      elseif x == 'nil' or x == '' then x = nil
      elseif x == 'nf' then x = function() end
      end
      add(vlist, x)
   end

   if #vlist < 2 then
      return vlist[1]
   else
      return vlist
   end
end

function disable_tabcpy(t)
   if type(t) == 'table' then
      t.is_tabcpy_disabled = true
   end
   return t
end

-- Assumes that each parent node has at least one item in it.
-- Example: tl_node(actor, actor)
function tl_node(root, node, ...)
   if node == nil then return true end
   local return_value

   if not node.tl_tim then node.tl_tim = 0 end

   if node.tl_name then
      root[node.tl_name] = node
   end

   -- parent node
   if #node > 0 then
      node.tl_cur = node.tl_cur or 1

      -- Goes into the child node.
      return_value = tl_node(root, node[node.tl_cur], ...)

      if return_value == 0 then
         node.tl_cur = nil
         return_value = true
      elseif return_value then
         root.tl_old_state = nil

         if type(return_value) == "NUMBER" then
            node.tl_cur = return_value
         else
            node.tl_cur = (node.tl_cur % #node) + 1
         end

         return_value = node.tl_cur == 1 and not node.tl_loop
      end

   -- leaf node
   else
      if not root.tl_old_state then
         tabcpy(node, root)
         node.tl_tim = 0
         root.tl_old_state = true
         call_not_nil(root, 'i', root, ...) -- init function
      end

      return_value = call_not_nil(root, 'u', root, ...)
      if root.tl_next then
         return_value, root.tl_next = root.tl_next
      end
   end

   if node != root or #node == 0 then
      node.tl_tim += 1/60
      root.tl_tim = node.tl_tim

      -- Return the update return code, or true if we are out of time.
      return_value = return_value or node.tl_max_time and node.tl_tim >= node.tl_max_time
   end

   if return_value then
      node.tl_tim = 0
      if #node == 0 then
         call_not_nil(root, 'e', root, ...) -- end function
      end
   end

   return return_value
end

-- TODO: Find a better home for this.
-- For parsing zipped values.
g_gunvals = split(g_gunvals_raw, "|")

-- For debugging
function tostring(any)
  if type(any)~="table" then return tostr(any) end
  local str = "{"
  for k,v in pairs(any) do
    if str~="{" then str=str.."," end
    str=str..tostring(k).."="..tostring(v)
  end
  return str.."}"
end

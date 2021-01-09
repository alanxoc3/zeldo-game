-- lib. make sure this is included second (after loading string data).

-- A table with a bunch of global variables.
_g = {}

-- util functions:
-- 7661 -> 7650
function nf() end
function identity(...) return ... end

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function _g.plus(a,b)  return a + b end
function _g.minus(a,b) return a - b end

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
function ztable(original_str, ...)
   local str, params = g_gunvals[0+original_str], {...}
   foreach(params, disable_tabcpy)

   if g_ztable_cache[str] == nil then
      local tbl, operations = zsplitkv(str, ';', ':', identity), {}
      for k, v in pairs(tbl) do
         local val_func = function(sub_val, sub_key)
            return queue_operation(tbl, k, sub_key, sub_val, operations)
         end

         tbl[k] = zsplitkv(v, ',', '=', val_func, true)
      end
      g_ztable_cache[str] = {tbl, operations}
   end

   local table, ops = g_ztable_cache[str][1], g_ztable_cache[str][2]
   foreach(ops, function(op)
      local t, k = op.t, op.k
      if op.sk then
         t, k = t[op.k], op.sk
      end
      t[k] = op.f(params)
   end)
   return g_ztable_cache[str][1]
end

function queue_operation(tbl, k, sub_key, v, operations)
   local vlist = split(v, '/')
   local will_be_table, func_op, func_name = #vlist > 1

   if ord(v) == 33 then -- ! func
      will_be_table = true

      func_op = {t=tbl, k=k, sk=sub_key}
      func_name = deli(vlist, 1)

      function func_op.f()
         return _g[sub(func_name, 2)](unpack(vlist))
      end
   end

   for i, x in pairs(vlist) do
      if ord(x) == 64 then -- @ param
         local operation = {}
         if will_be_table then
            operation.t = vlist
            operation.k = i
         else
            operation.t = tbl
            operation.k = k
            operation.sk = sub_key
         end

         function operation.f(p) return p[sub(x,2)+0] end
         add(operations, operation)
      elseif ord(x) == 37 then -- % _g value
         x = _g[sub(x, 2)]
      elseif x == 'true' or x == 'false' then x = x=='true'
      elseif x == 'nil' or x == '' then x = nil
      elseif x == 'nf' then x = function() end
      end
      vlist[i] = x
   end

   -- nil func_op won't actually add.
   add(operations, func_op)

   if will_be_table then
      return vlist
   else
      return vlist[1]
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

-- DEBUG_BEGIN
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
-- DEBUG_END

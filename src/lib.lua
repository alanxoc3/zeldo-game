-- lib. make sure this is included first.

-- util functions:
-- 7661 -> 7650
function dir_to_coord(dir)
   return dir == 0 and 0xffff or dir == 1 and 1 or 0, dir == 2 and 0xffff or dir == 3 and 1 or 0
end

function nf() end
function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function bool_to_num(condition) return condition and 1 or 0xffff end

function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end

function xbtnp() return btn_helper(btnp, 0, 1) end
function ybtnp() return btn_helper(btnp, 2, 3) end

function zsgn(num) return num == 0 and 0 or sgn(num) end
function round(num) return flr(num + .5) end

-- -1, 0, or 1
function rnd_one(val) return (flr(rnd(3))-1)*(val or 1) end

FPS=60
function ti(mod_val)
   return flr(t()*FPS) % (mod_val or 0)
end

-- Recursively copies table attributes.
function tabcpy(src, dest)
   dest = dest or {}
   for k,v in pairs(src or {}) do
      if type(v) == "TABLE" and not v.is_tabcpy_disabled then
         dest[k] = tabcpy(v)
      else
         dest[k] = v
      end
   end
   return dest
end

-- Call a function if the table and the table key are not nil
function call_not_nil(key, table, ...)
   if table and table[key] then
      return table[key](table, ...)
   end
end

function batch_call_table(func,table)
   -- Table is unpacked in this way, for both efficiency and tokens. The
   -- drawback is that it isn't dynamic.
   foreach(table, function(t) func(t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8]) end)
end

function batch_call(func,...)
   batch_call_table(func,gun_vals(...))
end

-- Returns the parsed table, the current position, and the parameter locations
function gun_vals_helper(val_str,i,new_params)
   local val_list, val, val_ind, isnum, val_key, str_mode = {}, '', 1, true

   while i <= #val_str do
      local x = sub(val_str, i, i)
      if     x == '\"' then str_mode, isnum = not str_mode
      elseif str_mode then val=val..x
      elseif x == '}' or x == ',' then
         if type(val) == 'table' or not isnum then
         elseif sub(val,1,1) == '@' then
            local sec = tonum(sub(val,2,#val))
            assert(sec != nil)
            if not new_params[sec] then new_params[sec] = {} end
            add(new_params[sec], {val_list, val_key or val_ind})
         elseif val == 'nf' then val = nf
         elseif val == 'true' or val == 'false' then val=val=='true'
         elseif val == 'nil' or val == '' then val=nil
         elseif isnum then val=tonum(val)
         end

         val_list[val_key or val_ind], isnum, val, val_ind, val_key = val, true, '', val_key and val_ind or val_ind+1

         if x == '}' then
            return val_list, i
         end
      elseif x == '{' then val, i, isnum = gun_vals_helper(val_str,i+1,new_params)
      elseif x == '=' then isnum, val_key, val = true, val, ''
      elseif x != " " and x != '\n' then val=val..x end
      i += 1
   end

   return val_list, i, new_params
end

-- Supports variable arguments, true, false, nil, nf, numbers, and strings.
param_cache = {}
function gun_vals(val_str, ...)
   -- there is global state logic in here. you have been warned.
   if not param_cache[val_str] then
      param_cache[val_str] = { gun_vals_helper(val_str..',',1,{}) }
   end

   local params, lookup = {...}, param_cache[val_str]
   for k,v in pairs(lookup[3]) do
      foreach(lookup[3][k], function(x)
         x[1][x[2]] = params[k]
         if type(params[k]) == "TABLE" then
            params[k].is_tabcpy_disabled = true
         end
      end)
   end

   return tabcpy(lookup[1])
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
         node.tl_cur = (node.tl_cur % #node) + 1
         return_value = node.tl_cur == 1 and not node.tl_loop
      end

   -- leaf node
   else
      if not root.tl_old_state then
         tabcpy(node, root)
         node.tl_tim = 0
         root.tl_old_state = true
         call_not_nil('i', root, ...) -- init function
         -- if root.id then
            -- printh("INIT CALLED for "..root.id)
         -- end
      end

      return_value = call_not_nil('u', root, ...)
      if root.tl_next then
         return_value, root.tl_next = true
      end
   end

   if node != root or #node == 0 then
      node.tl_tim += 1/60

      -- Return the update return code, or true if we are out of time.
      return_value = return_value or node.tl_max_time and node.tl_tim >= node.tl_max_time
   end

   if return_value then
      node.tl_tim = 0
      if #node == 0 then
         call_not_nil('e', root, ...) -- end function
      end
   end

   return return_value
end

-- For debugging.
-- function tostring(any) if type(any)=="FUNCTION" then return "FUNCTION" end
-- if any==nil then return "NIL" end if type(any)=="STRING" then return any end
-- if type(any)=="BOOLEAN" then if any then return "TRUE" end return "FALSE"
-- end if type(any)=="TABLE" then local str = "{ " for k,v in pairs(any) do
-- str=str..tostring(k).."->"..tostring(v).." " end return str.."}" end if
-- type(any)=="NUMBER" then return ""..any end return "UNKOWN" end

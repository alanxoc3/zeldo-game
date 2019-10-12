-- lib. make sure this is included first.

-- util functions:

-- 7661 -> 7650
function dir_to_coord(dir)
   return dir == 0 and 0xffff or dir == 1 and 1 or 0, dir == 2 and 0xffff or dir == 3 and 1 or 0
end

function btn_helper(f, a, b)
   return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0
end

function xbtn() return btn_helper(btn, 0, 1) end
function ybtn() return btn_helper(btn, 2, 3) end

function xbtnp() return btn_helper(btnp, 0, 1) end
function ybtnp() return btn_helper(btnp, 2, 3) end

function zsgn(num)
   return num == 0 and 0 or sgn(num)
end

-- -1, 0, or 1
function rnd_one() return flr(rnd(3))-1 end

-- copies table attributes from the src to dest tables.
function tabcpy(dest, src)
   dest = dest or {}
   for k,v in pairs(src or {}) do
      dest[k] = v
   end
   return dest
end

-- call a function if the table and the table key are not nil
function call_not_nil(key, table, ...)
   if table and table[key] then
      return table[key](table, ...)
   end
end

-- params: function, gun_vals
function batch_call_table(func,table)
   foreach(table, function(t) func(t[1], t[2], t[3], t[4], t[5], t[6], t[7], t[8]) end)
end

function batch_call(func,...)
   batch_call_table(func,gun_vals(...))
end

-- unpacks a table
-- https://gist.github.com/josefnpat/bfe4aaa5bbb44f572cd0
-- function munpack(t, from, to)
--   from, to = from or 1, to or #t
--   if from > to then return end
--   return t[from], munpack(t, from+1, to)
-- end

-- returns the parsed table, the current position, and the parameter locations
function gun_vals_helper(val_str,i,new_params)
   local val_list, val, val_ind, isnum, val_key, str_mode = {}, "", 1, true

   while i <= #val_str do
      local x = sub(val_str, i, i)
      if     x == "\"" then str_mode, isnum = not str_mode
      elseif x == "|" then -- do nothing, for perl minimizer.
      elseif str_mode then val=val..x
      elseif x == "}" or x == "," then
         if type(val) == "table" or not isnum then
         elseif sub(val,1,1) == "@" then
            local sec = tonum(sub(val,2,#val))
            assert(sec != nil)
            if not new_params[sec] then new_params[sec] = {} end
            add(new_params[sec], {val_list, val_key or val_ind})
         elseif val == "nf" then val = function() end
         elseif val == "true" or val == "false" then val=val=="true"
         elseif val == "nil" or val == "" then val=nil
         elseif isnum then val=tonum(val)
         end

         val_list[val_key or val_ind], isnum, val, val_ind, val_key = val, true, "", val_key and val_ind or val_ind+1

         if x == "}" then
            return val_list, i
         end
      elseif x == "{" then val, i, isnum = gun_vals_helper(val_str,i+1,new_params)
      elseif x == "=" then isnum, val_key, val = true, val, ""
      elseif x != " " and x != "\n" then val=val..x end
      i += 1
   end

   return val_list, i, new_params
end

-- supports variable arguments, true, false, nil, numbers, and strings.
param_cache = {}
function gun_vals(val_str, ...)
   -- there is global state logic in here. you have been warned.
   if not param_cache[val_str] then
      param_cache[val_str] = { gun_vals_helper(val_str..",",1,{}) }
   end

   local params, lookup = {...}, param_cache[val_str]
   for k,v in pairs(lookup[3]) do
      foreach(lookup[3][k], function(x)
         x[1][x[2]] = params[k]
      end)
   end

   return lookup[1]
end

-- tl - if update returns true, then 
-- tl in tl.. how to do it?
-- tl_update takes in a tl.

-- true is still executing
-- false means that we are done looping
function tl_update(tl, ...)
	-- switch the state
	if tl.tim and tl.tim >= tl.tl_max_tim then
      if not tl.tl_loop and tl.cur > 0 and tl.tl_nxt == 1 then
         return false
      end

		tl.cur = tl.tl_nxt
		tl.tl_nxt = (tl.cur % #tl.mas) + 1
      tl.tl_max_tim = tl.mas[tl.cur] and tl.mas[tl.cur].tl_tim or 0
		tl.tim = tl.tl_max_tim != 0 and 0 or nil

      tabcpy(tl, tl.mas[tl.cur])
		call_not_nil("i", tl, ...)
	end

   -- update func
	if call_not_nil("u", tl, ...) then
      tl.tim = tl.tl_max_tim
   end

	-- inc timer if enabled
	if tl.tim then
		tl.tim = min(tl.tim + 1/60, tl.tl_max_tim)
	end

   return true
end

-- optional number of which state should be loaded next.
function tl_next(tl, num)
   tl.tim=tl.tl_max_tim
   if num then tl.tl_nxt=num end
end

-- params: timeline control, timeline plan
function tl_attach(tl, mas)
   tabcpy(tl, gun_vals([[
      tl_max_tim=0,
      tl_enabled=true,
      mas=@1,
      tl_lvl=0,
      cur=0,
      tl_nxt=1,
      tl_loop=true,
      tim=0
   ]], mas or {}))

   return tl
end

-- params: str, gun_vals
function tl_init(...)
   return tl_attach({}, gun_vals(...))
end

-- debug something
-- function tostring(any)
--     if type(any)=="function" then 
--         return "function" 
--     end
--     if any==nil then 
--         return "nil" 
--     end
--     if type(any)=="string" then
--         return any
--     end
--     if type(any)=="boolean" then
--         if any then return "true" end
--         return "false"
--     end
--     if type(any)=="table" then
--         local str = "{ "
--         for k,v in pairs(any) do
--             str=str..tostring(k).."->"..tostring(v).." "
--         end
--         return str.."}"
--     end
--     if type(any)=="number" then
--         return ""..any
--     end
--     return "unkown" -- should never show
-- end

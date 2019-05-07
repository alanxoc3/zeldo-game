-- lib. make sure this is first.

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

function rnd_one() return flr(rnd(3))-1 end

function batch_call(func, str, ...)
   local arr = gun_vals(str,...)
   for i=1,#arr do func(munpack(arr[i])) end
end

-- i should cache this too.
-- https://gist.github.com/josefnpat/bfe4aaa5bbb44f572cd0
function munpack(t, from, to)
  from, to = from or 1, to or #t
  if from > to then return end
  return t[from], munpack(t, from+1, to)
end

-- returns the parsed table, the current position, and the parameter locations
function gun_vals_helper(val_str,i,new_params)
   local val_list, val, val_ind, isnum, val_key, str_mode = {}, "", 1, true

   while i <= #val_str do
      local x = sub(val_str, i, i)
      if     x == "$" then str_mode, isnum = not str_mode
      elseif x == "}" or x == "," then
         if type(val) == "string" and sub(val,1,1) == "@" then
            local sec = tonum(sub(val,2,#val))
            assert(sec != nil)
            if not new_params[sec] then new_params[sec] = {} end
            add(new_params[sec], {val_list, val_key or val_ind})
         elseif val == "true" or val == "false" or val == "" then val=val=="true"
         elseif isnum then val=0+val
         end

         val_list[val_key or val_ind], isnum, val, val_ind, val_key = val, true, "", val_key and val_ind or val_ind+1

         if x == "}" then
            return val_list, i
         end
      elseif str_mode then val=val..x
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
      for x in all(lookup[3][k]) do
         x[1][x[2]] = params[k]
      end
   end

   return lookup[1]
end

-- tl
-- If update returns true, then 

function tl_update(tl, ...)
	-- switch the state
	if tl.time == 0 then
		tl.current = tl.next
		tl.next = (tl.current % #tl.master) + 1
		tl.time = tl.master[tl.current].t
		tl_func(tl, "i", ...) -- init func
	end

	tl_func(tl, "u", ...) -- update func

	-- inc timer if enabled
	if tl.time then
		tl.time = max(0, tl.time - 1/60)
	end
end

-- optional number of which state should be loaded next.
function tl_next(tl, num)
   tl.time=0
   if num then tl.next=num end
end

-- call a function if not nil
function tl_func(tl, key, ...)
   if tl.master[tl.current][key] then
      return tl.master[tl.current][key](...)
   end
end

-- tl array fields:
--    init:   init callback. called right before the first update.
--    timer:  t > 0: measured in seconds. t == 0: done. t < 0: disabled.
--    update: callback for every frame.
--    draw:   callback for every frame.

-- pass the array into this function.
function tl_init(tl_master, ...)
   assert(#tl_master > 0)

   local tl = {
      master=tl_master,
      current=1,
      next=(1 % #tl_master)+1,
      time = tl_master[1].t
   }

   -- init function
   tl_func(tl, "i", ...)

   return tl
end

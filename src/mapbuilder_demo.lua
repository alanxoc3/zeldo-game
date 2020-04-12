dir_arr = {'l', 'r', 'u', 'd'}
met_arr = {'template', 'm', 'c', 'w', 'h'}

function sort_by_k(t)
   if t then
      for n=2,#t do
         local i=n
         while i>1 and t[i].k<t[i-1].k do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
         end
      end
   end
end

function num_to_r(num)
   if num < 10 then
      num = "0"..num
   end
   return 'R_'..num
end

function is_in_array(v, array)
   for x in all(array) do
      if x == v then
         return true
      end
   end
   return false
end

function room_to_str(room)
   local array_vals, dir_vals, met_vals = {}, {}, {}
   local str = "  "
   for k, v in pairs(room) do
      if is_in_array(k, dir_arr) then
         dir_vals[k] = v
      elseif is_in_array(k, met_arr) then
         met_vals[k] = v
      else
         add(array_vals, v)
      end
   end

   for k in all(met_arr) do
      if met_vals[k] ~= nil then
         str=str.." "..k.."="..array_tostring(met_vals[k])..","
      end
   end

   for k in all(dir_arr) do
      if dir_vals[k] ~= nil then
         str=str.."\n   "..k.."="..dir_array_to_str(dir_vals[k])..","
      end
   end

   str = str.."\n"
   if #array_vals > 0 then
      for i=1,#array_vals do
         str=str.."\n   "..obj_array_to_str(array_vals[i])..","
      end
      str = str.."\n"
   end
   return str
end

function rooms_to_str(rooms)
   local str = ""
   local new_rooms = {}
   for k, v in pairs(rooms) do
      add(new_rooms, {k=k, v=v})
   end

   sort_by_k(new_rooms)

   for i=1,#new_rooms do
      if i ~= 1 then str=str..",\n" end
      str=str..num_to_r(new_rooms[i].k).."#{\n"..room_to_str(new_rooms[i].v).."}"
   end

   return str
end

function obj_array_to_str(t)
   local str = "{"
   for i=1,#t do
      if str ~= "{" then str=str.."," end
      if i == 1 then
         str=str.."'"..t[i].."'"
      else
         str=str..array_tostring(t[i])
      end
  end
  return str.."}"
end

function dir_array_to_str(t)
   local str = "{"
   for i=1,#t do
      if str ~= "{" then str=str.."," end
      if i == 1 then
         str=str..num_to_r(t[i])
      else
         str=str..array_tostring(t[i])
      end
  end
  return str.."}"
end

function array_tostring(any)
   if type(any) == "string" then
      return "\""..any.."\""
   elseif type(any)~="table" then
      return tostr(any)
   end

   local str = "{"
   for x in all(any) do
      if (str~="{") then
         str=str..","
      end
      str=str..array_tostring(x)
   end
   return str.."}"
end

-- Here is the logic for the map builder tool.
function _init()
   reload(0x0000, 0x0000, 0x4300, "zeldo.p8")
   music(14)
end

function _update60()
   if btnp(4) or btnp(5) then
      printh("g_rooms = gun_vals[".."[\n"..rooms_to_str(g_rooms).."]".."]\n")
      extcmd("shutdown")
   end
end

function _draw()
   cls(8)
   print('B_UP', 0, 0, 7)
   spr(0,10,10,10,10,10,10,1,1)
end

dir_arr = {'l', 'r', 'u', 'd'}
met_arr = {'template', 'm', 'c', 'w', 'h'}

function sort(t)
   if t then
      for n=2,#t do
         local i=n
         while i>1 and t[i]<t[i-1] do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
         end
      end
   end
end

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
function create_button(x, y, text, cb)
   local hw = #text*2
   return {
      x=x, y=y, rx=hw, ry=3, text=text, callback=cb, active=true
   }
end

function did_click_button(b)
   return b.active and
      mouse_x < b.x+b.rx and
      mouse_x > b.x-b.rx and
      mouse_y < b.y+b.ry and
      mouse_y > b.y-b.ry
end

function draw_button(b)
   if b.active then
      rectfill(b.x-b.rx,b.y-b.ry,b.x+b.rx,b.y+b.ry,9)
      print(b.text, b.x-b.rx+1, b.y-b.ry+1, 7)
   end
end

g_map = {
   x=0,y=0,w=2,h=2
}

off_x = 0
off_y = 0

ht_x, ht_y = 0, 0

function scrx(val)
   return (val or 0) + 64-map_w*4-off_x
end

function scry(val)
   return (val or 0) + 64-map_h*4-off_y
end

function _init()
   reload(0x0000, 0x0000, 0x4300, "zeldo.p8")
   poke(0x5f2d, 1)
   music(14)

   mouse_x, mouse_y = 0, 0
   prev_mouse_x, prev_mouse_y = 0, 0
   sel_x, sel_y, is_selected = 0, 0, false

   g_room_inds = {}
   g_cur_room_ind = 1
   for k,v in pairs(g_rooms) do
      add(g_room_inds, k)
   end
   sort(g_room_inds)

   butts = {
      create_button(115,3, "save", function()
         printh("g_rooms = gun_vals[".."[\n"..rooms_to_str(g_rooms).."]".."]\n")
         extcmd("shutdown")
      end),

      create_button(90,3, "delete", function()

      end)
   }
end

function _update60()
   if btnp(0) then
      g_cur_room_ind = max(g_cur_room_ind-1, 1)
   elseif btnp(1) then
      g_cur_room_ind = min(g_cur_room_ind+1, #g_room_inds)
   end

   local k = g_room_inds[g_cur_room_ind]
   local qx, qy = flr(k/10 % 4), flr(k/40)
   local t_ind = k % 10

   map_x = qx*32 + g_room_template[t_ind].x
   map_y = qy*32 + g_room_template[t_ind].y
   map_w = g_rooms[k].w or g_room_template[t_ind].w
   map_h = g_rooms[k].h or g_room_template[t_ind].h
   map_c = g_rooms[k].c or 0

   mouse_x = mid(0, stat(32), 128)
   mouse_y = mid(0, stat(33), 128)

   ht_x = min(max(flr((mouse_x - scrx()-3)/4)/2, 0), map_w-1)
   ht_y = min(max(flr((mouse_y - scry()-3)/4)/2, 0), map_h-1)


   if not btn(4) then
      prev_mouse_x, prev_mouse_y = mouse_x, mouse_y

      if mouse_x > scrx(0) and mouse_y > scry(0) and
         mouse_x < scrx(map_w*8) and mouse_y < scry(map_h*8) then
         is_hover = true
         if stat(34) == 1 then
            is_selected = true
            sel_x = ht_x
            sel_y = ht_y
         end
      else
         is_hover = false
         if stat(34) == 1 then
            is_selected = false
         end
      end
   else
      off_x = prev_mouse_x - mouse_x
      off_y = prev_mouse_y - mouse_y
   end

   foreach(butts, function(b)
      if stat(34) == 1 then
         if did_click_button(b) then
            b.callback()
         end
      end
   end)
end

function _draw()
   cls(map_c)

   map(map_x, map_y, scrx(0), scry(0), map_w, map_h)

   foreach(butts, function(b)
      draw_button(b)
   end)

   print("room #"..g_room_inds[g_cur_room_ind], 5, 121, 7)

   if is_hover then
      rect(scrx(ht_x*8), scry(ht_y*8), scrx(ht_x*8)+7, scry(ht_y*8)+7, 6)
   end
   if is_selected then
      rect(scrx(sel_x*8), scry(sel_y*8), scrx(sel_x*8)+7, scry(sel_y*8)+7, 10)
   end

   spr(0, mouse_x-4, mouse_y-4)
   if is_hover then
      print(ht_x, 92, 121, 7)
      print(ht_y, 111, 121, 7)
   end
end

g_off_x, g_off_y = 0, 0
g_card_fade = 0

function isorty(t)
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
        end
    end
end

function load_room(new_room, rx, ry)
   -- reload the map (remove shovel things).
   reload(0x1000, 0x1000, 0x2000)

   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]

   -- take care of actors.
   acts_loop("confined", "kill")
   if cur_room.i then cur_room.i() end

   local x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   g_pl.x = rx + cur_room.x
   g_pl.y = ry + cur_room.y

   load_view(x, y, w, h, 8, 8, 2, 2, 2, 2)
   center_view(g_pl.x, g_pl.y)
end

g_transition_x = 0
g_transition_y = 0
g_transitioning = false
function transition_room(new_room, rx, ry, dir)
   if not g_transitioning then
      g_transitioning = true
      g_transition_routine = cocreate(function()
         for i=0,20 do
            g_card_fade = i/20*10
            if dir == 'u' then
               g_transition_y = sin(i/80+.5)*10
            elseif dir == 'd' then
               g_transition_y = sin(i/80)*10
            elseif dir == 'l' then
               g_transition_x = sin(i/80+.5)*10
            elseif dir == 'r' then
               g_transition_x = sin(i/80)*10
            end
            yield()
         end
         load_room(new_room, rx, ry)
         tbox_clear()
         yield()
         for i=20,0,-1 do
            g_card_fade = i/20*10
            if dir == 'u' then
               g_transition_y = sin(i/80)*10
            elseif dir == 'd' then
               g_transition_y = sin(i/80+.5)*10
            elseif dir == 'l' then
               g_transition_x = sin(i/80)*10
            elseif dir == 'r' then
               g_transition_x = sin(i/80+.5)*10
            end
            yield()
         end
         g_transitioning = false
      end)
   end
end

function room_update()
   local cur_room = g_rooms[g_cur_room]

   -- plus .5 and minus .375 is because there is a screen border.
   if g_transitioning then
      coresume(g_transition_routine)
   elseif cur_room then
      local dir = nil
      if g_pl.y > g_ry+g_rh-.375     then dir = 'd'
      elseif g_pl.y < g_ry + .5      then dir = 'u'
      elseif g_pl.x > g_view.rx+g_rw-.375 then dir = 'r'
      elseif g_pl.x < g_view.rx +.5       then dir = 'l'
      end

      if dir != nil and cur_room[dir] then
         transition_room(cur_room[dir][1], cur_room[dir][2], cur_room[dir][3], dir)
      end
   end
end

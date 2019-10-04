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

function load_room(new_room_name, rx, ry)
   -- reload the map (remove shovel things).
   reload(0x1000, 0x1000, 0x2000)

   -- todo: here
   g_cur_room = g_rooms[new_room_name]

   -- take care of actors.
   acts_loop("confined", "kill")
   if g_cur_room.i then g_cur_room.i() end

   g_pl.x = rx + g_cur_room.x
   g_pl.y = ry + g_cur_room.y

   g_view = gun_vals([[
      w=@1, h=@2,
      s1=6, s2=10,
      s1=6, s2=10,
      v1=2, v2=2,
      h1=2, h2=2
   ]], min(12, g_cur_room.w), min(12, g_cur_room.h))

   local rw = min(12, g_cur_room.w)
   local rh = min(12, g_cur_room.h)

   center_view(g_pl.x, g_pl.y)
end

g_transition_x = 0
g_transition_y = 0
g_transitioning = false
function transition_room(new_room_name, rx, ry, dir)
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
         load_room(new_room_name, rx, ry)
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
   -- plus .5 and minus .375 is because there is a screen border.
   if g_transitioning then
      coresume(g_transition_routine)
   elseif g_cur_room then
      local dir = nil
      if g_pl.y > g_cur_room.y+g_cur_room.h-.375     then dir = 'd'
      elseif g_pl.y < g_cur_room.y + .5      then dir = 'u'
      elseif g_pl.x > g_cur_room.x+g_cur_room.w-.375 then dir = 'r'
      elseif g_pl.x < g_cur_room.x +.5       then dir = 'l'
      end

      if dir != nil and g_cur_room[dir] then
         transition_room(g_cur_room[dir][1], g_cur_room[dir][2], g_cur_room[dir][3], dir)
      end
   end
end

g_card_fade = 0

function isorty(t)
   if t then
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
        end
    end
 end
end

function load_room(new_room_index, rx, ry, follow_actor)
   -- reload the map (remove shovel things).
   reload(0x1000, 0x1000, 0x2000)

   -- todo: refactor here
   g_cur_room_index = new_room_index
   g_cur_room = g_rooms[new_room_index]

   switch_song(g_cur_room.m)

   -- take care of actors.
   acts_loop('confined', 'delete')

   if follow_actor then
      follow_actor.x = rx + g_cur_room.x
      follow_actor.y = ry + g_cur_room.y
   end

   if g_cur_room.i then g_cur_room.i() end

   g_view = g_att.view(min(14, g_cur_room.w), min(12, g_cur_room.h), 2, follow_actor)
   g_left_ma_view = g_att.view(2.75, 3, 0, follow_actor)
   g_right_ma_view = g_att.view(2.75, 3, 0, nil)

   acts_loop('view', 'center_view')
end

function room_update()
   -- plus .5 and minus .375 is because there is a screen border.
   if not is_game_paused() and g_cur_room then
      local dir = nil
      if     g_pl.y > g_cur_room.y+g_cur_room.h-.375 then dir = 'd'
      elseif g_pl.y < g_cur_room.y + .5              then dir = 'u'
      elseif g_pl.x > g_cur_room.x+g_cur_room.w-.375 then dir = 'r'
      elseif g_pl.x < g_cur_room.x +.5               then dir = 'l'
      end

      if dir != nil and g_cur_room[dir] then
         transition(g_cur_room[dir][1], g_cur_room[dir][2], g_cur_room[dir][3], g_pl)
      end
   end
end

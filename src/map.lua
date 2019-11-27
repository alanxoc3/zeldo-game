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
   acts_loop('confined', 'kill')
   if g_cur_room.i then g_cur_room.i() end

   g_pl.x = rx + g_cur_room.x
   g_pl.y = ry + g_cur_room.y

   g_view = create_view_on_cur_room(14, 12, 2, g_pl)
   g_left_ma_view = create_view_on_cur_room(2.75, 3, 0, g_pl)
   g_right_ma_view = create_view_on_cur_room(2.75, 3, 0, nil)

   acts_loop('view', 'center_view')
end

-- 7327 to 7221 to 7197
g_att.transitioner = function(new_room_name, rx, ry)
   return create_actor([[
      id='transitioner', par={'act','unpausable'},
      att={
         {tl_name='intro',  i=@1, u=@2, tl_max_time=.5},
         {tl_name='ending', i=@3, u=@4, tl_max_time=.5, e=@5}
      }
      ]], -- init
      function(a)
         pause('transitioning')
      end, function(a)
         g_card_fade = a.intro.tl_tim/a.intro.tl_max_time*10
      end, function(a)
         load_room(new_room_name, rx, ry)
         -- todo: put this logic into the player, like a reset function.
         g_pl.ax = 0
         g_pl.dx = 0
         g_pl.ay = 0
         g_pl.dy = 0
         tbox_clear()
      end, function(a)
         g_card_fade = (a.ending.tl_max_time-a.ending.tl_tim)/a.ending.tl_max_time*10
      end, function()
         unpause()
         g_card_fade = 0
      end
   )
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
         g_att.transitioner(g_cur_room[dir][1], g_cur_room[dir][2], g_cur_room[dir][3])
      end
   end
end

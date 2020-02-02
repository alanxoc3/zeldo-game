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

function load_room(new_room_index, rx, ry)
   -- reload the map (remove shovel things).
   reload(0x1000, 0x1000, 0x2000)

   -- todo: refactor here
   g_cur_room_index = new_room_index
   g_cur_room = g_rooms[new_room_index]

   switch_song(g_cur_room.m)

   -- take care of actors.
   acts_loop('confined', 'kill')
   if g_cur_room.i then g_cur_room.i() end

   g_pl.x = rx + g_cur_room.x
   g_pl.y = ry + g_cur_room.y

   g_view = g_att.view_instance(min(14, g_cur_room.w), min(12, g_cur_room.h), 2, g_pl)
   g_left_ma_view = g_att.view_instance(2.75, 3, 0, g_pl)
   g_right_ma_view = g_att.view_instance(2.75, 3, 0, nil)

   acts_loop('view', 'center_view')
end

create_actor([['transitioner', 3, {'act','unpausable'}]], [[
   new_room_index=@1, rx=@2, ry=@3,
   {tl_name='intro',  i=@4, u=@5, tl_max_time=.5, e=@6},
   {tl_name='ending', i=@9, u=@7, tl_max_time=.5, e=@8}
]], -- init
function(a)
   pause'transitioning'
end, function(a)
   g_card_fade = a.intro.tl_tim/a.intro.tl_max_time*10
end, function(a)
   load_room(a.new_room_index, a.rx, a.ry)
   -- todo: put this logic into the player, like a reset function.
   g_pl.ax, g_pl.dx, g_pl.ay, g_pl.dy = 0, 0, 0, 0
   tbox_clear()
   g_game_paused = false
end, function(a)
   g_card_fade = (a.ending.tl_max_time-a.ending.tl_tim)/a.ending.tl_max_time*10
end, function()
   unpause()
   g_card_fade = 0
end, function()
   g_game_paused = true
end)

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

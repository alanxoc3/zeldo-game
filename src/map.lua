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
   acts_loop('confined', 'kill')
   if g_cur_room.i then g_cur_room.i() end

   if follow_actor then
      follow_actor.x = rx + g_cur_room.x
      follow_actor.y = ry + g_cur_room.y
   end

   g_view = g_att.view_instance(min(14, g_cur_room.w), min(12, g_cur_room.h), 2, follow_actor)
   g_left_ma_view = g_att.view_instance(2.75, 3, 0, follow_actor)
   g_right_ma_view = g_att.view_instance(2.75, 3, 0, nil)
   g_right_ma_view.timeoutable = true

   acts_loop('view', 'center_view')
end

create_actor([['transitioner', 4, {'act','unpausable'}]], [[
   new_room_index=@1, rx=@2, ry=@3, follow_actor=@4,
   {tl_name='intro',  i=@5, u=@6, tl_max_time=.5, e=@7},
   {tl_name='ending', i=@10, u=@8, tl_max_time=.5, e=@9}
]], -- init
function(a)
   pause'transitioning'
end, function(a)
   g_card_fade = a.intro.tl_tim/a.intro.tl_max_time*10
end, function(a)
   load_room(a.new_room_index, a.rx, a.ry, a.follow_actor)
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
         g_att.transitioner(g_cur_room[dir][1], g_cur_room[dir][2], g_cur_room[dir][3], g_pl)
      end
   end
end

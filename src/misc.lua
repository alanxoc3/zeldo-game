function destroy_effect(a, num, ...)
   for i=1,num do
      _g.thing_destroyed(a, rnd_item(...), rnd(.5)+.1)
   end
end

function destroy_func(a)
   _g.money(a.x, a.y, a.dx, a.dy)
end

-- this file contains the logic for loading and saving a game.

g_save_spots = ztable([[
   x=02,  y=12, room=h_ban;
   x=52,  y=60, room=for_4;
   x=69,  y=17, room=cas_3;
   x=123, y=14, room=tom_2;
   x=123, y=60, room=tec_1;
]])

-- token history: 128 103 97 69 81 49 88 104 136 108 95 92 103 73 66 64 56

g_logo = ztable([[
      tl_name=logo, x=64, y=64, u=nf, d=@1, tl_max_time=2.5
   ]], function(a)
   local logo = a.logo
   local logo_opacity = 8+cos(logo.tl_tim/logo.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(192, logo.x, logo.y, 4, 2)
   fade'0'
   camera()
end
)

-- To transition rooms.
function transition(new_room_index, room_x, room_y, follow_actor)
   _g.fader_out(function()
      pause'transitioning'
   end, function()
      load_room(new_room_index, room_x, room_y, follow_actor)
      _g.fader_in(tbox_clear, unpause)
   end)
end

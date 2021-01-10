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
   0:x=4,y=4,room=R_58;
     x=6,y=5,room=R_13;
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

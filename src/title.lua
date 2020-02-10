create_actor([['title_move', 0, {'mov'}]], [[
   x=0, y=0, dx=.1, dy=.1, ax=0, ay=0, ix=1, iy=1, ixx=0, iyy=0
]])

function draw_logo(a)
   camera(-a.x*8, -a.y*8)
   -- (str, x, y, alignment, shadow_below)
   batch_call(zprint2, [[
      {@1, 0, -14, 10, 0, false}
   ]], "THE STORY OF"
   )

   if t() % 1 < .5 then
      batch_call(zprint2, [[
         {@1, -1, 9, 7, 0, true}
      ]], "PRESS 🅾️ TO START"
      )
   end

   zspr(224, 0, 0, 6, 2)
   camera()
end

-- the sound is assumed to be sfx 0!
g_title = gun_vals([[
{ x=8, y=8, prev_trans_index=@4,
   d=@5, tl_max_time=.5},
{ tl_name='outer', tl_loop=true, { i=@3, u=@2, d=@1, tl_max_time=5 } }
   ]], function(a)
      fade(g_card_fade)
      map_draw(a.x, a.y, {5,1,1})
      fade'0'

      draw_logo(a)
   end, function(a)
      batch_call(acts_loop, [[
         {'act', 'update'},
         {'mov','move'},
         {'vec','vec_update'},
         {'act', 'clean'},
         {'view','update_view'}
      ]])

      if btnp(4) then
         a.outer.tl_loop = false
         return true
      end
   end, function(a)
      g_att.transitioner(flr_rnd'20'+1, 0, 0, g_att.title_move())
   end, flr_rnd'20'+1, function(a)
      fade(8-7*a.tl_tim/a.tl_max_time)
      draw_logo(a)
      fade'0'
   end
)

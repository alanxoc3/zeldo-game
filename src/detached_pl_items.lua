create_actor([['bomb', 3, {'bounded','confined','col','mov','knockable','spr'}]], [[
   x=@1, y=@2, xf=@3,
   rx=.375,
   ry=.375,
   sind=5,
   touchable=true,
   tl_loop=false,

   {i=@4, tl_max_time=.25},
   {i=@5, tl_max_time=1.25},
   {d=@9, draw_spr=nf,draw_out=nf,i=@6, rx=1, ry=1, hit=@8, tl_max_time=.25}
]], function(a)
   -- a.xf = a.rel_act.xf
   -- a.x, a.y = a.rel_act.x+(a.rel_act.xf and -1 or 1), a.rel_act.y
   use_energy(5)
end, function(a)
   if a == g_pl.item then
      g_pl.item = nil
   end
end, function(a)
   a.rx, a.ry = .75, .75
   card_shake'8'
end, pause_energy,
function(a, other)
   if other.bomb and other.tl_cur < 3 then
      a.tl_cur = 3
      -- change my state to 3.
   end

   change_cur_ma(other)

   if other.knockable then
      local ang = atan2(other.x-a.x, other.y-a.y)
      other.knockback(other, .5, cos(ang), sin(ang))
   end

   call_not_nil(other, 'hurt', other, 15, 30)
end, function(a)
   scr_circfill(a.x, a.y, sin(a.tl_tim/.25), 8)
   scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 1)
   scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 2)
   scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 9)
   scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 10)
end
)

create_actor([['brang', 1, {'confined','anim','col','mov'}]], [[
   rel_actor=@1,
   being_held=true,
   rx=.375,
   ry=.375,
   sinds={4,260,516,772},
   anim_len=4,
   anim_spd=3,
   tl_loop=false,
   ix=.8, iy=.8,
   touchable=false,

   {hit=@2, i=@3, u=@4, tl_max_time=.125},
   {hit=@2, i=nf, u=@6, tl_max_time=.5},
   {hit=@2, i=nf, u=@5, tl_max_time=3}
]], function(a, other)
   change_cur_ma(other)
   if other.pl then
      if a.tl_cur != 1 then
         a.alive = false
      end
   elseif other.touchable then
      if other.knockable then
         other.knockback(other, .05, a.xf and -1 or 1, 0)
      end

      card_shake(9)
      if a.tl_cur < 3 then
         -- go to next state.
         a.tl_cur = 3
      end
   end
end, function(a)
   a.x, a.y = a.rel_actor.x, a.rel_actor.y
   a.xf = a.rel_actor.xf
   a.ax = a.xf and -.1 or .1
   use_energy(10)
end, function(a)
   a.ay = ybtn()*.05
   pause_energy()
end, function(a)
   pause_energy()
   amov_to_actor(a, a.rel_actor, .1)
end, function(a)
   pause_energy()
   a.ax = xbtn()*.05
   a.ay = ybtn()*.05
   if not a.being_held then
      return true
   end
end
)

create_actor([['arrow', 3, {'confined','mov','col','spr'}]], [[
   x=@1, y=@2, xf=@3,
   rx=.375,ry=.375,
   sind=23,
   touchable=false,
   i=@4,

   {hit=@5, tl_max_time=1}
]], function(a)
   a.ax = a.xf and -.1 or .1
end, function(a, other)
   if other.evil then
      change_cur_ma(other)

      call_not_nil(other, 'knockback', other, (a.cur == 1) and .3 or .1, a.xf and -1 or 1, 0)
      call_not_nil(other, 'stun', other, 30)
      call_not_nil(other, 'hurt', other, 1, 30)

      a.alive = false
   end
end
)

create_actor([['money', 4, {'bounded','confined','tcol','spr','col','mov'}]], [[
   sind=39,rx=.375,ry=.375,
   x=@1, y=@2, dx=@3, dy=@4,
   touchable=false,
   hit=@5,
   destroyed=@7,
   {tl_max_time=5},
   {i=@6}
]],
function(a, other)
   if other.pl then
      add_money'1'
      a.alive = false
   end
end, function(a)
   a.alive = false
end, function(a)
   destroy_effect(a, 9, 1, 6, 7, 13, 12)
end)

create_actor([['static_block', 4, {'confined', 'wall'}]], [[
   x=@1, y=@2, rx=@3, ry=@4,
   static=true,
   touchable=true
]]
)

create_actor([['thing_destroyed', 3, {'confined', 'mov', 'drawable', 'bounded'}]], [[
   parent=@1, c=@2, d=@5,
   {i=@4, tl_max_time=@3}
]], function(a)
   local p = a.parent
   a.x = p.x+p.ixx/8
   a.y = p.y+p.iyy/8
   a.dx = p.dx + rnd(.3)-.15
   a.dy = p.dy + rnd(.3)-.15
end, function(a)
   scr_pset(a.x, a.y, a.c)
end)

function destroy_effect(a, num, ...)
   for i=1,num do
      g_att.thing_destroyed(a, rnd_item(...), rnd(.5)+.1)
   end
end

create_actor([['pot_projectile', 3, {'col', 'confined', 'mov', 'spr', 'bounded'}]], [[
   sind=49,
   x=@1, y=@2, xf=@3,
   touchable=false,
   i=@4,
   destroyed=@6,
   hit=@7,
   { u=@5, tl_max_time=.3 }
]], function(a)
   a.ax = a.xf and -.04 or .04
end, function(a)
   a.iyy = -cos(a.tl_tim/a.tl_max_time/4)*8
end, function(a)
   sfx'9'
   destroy_effect(a, 10, 1, 13, 12)
   g_att.money(a.x, a.y, a.dx, a.dy)
end, function(a, o)
   if o.touchable and not o.pl then
      call_not_nil(o, 'hurt', o, 0, 60)
      call_not_nil(o, 'knockback', o, .6, -bool_to_num(a.xf), 0)
      a.tl_next = true
   end
end)

-- x, y, sind
create_actor([['pot', 3, {'bounded','confined','tcol','spr','col','mov'}]], [[
   static=true,
   rx=.375,ry=.375,
   x=@1, y=@2, sind=@3,
   touchable=true,
   i=@4
]], function(a)
   g_att.gen_trigger_block(a, 0, 0, .5, .5, nf, function(trig, other)
      if btnp(4) and not other.item then
         other.item = g_att.grabbed_item(g_pl, a.sind, -7, function(x, y, xf)
            g_att.pot_projectile(other.x, other.y, xf)
         end)
         a:kill()
      end
   end)
end
)

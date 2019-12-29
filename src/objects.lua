create_actor2([['money', 4, {'bounded','confined','tcol','spr','col','mov'}]], [[
   sind=39,rx=.375,ry=.375,
   x=@1, y=@2, dx=@3, dy=@4,
   touchable=false,
   hit=@5,
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
end
)

create_actor2([['static_block', 4, {'confined', 'wall'}]], [[
   x=@1, y=@2, rx=@3, ry=@4,
   static=true,
   touchable=true
]]
)

create_actor2([['pot_projectile', 3, {'confined', 'mov', 'spr', 'bounded'}]], [[
   sind=49,
   x=@1, y=@2, xf=@3,
   i=@4,
   destroyed=@6,
   { u=@5, tl_max_time=.3 }
]], function(a)
   a.ax = a.xf and -.04 or .04
end, function(a)
   a.ay = -sin(a.tl_tim/a.tl_max_time/2-.1)*.03
end, function(a)
   sfx'9'
end)

-- x, y, sind
create_actor2([['pot', 3, {'bounded','confined','tcol','spr','col','mov'}]], [[
   static=true,
   rx=.375,ry=.375,
   x=@1, y=@2, sind=@3,
   touchable=true,
   i=@4
]], function(a)
   g_att.gen_trigger_block(a, 0, 0, .5, .5, nf, function(trig, other)
      if btnp(4) and not other.item then
         other.item = create_grabbed_item(a.sind, -7, function(...)
            g_att.pot_projectile(...)
         end)
         a:kill()
      end
   end)
end
)

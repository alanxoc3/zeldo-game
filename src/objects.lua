g_att.money = function(x, y, dx, dy)
   return create_actor([[
      id='money', par={'bounded','confined','tcol','spr','col','mov'},
      att={
         sind=39,rx=.375,ry=.375,
         x=@1, y=@2,
         dx=@3, dy=@4,
         touchable=false,
         hit=@5,

         {tl_max_time=5},
         {i=@6}
      }
      ]],x,y,dx,dy,
      function(a, other)
         if other.pl then
            add_money'1'
            a.alive = false
         end
      end, function(a)
         a.alive = false
      end
   )
end

function gen_static_block(x, y, rx, ry)
   return create_actor([[
      id='rect_block', par={'confined', 'wall'},
      att={
         x=@1, y=@2, rx=@3, ry=@4,
         static=true,
         touchable=true
      }
      ]],x,y,rx,ry
   )
end

g_att.pot_projectile = function(x, y, flip)
   return create_actor([[
      id='pot_projectile', par={'confined', 'mov', 'spr', 'bounded'},
      att={
         sind=49,
         x=@1, y=@2, xf=@3, ax=@4,
         tile_hit=@5,
         destroyed=@7,
         { u=@6, tl_max_time=.3 }
      }
   ]], x, y, flip, flip and -.04 or .04, function(a)
   end, function(a)
      printh(a.tl_tim)
      a.ay=-sin(a.tl_tim/a.tl_max_time/2-.1)*.03
   end, function(a)
      sfx'9'
   end)
end

-- x, y, sind
g_att.pot = function(x, y, sind)
   return create_actor([[
      id='pot', par={'bounded','confined','tcol','spr','col','mov'},
      att={
         static=true,
         sind=@3,rx=.375,ry=.375,
         x=@1, y=@2,
         touchable=true,
         i=@4
      }
      ]],x, y, sind, function(a)
         g_att.gen_trigger_block(a, 0, 0, .5, .5, nf, function(trig, other)
            if btnp(4) and not other.item then
               other.item = create_grabbed_item(sind, -7, function(...)
                  g_att.pot_projectile(...)
               end)
               a:kill()
            end
         end)
      end
   )
end

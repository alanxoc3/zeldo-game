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
            add_money(10)
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

-- x, y, sind
g_att.pot = function(x, y, sind)
   return create_actor([[
      id='pot', par={'bounded','confined','tcol','spr','col','mov'},
      att={
         sind=@3,rx=.375,ry=.375,
         x=@1, y=@2,
         touchable=true,
         i=@4
      }
      ]],x, y, sind, function(a)
         g_att.gen_trigger_block(a, 0, 0, .5, .5, nf, function(trig, other)
            if btnp(4) and not other.item then
               other.item = create_grabbed_item(sind, -7, nf)
               a:kill()
            end
         end)
      end
   )
end

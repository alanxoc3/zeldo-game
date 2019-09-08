-- todo: trim code here.
g_att.house = function (x, y, room, rx, ry, sind)
   return create_actor([[
      id=$house$,
      att={
         x=@1, y=@2,
         room=@3, room_x=@4, room_y=@5,
         contains=@6, i=@7,
         destroyed=@8, sind=@9, hit=@10, 
         iyy=-4,
         sw=2, sh=2
      }, par={$confined$,$ospr$}
      ]],x,y,room,rx,ry,
      -- hit
      function(a, other)
         if other.pl then
            transition_room(room, rx, ry, 'u')
         end
      end, function(a)
         a.b1 = gen_static_block(a.x-.75,a.y, .25, .5)
         a.b2 = gen_static_block(a.x+.75,a.y, .25, .5)
         a.b3 = gen_static_block(a.x,a.y-5/8, 1,.25)
         a.trig = gen_trigger_block(a.x,a.y+1/8,.5,5/8,a.contains,a.hit)
      end, function(a)
         a.b1.alive, a.b2.alive, a.b3.alive, a.trig.alive = false
      end, sind or 98,
      function(a, other)
         if other.evil then
            other.knockback(other, .2, 0, 1)
         end
      end
   )
end

function gen_static_block(x, y, rx, ry)
   return create_actor([[
      id=$rect_block$,
      att={
         x=@1, y=@2, rx=@3, ry=@4,
         static=true,
         touchable=true
      },
      par={$confined$, $wall$}
      ]],x,y,rx,ry
   )
end

function gen_trigger_block(x, y, rx, ry, contains, hit)
   return create_actor([[
      id=$trigger_block$,
      att={
         x=@1, y=@2, rx=@3, ry=@4,
         static=true,
         block=true,
         touchable=false,
         contains=@5,hit=@6
      },
      par={$confined$, $col$}
      ]],x,y,rx,ry,contains,hit
   )
end

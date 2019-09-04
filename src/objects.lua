-- todo: trim code here.
g_att.house = function (x, y, room, rx, ry, sind)
   return create_actor([[
      id=$house$,
      att={
         block=true,
         x=@1, y=@2,
         iyy=-4,
         sw=2, sh=2,
         rx=.5, ry=.5,
         room=@3, room_x=@4, room_y=@5,
         sind=@10,
         static=true,
         destroyed=@9,
         touchable=false,
         d=@6, hit=@11, contains=@7, i=@8
      }, par={$confined$,$spr$,$col$}
      ]],x,y,room,rx,ry,scr_spr,
      -- hit
      function(a, other)
         if other.pl then
            transition_room(a.room, a.room_x, a.room_y, 'u')
         end
      end, function(a)
         a.b1 = gen_static_block(a.x-.75,a.y, .25, .5)
         a.b2 = gen_static_block(a.x+.75,a.y, .25, .5)
         a.b3 = gen_static_block(a.x,a.y-5/8, 1,.25)
      end, function(a)
         a.b1.alive, a.b2.alive, a.b3.alive = false
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
         block=true,
         x=@1, y=@2, rx=@3, ry=@4,
         static=true,
         touchable=true
      },
      par={$confined$, $wall$}
      ]],x,y,rx,ry
   )
end

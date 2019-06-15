-- todo: trim code here.
function gen_house(x, y, room, rx, ry, sind)
   return create_actor([[
      id=$house$,
      att={
         x=@1, y=@2,
         iyy=-4,
         sw=2, sh=2,
         rx=.5, ry=.5,
         room=@3, room_x=@4, room_y=@5,
         sind=@10,
         static=true,
         destroyed=@9,
         touchable=false
      },
      par={$confined$,$spr$,$col$},
      tl={
         {d=@6, contains=@7, i=@8}
      }
      ]],x,y,room,rx,ry,scr_spr,
      -- hit
      function(a, other)
         if other.pl then
            load_room(a.room, a.room_x, a.room_y)
         end
      end, function(a)
         a.b1 = gen_static_block(a.x-.75,a.y, .25, .5)
         a.b2 = gen_static_block(a.x+.75,a.y, .25, .5)
         a.b3 = gen_static_block(a.x,a.y-5/8, 1,.25)
      end, function(a)
         a.b1.alive, a.b2.alive, a.b3.alive = false
      end, sind or 98 
   )
end

function gen_static_block(x, y, rx, ry)
   return create_actor([[
      id=$block$,
      att={
         x=@1, y=@2, rx=@3, ry=@4,
         static=true,
         touchable=true
      },
      par={$confined$, $col$},
      tl={{hit=@5}}
      ]],x,y,rx,ry, function() end
   )
end

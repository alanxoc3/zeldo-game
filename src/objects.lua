-- todo: trim code here.
function gen_house(x, y, room)
   return create_actor([[
      id=$house$,
      att={
         x=@1, y=@2,
         iyy=-4,
         sw=2, sh=2,
         rx=.5, ry=.5,
         room=@3,
         sind=96,
         static=true,
         destroy=@7,
         touchable=false
      },
      par={$spr$,$col$},
      tl={
         {d=@4, contains=@5, i=@6, u=@8}
      }
      ]],x,y,room,scr_spr,
      -- hit
      function(a, other)
         if other.pl then
            load_room(a.room, 3, 3)
         end
      end, function(a)
         a.b1 = gen_static_block(x-.75,y, .25, .5)
         a.b2 = gen_static_block(x+.75,y, .25, .5)
         a.b3 = gen_static_block(x,y-5/8, 1,.25)
      end, function(a)
         a.b1.alive, a.b2.alive, a.b3.alive = false
      end, function(a) if btnp(4) then a.alive = false end end
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
      par={col$},
      tl={{hit=@5}}
      ]],x,y,rx,ry, function() end
   )
end

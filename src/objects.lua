-- todo: trim code here.
g_att.house = function(x, y, room, rx, ry, sind)
   return create_actor([[
      id="house",
      att={
         x=@1, y=@2,
         room=@3, room_x=@4, room_y=@5,
         contains=@6, i=@7,
         destroyed=@8, sind=@9,
         iyy=-4,
         sw=2, sh=2
      }, par={"confined","ospr"}
      ]],x,y,room,rx,ry,
      -- trigger
      function(a, other)
         if other.pl then
            transition_room(room, rx, ry, 'u')
         end
      end, function(a)
         a.b1 = gen_static_block(a.x-.75,a.y, .25, .5)
         a.b2 = gen_static_block(a.x+.75,a.y, .25, .5)
         a.b3 = gen_static_block(a.x,a.y-5/8, 1,.25)
         a.trig = gen_trigger_block(a.x,a.y+1/8,.5,5/8,a.contains)
      end, function(a)
         a.b1.alive, a.b2.alive, a.b3.alive, a.trig.alive = false
      end, sind or 98
   )
end

g_att.sign = function(x, y, text)
   return create_actor([[
      id="sign",
      att={
         sind=51,rx=.5,ry=.5,
         x=@1, y=@2,
         text=@3, i=@4
      }, par={"confined","ospr","wall"}
      ]],x,y,text,
      function(a)
         a.trig = gen_trigger_block(a.x, a.y+1, 7/8, .5, function(a, other)
            if not g_tbox_active and btnp(4) and g_selected == G_INTERACT then
               tbox(text)
            end
         end)
      end
   )
end

g_att.money = function(x, y, dx, dy)
   return create_actor([[
      id="money",
      att={
         sind=40,rx=.375,ry=.375,
         x=@1, y=@2,
         dx=@3, dy=@4,
         touchable=false,
         hit=@5,
      }, par={"bounded","confined","tcol","ospr","col","mov"},
      tl={
         {tl_tim=5},
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
      id="rect_block",
      att={
         x=@1, y=@2, rx=@3, ry=@4,
         static=true,
         touchable=true
      },
      par={"confined", "wall"}
      ]],x,y,rx,ry
   )
end

function gen_trigger_block(x, y, rx, ry, contains)
   return create_actor([[
      id="trigger_block",
      att={
         x=@1, y=@2, rx=@3, ry=@4, trigger=@5
      },
      par={"confined", "trig"}
      ]],x,y,rx,ry,contains
   )
end

g_att.arrow = function(x, y, left)
   return create_actor([[
      id="arrow",
      att={
         x=@1, y=@2,
         rx=.375,ry=.375,
         sind=42,xf=@3,
         touchable=false,
         ax=@4
      },
      par={"confined","mov","col","ospr"},
      tl={
         {hit=@5, tl_tim=3},
         {i=@6}
      }
      ]], x, y, left, left and -.1 or .1,
      -- hit
      function(a, other)
         if other.evil then
            change_cur_enemy(other)

            call_not_nil("knockback", other, (a.cur == 1) and .3 or .1, a.xf and -1 or 1, 0)
            call_not_nil("stun", other, 30)
            call_not_nil("hurt", other, 1, 30)

            a.alive = false
         end
      end,
      -- init
      function(a)
         a.alive = false
      end
   )
end

g_att.pot = function(x, y)
   return create_actor([[
      id="pot",
      att={
         sind=49,rx=.375,ry=.375,
         x=@1, y=@2,
         touchable=true,
      }, par={"bounded","confined","tcol","ospr","col","mov"},
      ]],x,y
   )
end

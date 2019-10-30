function destroy_func(a)
   g_att.money(a.x, a.y, a.dx, a.dy)
end

g_att.top = function(x, y)
   return create_actor([[
      id='top',
      att={
         name="topper",
         evil=true,
         x=@1,
         y=@2,
         rx=.375,
         ry=.375,
         iyy=-2,
         sinds={112,113},
         anim_len=1,
         touchable=true,
         destroyed=@8
      },
      par={'bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'},
      tl={
         {i=@4, hit=nf, u=nf, tl_tim=1.5},
         {i=@7, hit=nf, u=@5, tl_tim=.5},
         {i=@6, hit=@3, u=nf, tl_tim=1}
      }
      ]],x,y,
      -- hit @3
      function(a, other, ...)
         if other.pl then
            other.hurt(other, 10, 30)
         end

         if other.knockable then
            other.knockback(other, .3, ...)
         end

         if not other.block then
            tl_next(a, 1)
         end
      end,
      -- init 1 @4
      function(a)
         a.ax, a.ay = 0, 0
         a.anim_off = 0
      end,
      -- update 1 @5
      function(a)
         a.xf = g_pl.x < a.x
      end,
      -- init 2 @6
      function(a)
         amov_to_actor(a, g_pl, .06)
      end,
      function(a)
         a.anim_off = 1
      end, destroy_func
   )
end


g_att.bat = function(x, y)
   return create_actor([[
      id='bat',
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={114,115},
         anim_len=2,
         anim_spd=10,
         destroyed=@4,
         touchable=false
      },
      par={'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ax = .01
      end, destroy_func
   )
end

g_att.skelly = function(x, y)
   return create_actor([[
      id='skelly',
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={66},
         destroyed=@4,
         anim_len=1
      },
      par={'bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ay = .01
         a.ax = .005
      end, destroy_func
   )
end

g_att.ghost = function(x, y)
   return create_actor([[
      id='ghost',
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={84},
         anim_len=1,
         destroyed=@4,
         touchable=false
      },
      par={'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ax = sin(t())/50
         a.xf = sgn(a.ax) < 1
      end, destroy_func
   )
end

g_att.chicken = function(x, y)
   return create_actor([[
      id='chicken',
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={32},
         destroyed=@4,
         anim_len=1
      },
      par={'bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ay = sgn(rnd(1)-.5) * .01
         a.ax = sgn(rnd(1)-.5) * .01
         a.xf = sgn(a.ax) < 1
      end, destroy_func
   )
end

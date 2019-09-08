g_att.top = function(x, y)
   return create_actor([[
      id=$top$,
      att={
         evil=true,
         x=@1,
         y=@2,
         rx=.375,
         ry=.375,
         iyy=-2,
         sinds={120,121},
         anim_len=1,
         touchable=true
      },
      par={$bounded$,$confined$,$stunnable$,$mov$,$col$,$tcol$,$hurtable$,$knockable$,$anim$,$ospr$},
      tl={
         {d=@7, i=@4, hit=nf, u=nf, tl_tim=1.5},
         {d=@7, i=@8, hit=nf, u=@5, tl_tim=.5},
         {d=@7, i=@6, hit=@3, u=nf, tl_tim=1}
      }
      ]],x,y,
      -- hit
      function(a, other, ...)
         if other.pl then
            other.hurt(other, 10) other.stun(other, 30)
         end

         if other.knockable then
            other.knockback(other, .3, ...)
         end

         if not other.block then
            tl_next(a, 1)
         end
      end,
      -- init 1
      function(a)
         a.ax, a.ay = 0, 0
         a.anim_off = 0
      end,
      -- update 1
      function(a)
         a.xf = g_pl.x < a.x
      end,
      -- init 2
      function(a)
         amov_to_actor(a, g_pl, .06)
      end,
      scr_spr_out,
      function(a)
         a.anim_off = 1
      end
   )
end


g_att.bat = function(x, y)
   return create_actor([[
      id=$bat$,
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={122,123},
         anim_len=2,
         anim_spd=10,
         touchable=false
      },
      par={$bounded$,$confined$,$stunnable$,$mov$,$col$,$hurtable$,$knockable$,$anim$,$ospr$},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ax = .01
      end
   )
end

g_att.skelly = function(x, y)
   return create_actor([[
      id=$skelly$,
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={74},
         anim_len=1
      },
      par={$bounded$,$confined$,$stunnable$,$mov$,$col$,$tcol$,$hurtable$,$knockable$,$anim$,$ospr$},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ay = .01
         a.ax = .005
      end
   )
end

g_att.ghost = function(x, y)
   return create_actor([[
      id=$ghost$,
      att={
         evil=true,
         x=@1, y=@2,
         rx=.375, ry=.375,
         sinds={91},
         anim_len=1,
         touchable=false
      },
      par={$bounded$,$confined$,$stunnable$,$mov$,$col$,$hurtable$,$knockable$,$anim$,$ospr$},
      tl={
         {i=@3, tl_tim=1.5}
      }
      ]],x,y,
      -- init
      function(a)
         a.ax = sin(t())/50
         a.xf = sgn(a.ax) < 1
      end
   )
end

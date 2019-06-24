function get_buf_rect(buf_len)
   return {x=g_x+8, y=g_y+8, rx=buf_len, ry=buf_len}
end

function gen_spawner(x, y, func, buf_len, ...)
   local args = {...}
   return create_actor([[
         id=$spawner$,
         att={
            child=nil,
            x=@1,
            y=@2
         },
         par={$confined$,$dim$},
         tl={
            {u=@3}
         }
      ]], x, y,
      function(a)
         local acol = dim_collide(a, get_buf_rect(buf_len))
         if not a.child and acol then
            a.child = func(a.x, a.y, munpack(args))
         elseif a.child and not acol and not dim_collide(a.child, get_buf_rect(buf_len)) then
            a.child.alive = false
            a.child = nil
         end
      end)
end

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
      par={$bounded$,$confined$,$stunnable$,$mov$,$col$,$tcol$,$hurtable$,$knockable$,$anim$},
      tl={
         {d=@7, i=@4, hit=nf, u=nf, tl_tim=1.5},
         {d=@7, i=@8, hit=nf, u=@5, tl_tim=.5},
         {d=@7, i=@6, hit=@3, u=nf, tl_tim=1}
      }
      ]],x,y,
      -- hit
      function(a, other, ...)
         if other.pl then
            other.hurt(other, 1) other.stun(other, 30)
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

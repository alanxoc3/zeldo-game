function get_buf_rect(buf_len)
   return {x=g_x+8, y=g_y+8, rx=buf_len, ry=buf_len}
end

function gen_spawner(x, y, func, buf_len, ...)
   local args = {...}
   return create_actor([[
         id=$spawner$,
         att={
            child=,
            x=@1,
            y=@2
         },
         par={$dim$},
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

function gen_top(x, y)
   return create_actor([[
      id=$top$,
      att={
         x=@2,
         y=@2,
         rx=.375,
         ry=.375,
         iyy=-2,
         xb=.4,
         yb=.4,
         sind=58,
         touchable=true,
         hit=@3
      },
      par={$spr_out$,$mov$,$timed$,$col$,$tcol$,$knockable$},
      tl={
         {i=@4, t=1.5},
         {u=@5, t=.5},
         {i=@6, t=1}
      }
      ]],x,y,
      -- hit
      function(a, other, ...)
         if a.tl_curr == 3 then
            if other.pl then other.hurt(other, 1) other.stun(other, 30) end
            if other.knockable then other.knockback(other, .2, ...) end

            tl_next(a)
         end
      end,
      -- init 1
      function(a)
         a.ax, a.ay = 0, 0
      end,
      -- update 1
      function(a)
         a.xx = rnd_one()
         a.xf = g_pl.x < a.x
      end,
      -- init 2
      function(a)
         amov_to_actor(a, g_pl, .05)
      end
   )
end

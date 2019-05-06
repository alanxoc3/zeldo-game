function get_buf_rect(buf_len)
   return {x=g_x+8, y=g_y+8, rx=buf_len, ry=buf_len}
end

function gen_spawner(x, y, func, buf_len, ...)
   local args = {...}
   return create_actor([[
         id=$spawner$,
         att={
            x=@,
            y=@,
            child=,
            update=@
         },
         par={$dim$}
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
         x=@,
         y=@,
         rx=.375,
         ry=.375,
         iyy=-2,
         xb=.4,
         yb=.4,
         sind=58,
         touchable=true,
         hit=@
      },
      par={$tl$,$mov$,$timed$,$spr_out$,$col$,$tcol$,$knockable$},
      tl={
         {i=@, t=1.5},
         {u=@, t=.5},
         {i=@, t=1}
      }
      ]],x,y,
      -- hit
      function(a, other, ...)
         if a.state.current == 3 then
            if other.pl then other.hurt(other, 1) other.stun(other, 30) end
            if other.knockable then other.knockback(other, .2, ...) end

            tl_next(a.state)
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

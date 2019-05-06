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

function gen_bullet(x, y, xdir)
   return create_actor([[
      id=$deku_bullet$,
      att={
         x=@,
         y=@,
         dx=@,
         dy=0,
         rx=.3,
         ry=.3,
         sind=84,
         touchable=false,
         init=@,
         hit=@
      },
      par={$tl$,$timed$,$spr$,$col$}
      ]],
      x, y, xdir and .25 or -.25,
      function(a)
         return tl_init([[{t=.5 }, {i=@, t=.15}, {i=@}]],
            function() a.sind = 83 end,
            function() a.alive = false end 
         )
      end,
      function(a, other, ...)
         if other.pl then
            other.hurt(other, .5)
            other.stun(other, 30)
            other.knockback(other, .3, ...)

            tl_next(a.state, 3)
         end
      end)
end

function gen_deku(x, y, can_turn)
   return create_actor([[
      id=$deku$,
      att={
         x=@,
         y=@,
         rx=.5,
         ry=.5,
         sind=59,
         static=true,
         touchable=true,
         init=@
      },
      par={$tl$,$timed$,$spr_out$,$col$,$tcol$}
      ]],
      x,y,
      -- init
      function(a)
         return tl_init([[
               {u=@},
               {i=@, .833},
               {i=@, .833}
            ]], function()
               if axis_collide("y", g_pl, a) and (g_pl.x > a.x and a.xf or g_pl.x < a.x and not a.xf) then
                  gen_bullet(a.x, a.y+.125, a.xf)
                  tl_next(a.state)
                  a.xf = g_pl.x < a.x
               end
            end, function()
               a.xx, a.sind = a.xf and -1 or 1, 4
            end, function()
               a.sind = 5
            end
         )
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
         init=@,
         hit=@
      },
      par={$tl$,$mov$,$timed$,$spr_out$,$col$,$tcol$,$knockable$}
      ]],x,y,
      -- init
      function(a)
         return tl_init([[
               {i=@, t=1.5},
               {u=@, t=.5},
               {i=@, t=1}
            ]], function()
               a.ax, a.ay = 0, 0
            end, function()
               a.xx = rnd_one()
               a.xf = g_pl.x < a.x
            end, function()
               amov_to_actor(a, g_pl, .05)
            end
         )
      end,
      -- hit
      function(a, other, ...)
         if a.state.current == 3 then
            if other.pl then other.hurt(other, 1) other.stun(other, 30) end
            if other.knockable then other.knockback(other, .2, ...) end

            tl_next(a.state)
         end
      end)
end

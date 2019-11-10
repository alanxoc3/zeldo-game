function create_bomb(pl)
   return create_actor([[
      id='lank_bomb', par={'bounded','confined','col','mov','knockable','spr'},
      att={
         rx=.375,
         ry=.375,
         sind=5,
         touchable=true,
         tl_loop=false,
         xf=@1,

         {i=@2, u=@5, tl_max_time=.25},
         {i=@3, tl_max_time=1.25},
         {d=@7, draw_spr=nf,draw_out=nf,i=@4, rx=1, ry=1, hit=@6, tl_max_time=.25}
      }
      ]],
      pl.xf,
      function(a)
         a.x, a.y = pl.x+(pl.xf and -1 or 1), pl.y
         use_energy(5)
      end,
      function(a)
         if a == g_pl.item then
            g_pl.item = nil
         end
      end,
      function(a)
         a.rx, a.ry = .75, .75
         card_shake'8'
      end, pause_energy,
      function(a, other)
         if other.lank_bomb and other.tl_cur < 3 then
            a.tl_cur = 3
            -- change my state to 3.
         end

         change_cur_ma(other)

         if other.knockable then
            local ang = atan2(other.x-a.x, other.y-a.y)
            other.knockback(other, .5, cos(ang), sin(ang))
         end

         call_not_nil('hurt', other, 15, 30)
      end, function(a)
         scr_circfill(a.x, a.y, sin(a.tl_tim/.25), 8)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 1)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 2)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 9)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 10)
      end
   )
end

function create_brang(pl)
   return create_actor([[
      id='lank_brang', par={'confined','anim','col','mov'},
      att={
         being_held=true,
         rx=.375,
         ry=.375,
         sinds={4,260,516,772},
         anim_len=4,
         anim_spd=3,
         tl_loop=false,
         xf=@1,
         ix=.8,
         iy=.8,
         touchable=false,

         {hit=@2, i=@3, u=@4, tl_max_time=.125},
         {hit=@2, i=nf, u=@6, tl_max_time=.5},
         {hit=@2, i=nf, u=@5, tl_max_time=3}
      }
      ]],
      pl.xf,
      -- hit
      function(a, other)
         change_cur_ma(other)
         if other.pl then
            if a.tl_cur != 1 then
               a.alive = false
            end
         elseif other.touchable then
            if other.knockable then
               other.knockback(other, .05, a.xf and -1 or 1, 0)
            end

            card_shake(9)
            if a.tl_cur < 3 then
               -- go to next state.
               a.tl_cur = 3
            end
         end
      end,
      -- init 1
      function(a)
         a.x, a.y = pl.x, pl.y
         a.ax = a.xf and -.1 or .1
         use_energy(10)
      end,
      -- update 1
      function(a)
         a.ay = ybtn()*.05
         pause_energy()
      end,
      -- update 2
      function(a)
         pause_energy()
         amov_to_actor(a, pl, .1)
      end,
      -- update 3
      function(a)
         pause_energy()
         a.ax = xbtn()*.05
         a.ay = ybtn()*.05
         if not a.being_held then
            return true
         end
      end
      )
end

g_att.arrow = function(x, y, left)
   local ace = create_actor([[
      id='arrow', par={'confined','mov','col','spr'},
      att={
         x=@1, y=@2,
         rx=.375,ry=.375,
         sind=23,xf=@3,
         touchable=false,
         ax=@4,

         {hit=@5, tl_max_time=1}
      }
      ]], x, y, left, left and -.1 or .1,
      -- hit
      function(a, other)
         if other.evil then
            change_cur_ma(other)

            call_not_nil('knockback', other, (a.cur == 1) and .3 or .1, a.xf and -1 or 1, 0)
            call_not_nil('stun', other, 30)
            call_not_nil('hurt', other, 1, 30)

            a.alive = false
         end
      end
   )

   return ace
end

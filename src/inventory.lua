G_INTERACT = 5

function act_poke(a, ix1, ix2)
   if a.poke > 0 then
      a.poke -= 1
      a.ixx = a.xf and ix1 or -ix1
   else
      a.ixx = a.xf and ix2 or -ix2
   end
end

function create_bomb(pl)
   return create_actor([[
      id='lank_bomb',
      att={
         rx=.375,
         ry=.375,
         sind=5,
         touchable=true,
         tl_loop=false,
         xf=@1
      },
      par={'bounded','confined','item','col','mov','knockable','spr'},
      tl={
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
      id='lank_brang',
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
         touchable=false
      },
      par={'item','anim','col','mov'},
      tl={
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

function create_banjo(pl)
   return create_actor([[
      id='lank_banjo',
      att={
         being_held=true,
         rx=.3,
         ry=.3,
         sind=1,
         xf=@1,
         touchable=false,
         i=@2, u=@3
      },
      par={'item','rel','col'}
      ]],
      pl.xf,
      -- init 1
      function(a)
         -- a.rel_x=a.xf and 2/8 or -2/8
         a.rel_y=0
      end,
      -- update 1
      function(a)
         if not a.being_held then
            a.alive, pl.item = false
         end
      end
   )
end

function create_shovel(pl)
   return create_actor([[
      id='lank_shovel',
      att={
         being_held=true,
         rx=.3,
         ry=.3,
         sind=3,
         xf=@1,
         touchable=false,
         i=@2, u=@3
      },
      par={'item','rel'}
      ]],
      not pl.xf,
      -- init 1
      function(a) 
         a.rel_x=a.xf and 5/8 or -5/8
         a.rel_y=0
      end,
      -- update 1
      function(a)
         local val = mget(a.x,a.y)
         if val == 58 or val == 59 or val == 60 or val == 76 or val == 77 then
            mset(a.x, a.y, 73)
         end

         if not a.being_held then
            a.alive, pl.item = false
         end
      end
   )
end

-- teleports to different places
function create_force(pl)
   return create_actor([[
      id='lank_force',
      att={
         being_held=true,
         rx=.3,
         ry=.3,
         sind=36,
         xf=@1,
         destroyed=@2,
         u=@3,
         touchable=false
      },
      par={'item','rel'}
      ]], pl.xf, function(a)
         -- random room index
         local i = flr(rnd(5))+1
         transition_room(g_save_spots[i].room, g_save_spots[i].x, g_save_spots[i].y)
      end, function(a)
         if not a.being_held then
            a.alive = false
         end
      end
   )
end

function create_bow(pl)
   return create_actor([[
      id='lank_bow',
      att={
         being_held=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-1,
         sind=7,
         xf=@1,
         destroyed=@5,
         touchable=false
      },
      par={'item','rel'},
      tl={
         {i=@2, u=@3, tl_max_time=.4},
         {i=nf, u=@4}
      }
      ]],
      pl.xf,
      -- init 1
      function(a)
         a.rel_dx = a.xf and -.125 or .125
         a.ixx = a.xf and -1 or 1
         a.poke = 20
         use_energy(5)
      end,
      -- update 1
      function(a)
         act_poke(a, -1, 0)
         local dist = 3/8
         if abs(a.rel_dx + a.rel_x) < dist then
            a.rel_x += a.rel_dx
         else
            local neg_one = -dist
            a.rel_dx, a.rel_x = 0, a.xf and neg_one or dist
         end
         pause_energy()
      end,
      -- update 2
      function(a)
         act_poke(a, -1, 0)
         if not a.being_held then
            a.alive, pl.item = false
         end
         pause_energy()
      end, function(a)
         if remove_money(1) then
            sfx'6'
            g_att.arrow(a.x, a.y, a.xf)
         end
      end
   )
end

-- sword and shield
function sword_shield_hit(a, o)
   if o.evil then
      a.poke = a.poke_val
      if a.tl_cur != 1 then
         use_energy(a.energy)
      end
      change_cur_ma(o)
      call_not_nil('hurt', o, (a.tl_cur == 1) and (a.o_hurt*2) or a.o_hurt, 30)
   end

   if o.knockable and not o.pl then
      o.knockback(o, (a.tl_cur == 1) and (a.o_knock*2) or a.o_knock, a.xf and -1 or 1, 0)
      g_pl.knockback(g_pl, a.pl_knock, a.xf and 1 or -1, 0)
   end
end

function sword_shield_u1(a)
   act_poke(a, a.poke_beg, a.poke_end)
   if abs(a.rel_dx + a.rel_x) < a.dist then
      a.rel_x += a.rel_dx
   else
      a.rel_dx, a.rel_x = 0, a.xf and -a.dist or a.dist
   end
   pause_energy()
end

function sword_shield_i1(a, energy, number, xfspeed)
   a.rel_dx = a.xf and -xfspeed or xfspeed
   a.ixx = a.xf and -number or number
   use_energy(energy)
end

function sword_shield_u2(a)
   act_poke(a, a.poke_beg, a.poke_end)
   if not a.being_held then
      a.alive, g_pl.item = false
   end
   pause_energy()
end

function create_sword(pl)
   return create_actor([[
      id='lank_sword',
      att={
         max_stun_val=20,
         min_stun_val=10,
         energy=10,
         poke_val=10,
         pl_knock=.3,
         o_knock=.1,
         o_hurt=5,
         poke_beg=-1,
         poke_end=0,
         dist=1,
         being_held=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=2,
         poke=20,
         xf=@1,
         touchable=false
      },
      par={'item','rel','col'},
      tl={
         {hit=@2, i=@3, u=@4, tl_max_time=.4},
         {hit=@2, i=nf, u=@5}
      }
      ]],
      pl.xf, sword_shield_hit,
      function(a)
         sword_shield_i1(a, 20, 1, .125)
      end, sword_shield_u1, sword_shield_u2
   )
end

function create_shield(pl)
   return create_actor([[
      id='lank_shield',
      att={
         max_stun_val=60,
         min_stun_val=0,
         energy=2,
         poke_val=10,
         pl_knock=.1,
         o_knock=.2,
         o_hurt=0,
         poke_beg=0,
         poke_end=1,
         dist=.625,
         block=true,
         being_held=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         poke=20,
         sind=6,
         xf=@1,
         poke=20,
         touchable=false
      },
      par={'item','rel','col'},
      tl={
         {hit=@2, i=@3, u=@4, tl_max_time=.4},
         {hit=@2, i=nf, u=@5}
      }
   ]],
      pl.xf, sword_shield_hit,
      function(a)
         sword_shield_i1(a, 10, 3, .625/10)
      end, sword_shield_u1, sword_shield_u2
   )
end


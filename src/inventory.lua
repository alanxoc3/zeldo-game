G_INTERACT = 5

function act_poke(a, ix1, ix2)
   if a.poke > 0 then
      a.poke -= 1
      a.ixx = a.xf and ix1 or -ix1
   else
      a.ixx = a.xf and ix2 or -ix2
   end
end

function create_banjo(pl)
   return create_actor([[
      id='lank_banjo', par={'item','rel','col'},
      att={
         being_held=true,
         rx=.3,
         ry=.3,
         sind=1,
         xf=@1,
         touchable=false,
         i=@2, u=@3
      }
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
      id='lank_shovel', par={'item','rel'},
      att={
         being_held=true,
         rx=.3,
         ry=.3,
         sind=3,
         xf=@1,
         touchable=false,
         i=@2, u=@3
      }
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
      id='lank_force', par={'item','rel'},
      att={
         being_held=true,
         rx=.3,
         ry=.3,
         sind=36,
         xf=@1,
         destroyed=@2,
         u=@3,
         touchable=false
      }
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
      id='lank_bow', par={'item','rel'},
      att={
         being_held=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-1,
         sind=7,
         xf=@1,
         destroyed=@5,
         touchable=false,

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
      id='lank_sword', par={'item','rel','col'},
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
         touchable=false,

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
      id='lank_shield', par={'item','rel','col'},
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
         touchable=false,

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


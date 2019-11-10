create_parent(
[[ id='bashable', par={'rel', 'knockable', 'col'},
   att={
      bash_dx=1,
      rel_bash_dx=1,
      hit=@1, bash=@1
   }
]], function(a, o)
   if o != a.rel_actor then
      call_not_nil('knockback', o, a.bash_dx, -bool_to_num(a.xf), 0)
      if a.rel_actor then
         call_not_nil('knockback', a.rel_actor, a.rel_bash_dx, bool_to_num(a.xf), 0)
      end
   end
end
)

create_parent(
[[ id='item', par={'rel', 'confined','spr_obj'},
   att={being_held=true, destroyed=@1}
]], function(a)
   if a == a.rel_actor.item then a.rel_actor.item = nil end
end)

create_parent(
[[ id='hittable_item', par={'item'},
   att={destroyed=@1}
]], function(a)
   if a == a.rel_actor.item then a.rel.item = nil end
end)

function act_poke_init(a, dx, ixx, poke)
   a.xf = a.rel_actor.xf
   a.rel_dx = a.xf and -dx or dx
   a.ixx = a.xf and -ixx or ixx
   a.poke = poke
end

function item_check_being_held(a)
   if not a.being_held then a.alive = false end
end

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
      id='lank_banjo', par={'item'},
      att={
         rx=.3,
         ry=.3,
         sind=1,
         rel_actor=@1,
         xf=@2,
         touchable=false,
         destroyed=@4,

         {i=@3, tl_max_time=4}
      }
      ]], pl, pl.xf,
      -- init 1
      function(a)
         a.rel_y=0
         sfx'11'
      end, function(a)
         sfx'-1'
      end
   )
end

function create_shovel(pl)
   return create_actor([[
      id='lank_shovel', par={'item'},
      att={
         rx=.3,
         ry=.3,
         sind=3,
         touchable=false,
         i=@2, u=@3,
         rel_actor=@1
      }
      ]], pl,
      -- init 1
      function(a)
         act_poke_init(a, .625, 0, 20)
      end,
      -- update 1
      function(a)
         if fget(mget(a.x,a.y), 7) then
            mset(a.x, a.y, 73)
         end

         item_check_being_held(a)
      end
   )
end

-- -- teleports to different places
-- function create_force(pl)
--    return create_actor([[
--       id='lank_force', par={'item'},
--       att={
--          rx=.3,
--          ry=.3,
--          sind=36,
--          xf=@2,
--          destroyed=@3,
--          u=@4,
--          rel_actor=@1,
--          touchable=false
--       }
--       ]], g_pl, pl.xf, function(a)
--          -- random room index
--          local i = flr(rnd(5))+1
--          transition_room(g_save_spots[i].room, g_save_spots[i].x, g_save_spots[i].y)
--       end, function(a)
--          item_check_being_held(a)
--       end
--    )
-- end

function create_bow(pl)
   return create_actor([[
      id='lank_bow', par={'item'},
      att={
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-1,
         sind=7,
         destroyed=@5,
         touchable=false,
         rel_actor=@1,

         {i=@2, u=@3, tl_max_time=.4},
         {i=nf, u=@4}
      }
      ]], g_pl,
      -- init 1
      function(a)
         act_poke_init(a, .125, 1, 20)
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
         item_check_being_held(a)
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
function sword_hit(a, o)
   if o != a.rel_actor then
      a.poke = a.poke_val
      if a.tl_cur != 1 then use_energy(a.energy) end
      change_cur_ma(o)
      call_not_nil('hurt', o, a.hurt_amount, 30)
   end

   a.bash(a, o)
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
   act_poke_init(a, xfspeed, number, 20)
   use_energy(energy)
end

function sword_shield_u2(a)
   act_poke(a, a.poke_beg, a.poke_end)
   item_check_being_held(a)
   pause_energy()
end

function create_sword(pl)
   return create_actor([[
      id='lank_sword', par={'item','col','bashable'},
      att={
         rel_bash_dx=.4,
         max_stun_val=20,
         min_stun_val=10,
         energy=10,
         poke_val=10,
         poke_beg=-1,
         poke_end=0,
         dist=1,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=2,
         xf=@2,
         touchable=false,
         rel_actor=@1,

         {hurt_amount=5, bash_dx=.3, hit=@3, i=@4, u=@5, tl_max_time=.4},
         {hurt_amount=2,  bash_dx=.1, hit=@3, i=nf, u=@6}
      }
      ]], g_pl,
      pl.xf, sword_hit,
      function(a)
         sword_shield_i1(a, 20, 1, .125)
      end, sword_shield_u1, sword_shield_u2
   )
end

function create_shield(pl)
   return create_actor([[
      id='lank_shield', par={'item','bashable'},
      att={
         rel_bash_dx=.1,
         max_stun_val=60,
         min_stun_val=0,
         energy=2,
         poke_val=10,
         o_hurt=0,
         poke_beg=0,
         poke_end=1,
         dist=.625,
         block=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         sind=6,
         touchable=false,
         rel_actor=@1,

         {bash_dx=.4, i=@2, u=@3, tl_max_time=.4},
         {bash_dx=.2, i=nf, u=@4}
      }
   ]], pl, function(a)
         sword_shield_i1(a, 10, 3, .625/10)
      end, sword_shield_u1, sword_shield_u2
   )
end

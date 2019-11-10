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
[[ id='pokeable', par={'rel','drawable_obj','item'},
   att={i=@1, poke_init=@1, poke=20, poke_energy=0}
]], function(a)
   a.xf = a.rel_actor.xf
   use_energy(a.poke_energy)
end)

function item_check_being_held(a)
   if not a.being_held then a.alive = false end
   pause_energy()
end

function act_poke(a, dist)
   if a.poke > 0 then a.poke -= 1 end
   a.ixx = a.xf and a.poke_ixx or -a.poke_ixx

   local spd = dist/a.tl_max_time/FPS
   if spd + abs(a.rel_x) < dist then
      a.rel_dx = a.xf and -spd or spd
   else
      a.rel_dx = 0
      a.rel_x = a.xf and -dist or dist
   end
   pause_energy()
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
      id='lank_shovel', par={'item','pokeable'},
      att={
         rx=.3, ry=.3,
         sind=3,
         touchable=false,
         u=@2,
         rel_actor=@1
      }
      ]], pl, function(a)
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
      id='lank_bow', par={'item','pokeable'},
      att={
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-1,
         sind=7,
         destroyed=@4,
         touchable=false,
         rel_actor=@1,
         poke_energy=5,
         poke_ixx=1,

         {u=@2, tl_max_time=.1},
         {i=nf, u=@3}
      }
      ]], g_pl, function(a) -- update 1
         act_poke(a, .5)
      end, function(a) -- update 2
         item_check_being_held(a)
      end, function(a) -- destroyed
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

   a:bash(o)
end

function sword_shield_u1(a)
   act_poke(a, a.dist)
end

function sword_shield_u2(a)
   item_check_being_held(a)
end

function create_sword(pl)
   return create_actor([[
      id='lank_sword', par={'item','col','bashable','pokeable'},
      att={
         rel_bash_dx=.4,
         max_stun_val=20,
         min_stun_val=10,
         energy=10,
         poke_val=10,
         dist=1,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=2,
         touchable=false,
         rel_actor=@1,
         poke_energy=15,
         poke_ixx=2,

         {hurt_amount=5, bash_dx=.3, hit=@2, u=@3, tl_max_time=.1},
         {hurt_amount=2,  bash_dx=.1, hit=@2, i=nf, u=@4}
      }
      ]], g_pl, sword_hit, sword_shield_u1, sword_shield_u2
   )
end

function create_shield(pl)
   return create_actor([[
      id='lank_shield', par={'item','bashable','pokeable'},
      att={
         rel_bash_dx=.1,
         max_stun_val=60,
         min_stun_val=0,
         energy=2,
         poke_val=10,
         o_hurt=0,
         dist=.625,
         block=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         sind=6,
         touchable=false,
         rel_actor=@1,
         poke_energy=10,
         poke_ixx=0,

         {bash_dx=.4, u=@2, tl_max_time=.1},
         {bash_dx=.2, i=nf, u=@3}
      }
   ]], pl, sword_shield_u1, sword_shield_u2
   )
end

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
   att={
      i=@1,
      u=@2,
      e=@3,
      poke_init=@1,
      poke_update=@2,
      poke_end=@3,
      poke=20,
      poke_dist=20,
      poke_energy=0
   }
]], function(a) -- i
   a.xf = a.rel_actor.xf
   a.ixx = a.xf and a.poke_ixx or -a.poke_ixx
   use_energy(a.poke_energy)
end, function(a) -- u
   local spd = a.poke_dist/a.tl_max_time/FPS
   a.rel_dx = a.xf and -spd or spd
   pause_energy()
end, function(a) -- e
   a.rel_dx = 0
   a.rel_x = a.xf and -a.poke_dist or a.poke_dist
end
)

function item_check_being_held(a)
   if not a.being_held then a.alive = false end
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
         initial_xf=@2,
         touchable=false,
         destroyed=@4,

         {tl_name='loop', i=@3, u=@5, tl_max_time=4}
      }
      ]], pl, pl.xf,
      -- init 1
      function(a)
         a.rel_y=0
         sfx'11'
      end, function(a)
         sfx'-1'
      end, function(a)
         g_pl.sind=144
         if sin(a.loop.tl_tim*2) > 0 then
            g_pl.ltop.sind = 149
         else
            g_pl.ltop.sind = 147
         end

         if a.initial_xf then
            g_pl.xf = cos(a.loop.tl_tim) > 0
         else
            g_pl.xf = -cos(a.loop.tl_tim) > 0
         end
         g_pl.ltop.xf = g_pl.xf
         a.xf = not g_pl.xf
      end
   )
end

function create_shovel(pl)
   return create_actor([[
      id='lank_shovel', par={'item','bashable','pokeable'},
      att={
         rx=.3, ry=.3,
         sind=3,
         touchable=false,
         rel_actor=@1,
         poke_energy=5,
         poke_ixx=1,
         poke_dist=.75,
         rel_bash_dx=.185,
         bash_dx=.1,
         did_hit=false,
         hit=@4,

         {tl_max_time=.1},
         {i=nf, u=@2, e=nf, tl_max_time=.25},
         {i=@3, u=@2, e=nf, tl_max_time=.25}
      }
      ]], pl, function(a)
         pause_energy()
      end, function(a)
         --a.xf = not a.xf
         a.yf = true
         --a.rel_x += sgn(-a.rel_x)*.125
         a.rel_y = -.25
         a:bash()

         if not a.did_hit and fget(mget(a.x,a.y), 7) then
            mset(a.x, a.y, 73)
            sfx'6'
         else
            sfx'9'
         end
      end, function(a, o)
         a.did_hit = o.touchable and o != a.rel_actor
      end
   )
end

function create_bow(pl)
   return create_actor([[
      id='lank_bow', par={'item','pokeable'},
      att={
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-1,
         sind=7,
         destroyed=@3,
         touchable=false,
         rel_actor=@1,
         poke_energy=5,
         poke_ixx=1,
         poke_dist=.5,

         {tl_max_time=.1},
         {e=nf, i=nf, u=@2}
      }
      ]], g_pl, function(a) -- update 2
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
         poke_dist=1,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=2,
         touchable=false,
         rel_actor=@1,
         poke_energy=15,
         poke_ixx=2,

         {hurt_amount=5, bash_dx=.3, hit=@2, tl_max_time=.1},
         {i=nf, u=@3, e=nf, hurt_amount=2,  bash_dx=.1, hit=@2}
      }
      ]], g_pl, sword_hit, sword_shield_u2
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
         poke_dist=.625,
         block=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         sind=6,
         touchable=false,
         rel_actor=@1,
         poke_energy=10,
         poke_ixx=0,

         {bash_dx=.4, tl_max_time=.1},
         {i=nf, u=@2, e=nf, bash_dx=.2}
      }
   ]], pl, sword_shield_u2
   )
end

-- TODO: Force is outdated. Update me please.
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

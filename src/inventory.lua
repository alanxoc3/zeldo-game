create_parent(
[[ 'bashable', {'rel', 'knockable', 'col'},
   {
      bash_dx=1,
      rel_bash_dx=1,
      hit=@1, bash=@1
   }
]], function(a, o)
   if o != a.rel_actor then
      call_not_nil(o, 'knockback', o, a.bash_dx, -bool_to_num(a.xf), 0)
      if a.rel_actor then
         call_not_nil(a.rel_actor, 'knockback', a.rel_actor, a.rel_bash_dx, bool_to_num(a.xf), 0)
      end
   end
end
)

create_parent(
[[ 'item', {'rel', 'confined', 'spr_obj'},
   {being_held=true, destroyed=@1}
]], function(a)
   if a == a.rel_actor.item then a.rel_actor.item = nil end
end)

create_parent(
[[ 'pokeable', {'rel','drawable_obj','item'},
   {
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

create_actor([['banjo', 1, {'item','unpausable','danceable'}]], [[
   rel_actor=@1,
   rx=.3,
   ry=.3,
   sind=1,
   touchable=false,
   destroyed=@3,
   {tl_name='loop', i=@2, tl_max_time=4.25}
]], function(a)
   a.rel_y = 0
   a.xf = a.rel_actor.xf
   -- echo effect :)
   poke(0x5f41, 15)
   if zdget(BANJO_TUNED) then
      sfx'11'
   else
      sfx'10'
   end
   pause('dancing')
end, function(a)
   unpause()
   poke(0x5f41, 0)
end
)

create_actor([['shovel', 1, {'item','bashable','pokeable'}]], [[
   rel_actor=@1,
   rx=.3, ry=.3,
   sind=3, touchable=false,
   poke_energy=5, poke_ixx=1,
   poke_dist=.75, rel_bash_dx=.185,
   bash_dx=.1,
   did_hit=false,
   hit=@4,

   {tl_max_time=.1},
   {i=nf, u=@2, e=nf, tl_max_time=.25},
   {i=@3, u=@2, e=nf, tl_max_time=.25}
]], function(a)
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

create_actor([['bow', 1, {'item','pokeable'}]], [[
   rel_actor=@1,
   rx=.5,
   ry=.375,
   rel_y=0,
   iyy=-1,
   sind=7,
   destroyed=@3,
   touchable=false,
   poke_energy=5,
   poke_ixx=1,
   poke_dist=.5,

   {tl_max_time=.1},
   {e=nf, i=nf, u=@2}
]], function(a) -- update 2
   item_check_being_held(a)
end, function(a) -- destroyed
   if remove_money(1) then
      sfx'6'
      g_att.arrow(a.x, a.y, a.xf)
   end
end
)

-- sword and shield
function sword_hit(a, o)
   if o != a.rel_actor then
      a.poke = a.poke_val
      if a.tl_cur != 1 then use_energy(a.energy) end
      change_cur_ma(o)
      call_not_nil(o, 'hurt', o, a.hurt_amount, 30)
   end

   a:bash(o)
end

function sword_shield_u2(a)
   item_check_being_held(a)
end

create_actor([['sword', 1, {'item','col','bashable','pokeable'}]], [[
   rel_actor=@1,
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
   poke_energy=15,
   poke_ixx=2,

   {hurt_amount=5, bash_dx=.3, hit=@2, tl_max_time=.1},
   {i=nf, u=@3, e=nf, hurt_amount=2,  bash_dx=.1, hit=@2}
]], sword_hit, sword_shield_u2)

create_actor([['shield', 1, {'item','bashable','pokeable'}]], [[
   rel_actor=@1,
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
   poke_energy=10,
   poke_ixx=0,

   {hit=@2, bash_dx=.4, tl_max_time=.1},
   {u=@3, tl_max_time=.1},
   {hit=@2, i=nf, u=@3, e=nf, bash_dx=.2}
]], function(a, other)
   if other != a.rel_actor and a.tl_cur < 3 then
      call_not_nil(other, 'hurt', other, 0, 30)
   end
   a:bash(other)
end, sword_shield_u2)

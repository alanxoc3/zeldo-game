-- SECTION: DETACHED PL ITEMS
-- TODO: uncomment when tokens
-- create_actor([['arrow', 3, {'confined','mov','col','spr'}]], [[
--    x=@1, y=@2, xf=@3,
--    rx=.375,ry=.375,
--    sind=23,
--    touchable=false,
--    i=@4,
-- 
--    {hit=@5, tl_max_time=1}
-- ]], function(a)
--    a.ax = a.xf and -.1 or .1
-- end, function(a, other)
--    if other.evil then
--       change_cur_ma(other)
-- 
--       call_not_nil(other, 'knockback', other, (a.cur == 1) and .3 or .1, a.xf and -1 or 1, 0)
--       call_not_nil(other, 'stun', other, 30)
--       call_not_nil(other, 'hurt', other, 1, 30)
-- 
--       a.alive = false
--    end
-- end
-- )

-- TODO: uncomment when tokens go down & bombs are supported.
-- create_actor([['bomb', 3, {'bounded','confined','col','mov','knockable','spr'}]], [[
--    x=@1, y=@2, xf=@3,
--    rx=.375,
--    ry=.375,
--    sind=5,
--    touchable=true,
--    tl_loop=false,
-- 
--    {i=@4, tl_max_time=.25},
--    {i=@5, tl_max_time=1.25},
--    {d=@9, draw_spr=nf,draw_out=nf,i=@6, rx=1, ry=1, hit=@8, tl_max_time=.25}
-- ]], function(a)
--    -- a.xf = a.rel_act.xf
--    -- a.x, a.y = a.rel_act.x+(a.rel_act.xf and -1 or 1), a.rel_act.y
--    use_energy(5)
-- end, function(a)
--    if a == g_pl.item then
--       g_pl.item = nil
--    end
-- end, function(a)
--    a.rx, a.ry = .75, .75
--    card_shake'8'
-- end, pause_energy,
-- function(a, other)
--    if other.bomb and other.tl_cur < 3 then
--       a.tl_cur = 3
--       -- change my state to 3.
--    end
-- 
--    change_cur_ma(other)
-- 
--    if other.knockable then
--       local ang = atan2(other.x-a.x, other.y-a.y)
--       other.knockback(other, .5, cos(ang), sin(ang))
--    end
-- 
--    call_not_nil(other, 'hurt', other, 15, 30)
-- end, function(a)
--    scr_circfill(a.x, a.y, sin(a.tl_tim/.25), 8)
--    scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 1)
--    scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 2)
--    scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 9)
--    scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tl_tim/.25)*rnd(.25)+.25, 10)
-- end
-- )

create_actor([['brang', 1, {'confined','anim','col','mov', 'tcol'}]], [[
   did_brang_hit=false,
   tile_solid=false,
   rel_actor=@1,
   being_held=true,
   rx=.375,
   ry=.375,
   sinds={4,260,516,772},
   anim_len=4,
   anim_spd=3,
   ix=.8, iy=.8,
   touchable=false,
   tile_hit=@10,
   item_slow=true,

   {i=@2, hit=@3, u=@4, tl_max_time=.1},
   {i=nf, hit=@5, u=@6, tl_max_time=.75},
   {ax=0, ay=0, dx=0, dy=0, i=@9, hit=nf, u=@4, tl_max_time=.15},
   {i=nf, hit=@7, u=@8, tl_max_time=3}
]], function(a) -- init 1
   a.x, a.y = a.rel_actor.x, a.rel_actor.y
   a.xf = a.rel_actor.xf
   a.ax = a.xf and -.1 or .1
   use_energy(10)
end, function(a, other) -- hit 1
   if not other.pl and other.touchable and not a.did_brang_hit then
      call_not_nil(other, 'knockback', other, .3, a.xf and -1 or 1, 0)
      call_not_nil(other, 'hurt', other, 0, 60)
      a.did_brang_hit = true
   end
end, function(a) -- update 1
   pause_energy()
end, function(a, other) -- hit 2
   if other.pl then
      a.alive = false
   elseif other.touchable and not a.did_brang_hit then
      call_not_nil(other, 'knockback', other, .3, a.xf and -1 or 1, 0)
      call_not_nil(other, 'hurt', other, 0, 60)
      a.did_brang_hit = true
   end
end, function(a) -- update 2
   pause_energy()
   a.ax = xbtn()*.05
   a.ay = ybtn()*.05
   return not a.being_held or a.did_brang_hit
end, function(a, other) -- hit 3
   if other.pl then
      a.alive = false
   elseif other.touchable and not a.did_brang_hit then
      if other.knockable then
         other.knockback(other, .05, a.xf and -1 or 1, 0)
      end
      a.did_brang_hit = true
   end
end, function(a) -- update 3
   pause_energy()
   amov_to_actor(a, a.rel_actor, .1)
end, function(a)
   if a.did_brang_hit then
      card_shake(9)
   end
end, function(a)
   a.did_brang_hit = true
end
)

-- SECTION: INVENTORY
create_actor([['banjo', 1, {'item','unpausable','danceable'}]], [[
   rel_actor=@1,
   rx=.3,
   ry=.3,
   sind=1,
   touchable=false,
   item_stop=true,
   e=@3,
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

-- TODO: uncomment when tokens
-- create_actor([['shovel', 1, {'item','bashable','pokeable'}]], [[
--    rel_actor=@1,
--    rx=.3, ry=.3,
--    sind=3, touchable=false,
--    poke_energy=5, poke_ixx=1,
--    poke_dist=.75, rel_bash_dx=.185,
--    bash_dx=.1,
--    did_hit=false,
--    hit=@4,
-- 
--    {tl_max_time=.1},
--    {i=nf, u=@2, e=nf, tl_max_time=.25},
--    {i=@3, u=@2, e=nf, tl_max_time=.25}
-- ]], function(a)
--    pause_energy()
-- end, function(a)
--    --a.xf = not a.xf
--    a.yf = true
--    --a.rel_x += sgn(-a.rel_x)*.125
--    a.rel_y = -.25
--    a:bash()
-- 
--    if not a.did_hit and fget(mget(a.x,a.y), 7) then
--       mset(a.x, a.y, 73)
--       sfx'6'
--    else
--       sfx'9'
--    end
-- end, function(a, o)
--    a.did_hit = o.touchable and o != a.rel_actor
-- end
-- )

-- create_actor([['bow', 1, {'item','pokeable'}]], [[
--    rel_actor=@1,
--    rx=.5,
--    ry=.375,
--    rel_y=0,
--    iyy=-1,
--    sind=7,
--    destroyed=@3,
--    touchable=false,
--    poke_energy=5,
--    poke_ixx=1,
--    poke_dist=.5,
-- 
--    {tl_max_time=.1},
--    {e=nf, i=nf, u=@2}
-- ]], function(a) -- update 2
--    item_check_being_held(a)
-- end, function(a) -- destroyed
--    if remove_money(1) then
--       sfx'6'
--       g_att.arrow(a.x, a.y, a.xf)
--    end
-- end
-- )

create_actor([['sword', 1, {'item','col','bashable','pokeable'}]], [[
   item_slow=true,
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
   item_slow=true,
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

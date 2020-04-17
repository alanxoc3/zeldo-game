-- SECTION: MONSTERS
create_actor([['slimy', 2, {'drawable','bounded','danceable','confined','stunnable','mov','col','tcol','hurtable','knockable','spr_obj', 'spr'}]], [[
   x=@1, y=@2,
   max_health=3, health=3,
   name="slimy", evil=true, tl_loop=true,
   rx=.25, ry=.25,
   iyy=-2,
   sind=118,
   anim_len=1,
   touchable=true,
   hurt_func=@9,

   {i=@5, hit=nf, u=@8, tl_max_time=3},
   {i=nf, hit=nf, u=@3, e=@6, tl_max_time=.25},
   {i=nf, hit=@7, u=@4, e=@6, tl_max_time=.25},
]], function(a)
   look_at_pl(a)
   a.ixx = rnd_one()
end, function(a) -- init 1 @4
   amov_to_actor(a, g_pl, .05)
   a.iyy += sin(a.tl_tim/a.tl_max_time)
   a.sind=119
end, function(a)
   a[1].tl_max_time = rnd(2)+1
   a.ax, a.ay = 0, 0
end, function(a)
   a.ixx = 0 a.iyy = -2
   a.sind=118
end, function(a, other, ...)
   call_not_nil(other, 'knockback', other, .4, ...)
end, look_at_pl)

create_actor([['topy', 2, {'drawable','bounded','danceable','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'}]], [[
   max_health=10, health=10,
   name="topy",
   evil=true,
   x=@1, y=@2,
   rx=.375, ry=.375,
   tl_loop=true,
   iyy=-2,
   sinds={112,113},
   anim_len=1,
   touchable=true,
   destroyed=@8,
   hurt_func=@9,

   {i=@4, hit=nf, u=nf, tl_max_time=.5},
   {i=@7, hit=nf, u=@5, tl_max_time=.5},
   {i=@6, hit=@3, u=nf, tl_max_time=1}
]], function(a, other, ...)
   call_not_nil(other, 'knockback', other, .3, ...)

   if other.pl then
      other.hurt(other, 2, 30)
   end
end, function(a) -- init 1 @4
   a.ax, a.ay = 0, 0
   a.anim_off = 0
end, look_at_pl, -- update 1 @5
function(a) -- init 2 @6
   amov_to_actor(a, g_pl, .06)
end, function(a)
   a.anim_off = 1
end, function(a)
   destroy_effect(a, 30, 1, 4, 5, 2)
   g_att.money(a.x, a.y, a.dx, a.dy)
end, function(a)
   a.tl_next = 2
   change_cur_ma(a)
end)

-- create_actor([['bat', 2, {'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'}]], [[
--    evil=true,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={114,115},
--    anim_len=2,
--    anim_spd=10,
--    destroyed=@4,
--    touchable=false,

--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--    a.ax = .01
-- end, destroy_func
-- )

-- create_actor([['skelly', 2, {'bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'}]], [[
--    evil=true,
--    x=@1, y=@2,
--    ax=.005, ay=.01,
--    rx=.375, ry=.375,
--    sinds={66},
--    destroyed=@4,
--    anim_len=1,
--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--    end, destroy_func
-- )

-- create_actor([['ghost', 2, {'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'}]], [[
--    evil=true,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={84},
--    anim_len=1,
--    destroyed=@4,
--    touchable=false,

--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--       a.ax = sin(t())/50
--       a.xf = sgn(a.ax) < 1
--    end, destroy_func
-- )

create_actor([['kluck', 2, {'drawable','loopable','bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','spr','danceable'}]], [[
   name="kluck",
   evil=true,
   x=@1, y=@2,
   rx=.375, ry=.375,
   sind=32,
   destroyed=@4,

   {i=@3, tl_max_time=.5}
]], function(a)
   a.ax, a.ay = rnd_one(.01), rnd_one(.01)
   a.xf = a.ax < 0
end, destroy_func
)


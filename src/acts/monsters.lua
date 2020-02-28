-- SECTION: MONSTERS
create_actor([['top', 2, {'bounded','danceable','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'}]], [[
   max_health=10, health=10,
   name="'topper'",
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

-- create_actor([['chicken', 2, {'loopable','bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr','danceable'}]], [[
--    name="'chicken'",
--    evil=true,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={32},
--    destroyed=@4,
--    anim_len=1,

--    {i=@3, tl_max_time=.5}
-- ]], function(a)
--    a.ax, a.ay = rnd_one(.01), rnd_one(.01)
--    a.xf = a.ax < 0
-- end, destroy_func
-- )


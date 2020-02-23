-- SECTION: CHARS
create_actor([['navy_blocking', 2, {'nnpc'}, NAVY_OUT]], [[
      name="Navy",
      sind=97,
      x=@1, y=@2, interactable_trigger=@3, pause_end=@4
   ]],x,y,function(a)
      if zdget'HAS_BOOMERANG' then
         tbox([[
            trigger=@1,
            "a boomerang?","",
            "isn't that a toy?","",
            "i hope you can save my",
            "sister with that thing."
         ]], get_npc_reload_room'NAVY_OUT')
      elseif zdget'HAS_SHIELD' then
         tbox([[
            trigger=@1,
            "a shield! good choice!","",
            "you can use that protect",
            "my sister from monsters!"
         ]], get_npc_reload_room'NAVY_OUT')
      else
         tbox[[
            "my sister has been in the",
            "forest all day.",
            "find something to protect",
            "yourself with, then bring",
            "her home."
         ]]
      end
   end, function(a)
      npc_dance_logic(a,[[
         "umm... lank, maybe you",
         "should practice that",
         "instrument a bit more."
      ]], [[
         "nice playing lank!", "",
         "if i had money, i would",
         "give it to you!", trigger=@1
      ]], HAS_BANJO, 0) -- will not give money, because you have the banjo.
   end
)

create_actor([['teach', 2, {'nnpc'}]], [[
      name="Teach",
      sind=96,
      x=@1, y=@2, interactable_trigger=@3,
      pause_end=@4
   ]], function()
      if zdget'BANJO_TUNED' then
         tbox[[
            "To save your progress,",
            "try playing the banjo on",
            "a save platform!"
         ]]
      else
         tbox[[
            "Hi Lank, have you been",
            "practicing the banjo?"
         ]]
      end
   end, function(a)
      if g_pause_reason == 'dancing' then
         change_cur_ma(a)
         if not zdget'BANJO_TUNED' then
            tbox([[
               "Oh, your banjo is out of",
               "tune!",
               "Let me fix that for you.",
               trigger=@1
            ]], get_npc_reload_room'BANJO_TUNED')
         else
            tbox[[
               "Now that's my student!"
            ]]
         end
      end
   end
)

create_actor([['lark', 2, {'nnpc'}]], [[
   name="Lark",
   sind=99,
   x=@1, y=@2, interactable_trigger=@3,
   pause_end=@4
]],function()
   tbox[[
      "I'm your biggest fan!"
   ]]
end, function(a)
   npc_dance_logic(a,[[
      "I'm still your biggest fan!"
   ]], [[
      "Hey, that was good!", trigger=@1
   ]], LARK_DANCE, 60)
end
)

create_actor([['jane',2,{'nnpc'}]], [[
   name="Jane", sind=81,
   x=@1, y=@2, interactable_trigger=@3,
   pause_end=@4
]],function()
   tbox([[
      "My husband always works",
      "so hard.",
      "What should I make him",
      "for dinner?"
   ]])
end, function(a)
   npc_dance_logic(a,[[
      "That hurt my ears."
   ]], [[
      "I love that song!", trigger=@1
   ]], JANE_DANCE, 24)
end
)

create_actor([['bob_build', 2, {'nnpc'}, BOB_OUT]], [[
      name="Bob",
      sind=80,
      x=@1, y=@2, interactable_trigger=@3,
      pause_end=@4
   ]],function()
      if zdget'LETTER' then
         tbox([[
            "Is that letter for me?",
            "",
            "Oh...",
            "",
            "It's dinner time!!!",
            trigger=@1
         ]], get_npc_reload_room'BOB_OUT')
      else
         tbox([[
            "Hey Lank, I'm hungry.",
            "",
            "I mean...",
            "",
            "I'm fixing the road."
         ]])
      end
   end, function(a)
      npc_dance_logic(a,[[
         "I can't work with that",
         "terrible music!"
      ]], [[
         "If only music could",
         "quench my hunger.", trigger=@1
      ]], BOB_DANCE, 14)
   end
)

create_actor([['keep', 2, {'nnpc'}]], [[
   name="'keep'",
   sind=83,
   x=@1, y=@2, interactable_trigger=@3,
   pause_end=@4
]],function()
   tbox[["'buy somethin' will ya?'"]]
end, function(a)
   npc_dance_logic(a,[[
      "'that song sucked.'"
   ]], [[
      "'that song was okay.'", trigger=@1
   ]], KEEP_DANCE, 1)
end
)

-- SECTION: DETACHED PL ITEMS
create_actor([['arrow', 3, {'confined','mov','col','spr'}]], [[
   x=@1, y=@2, xf=@3,
   rx=.375,ry=.375,
   sind=23,
   touchable=false,
   i=@4,

   {hit=@5, tl_max_time=1}
]], function(a)
   a.ax = a.xf and -.1 or .1
end, function(a, other)
   if other.evil then
      change_cur_ma(other)

      call_not_nil(other, 'knockback', other, (a.cur == 1) and .3 or .1, a.xf and -1 or 1, 0)
      call_not_nil(other, 'stun', other, 30)
      call_not_nil(other, 'hurt', other, 1, 30)

      a.alive = false
   end
end
)

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

-- SECTION: INVENTORY SELECTION
create_actor([['item_selector', 1, {'rel'}]], [[
   rel_actor=@1, u=@2
]], function(a)
   -- from index to coordinate
   local x, y = (g_selected-1)%3, flr((g_selected-1)/3)

   x += xbtnp()
   y += ybtnp()

   -- only allow movement within bounds.
   x, y = max(0,min(x,2)), max(0,min(y,2))

   -- from coordinate to index
   local next_selected = y*3+x+1

   if g_selected != next_selected then
      g_items_drawn[g_selected].selected = false
      g_items_drawn[next_selected].selected = true
   end

   g_selected = next_selected
   a.rel_x = (x - 1) * 1.5
   a.rel_y = (y - 1.25) * 1.5
end
)

create_actor([['inventory_item', 6, {'rel','spr_obj', 'drawable'}]], [[
   rel_actor=@1, rel_x=@2, rel_y=@3, enabled=@4, flippable=@5, sind=@6, visible=@6,
   i=@7, u=@8
]], function(a)
   a.draw_both = a.enabled and scr_spr_and_out or function(a)
      scr_rectfill(a.x+a.xx/8-.125, a.y+a.yy/8-.125, a.x+a.xx/8, a.y+a.yy/8, a.outline_color)
   end
end, function(a)
   a.outline_color = a.selected and 2 or 1
end
)

-- SECTION: MAP
create_actor([['transitioner', 4, {'act','unpausable'}]], [[
   new_room_index=@1, rx=@2, ry=@3, follow_actor=@4,
   {tl_name='intro',  i=@5, u=@6, tl_max_time=.5, e=@7},
   {tl_name='ending', i=@10, u=@8, tl_max_time=.5, e=@9}
]], -- init
function(a)
   pause'transitioning'
end, function(a)
   g_card_fade = a.intro.tl_tim/a.intro.tl_max_time*10
end, function(a)
   load_room(a.new_room_index, a.rx, a.ry, a.follow_actor)
   tbox_clear()
   g_game_paused = false
end, function(a)
   g_card_fade = (a.ending.tl_max_time-a.ending.tl_tim)/a.ending.tl_max_time*10
end, function()
   unpause()
   g_card_fade = 0
end, function()
   g_game_paused = true
end)

-- SECTION: MONSTERS
create_actor([['top', 2, {'bounded','danceable','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr'}]], [[
   max_health=10, health=10,
   name="Topper",
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
-- 
--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--    a.ax = .01
-- end, destroy_func
-- )
-- 
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
-- 
-- create_actor([['ghost', 2, {'bounded','confined','stunnable','mov','col','hurtable','knockable','anim','spr'}]], [[
--    evil=true,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={84},
--    anim_len=1,
--    destroyed=@4,
--    touchable=false,
-- 
--    {i=@3, tl_max_time=1.5}
-- ]], function(a)
--       a.ax = sin(t())/50
--       a.xf = sgn(a.ax) < 1
--    end, destroy_func
-- )
-- 
-- create_actor([['chicken', 2, {'loopable','bounded','confined','stunnable','mov','col','tcol','hurtable','knockable','anim','spr','danceable'}]], [[
--    name="Chicken",
--    evil=true,
--    x=@1, y=@2,
--    rx=.375, ry=.375,
--    sinds={32},
--    destroyed=@4,
--    anim_len=1,
-- 
--    {i=@3, tl_max_time=.5}
-- ]], function(a)
--    a.ax, a.ay = rnd_one(.01), rnd_one(.01)
--    a.xf = a.ax < 0
-- end, destroy_func
-- )

-- SECTION: NPC
create_actor([['save_platform', 2, {'confined','trig'}]], [[
      rx=.625, ry=.625, x=@1, y=@2, intersects=@3, contains=@3, pause_end=@4,
      trigger_update=nf
]], function(a)
   if g_pause_reason == 'dancing' and zdget'BANJO_TUNED' then
      memcpy(REAL_SAVE_LOCATION, TEMP_SAVE_LOCATION, SAVE_LENGTH)
      tbox[["The game has been saved!"]]
   end
end, function(a)
   a:contains_or_intersects(g_pl)
end)

create_actor([['sign', 4, {'interactable'}]], [[
   name="Sign",
   rx=.5,      ry=.5,
   trig_x=0,   trig_y=.125,
   trig_rx=.75, trig_ry=.625,
   x=@1, y=@2, text_obj=@3, sind=@4, interactable_trigger=@5
]], function(a)
   tbox_with_obj(a.text_obj)
end
)

create_actor([['shop_brang', 2, {'shop_item'}, HAS_BOOMERANG]], [[
   name="'brang'", sind=4,
   x=@1, y=@2, mem_loc=HAS_BOOMERANG
]])

create_actor([['shop_shield', 2, {'shop_item'}, HAS_SHIELD]], [[
   name="'shield'", sind=6,
   x=@1, y=@2, mem_loc=HAS_SHIELD
]])

-- for the chest.
create_actor([['item_show', 3, {'spr','rel','unpausable'}]], [[
   rel_actor=@1, sind=@2, mem_loc=@3,
   rel_y=-1.125,
   {tl_max_time=2, e=@4}
]], function(a)
   unpause()
   resume_music()
   zdset(a.mem_loc)
end
)

-- a few types of triggers...
-- interactable triggers (press z to make it do something).
-- step inside triggers (houses are a good example).
-- directional trigger (easier to put a trigger next to an object).

-- Not sure if we need this...
-- triggers_template={{rel_x, rel_y, rx, ry, func}},

create_actor([['chest', 4, {'unpausable','interactable'}]], [[
   name="Chest",
   sind=50,rx=.375,ry=.375,
   x=@1, y=@2, xf=@3, mem_loc=@4,
   trig_y=0,
   trig_rx=.5,  trig_ry=.375,
   interactable_trigger=@6,
   {i=@5}, {i=nf, interactable_trigger=nf, sind=51}
]], function(a)
   a.tl_next = zdget(a.mem_loc)
   a.trig_x = a.xf and -.125 or .125
   a:interactable_init()
end, function(a)
   a.tl_next = true
   pause'chest'
   stop_music'1'
   a.item_show = g_att.item_show(g_pl, 1, a.mem_loc)
end
)

create_actor([['gen_trigger_block', 7, {'rel', 'confined', 'trig'}]], [[
   rel_actor=@1, rel_x=@2, rel_y=@3, rx=@4, ry=@5, contains=@6, intersects=@7,
   not_contains_or_intersects=@8
]], function(a)
   if get_cur_ma() == a.rel_actor then
      change_cur_ma()
   end
end
)

-- todo: trim code here.
create_actor([['house', 6, {'confined','spr'}]], [[
   x=@1, y=@2, room=@3, room_x=@4, room_y=@5, sind=@6,
   i=@7, destroyed=@8,
   iyy=-4, sw=2, sh=2
]], function(a)
   a.b1 = g_att.static_block(a.x-.75,a.y, .25, .5)
   a.b2 = g_att.static_block(a.x+.75,a.y, .25, .5)
   a.b3 = g_att.static_block(a.x,a.y-4/8, 1,.25)
   a.trig = g_att.gen_trigger_block(a, 0, 1/8, .5, 5/8, function(trig, other)
      if other.pl then
         g_att.transitioner(a.room, a.room_x, a.room_y, g_pl)
      end
   end, nf)
end, function(a)
   a.b1.alive, a.b2.alive, a.b3.alive, a.trig.alive = false
end
)

-- SECTION: OBJECTS
create_actor([['money', 4, {'bounded','confined','tcol','spr','col','mov'}]], [[
   sind=36,rx=.125,ry=.125,
   x=@1, y=@2, dx=@3, dy=@4,
   touchable=false,
   hit=@5,
   destroyed=@7,
   {tl_max_time=5},
   {i=@6}
]],
function(a, other)
   if other.pl then
      add_money'1'
      a.alive = false
   end
end, function(a)
   a.alive = false
end, function(a)
   destroy_effect(a, 9, 1, 6, 7, 13, 12)
end)

create_actor([['static_block', 4, {'confined', 'wall'}]], [[
   x=@1, y=@2, rx=@3, ry=@4,
   static=true,
   touchable=true
]]
)

create_actor([['thing_destroyed', 3, {'confined', 'mov', 'drawable', 'bounded'}]], [[
   parent=@1, c=@2, d=@5,
   {i=@4, tl_max_time=@3}
]], function(a)
   local p = a.parent
   a.x = p.x+p.ixx/8
   a.y = p.y+p.iyy/8
   a.dx = p.dx + rnd(.3)-.15
   a.dy = p.dy + rnd(.3)-.15
end, function(a)
   scr_pset(a.x, a.y, a.c)
end)

create_actor([['pot_projectile', 3, {'col', 'confined', 'mov', 'spr', 'bounded', 'tcol'}]], [[
   tile_solid=true,
   sind=49,
   x=@1, y=@2, xf=@3,
   touchable=false,
   i=@4,
   destroyed=@6,
   hit=@7,
   tile_hit=@8,
   { u=@5, tl_max_time=.3 }
]], function(a)
   a.ax = a.xf and -.04 or .04
end, function(a)
   a.iyy = -cos(a.tl_tim/a.tl_max_time/4)*8
end, function(a)
   sfx'9'
   destroy_effect(a, 10, 1, 13, 12)
   g_att.money(a.x, a.y, a.dx, a.dy)
end, function(a, o)
   if o.touchable and not o.pl then
      call_not_nil(o, 'hurt', o, 0, 60)
      call_not_nil(o, 'knockback', o, .6, -bool_to_num(a.xf), 0)
      a.tl_next = true
   end
end, function(a)
   a.tl_next = true
end)

-- x, y, sind
create_actor([['pot', 3, {'bounded','confined','tcol','spr','col','mov'}]], [[
   static=true,
   rx=.375,ry=.375,
   x=@1, y=@2, sind=@3,
   touchable=true,
   i=@4
]], function(a)
   g_att.gen_trigger_block(a, 0, 0, .5, .5, nf, function(trig, other)
      if btnp(4) and not other.item then
         other.item = g_att.grabbed_item(g_pl, a.sind, -7, function(x, y, xf)
            g_att.pot_projectile(other.x, other.y, xf)
         end)
         a:kill()
      end
   end)
end
)

-- SECTION: PL
create_actor([['lank_top', 1, {'rel','spr_obj','danceable'}]], [[
      rel_actor=@1,
      sind=147,
      iyy=-2,
      u=@2, pause_update=@3
]], function(a)
   a.xf = g_pl.xf
   a.alive = g_pl.alive
   a.outline_color = g_pl.outline_color

   if g_pl.item and g_pl.item.throwable then
      a.sind=g_pl.item.throwing and 150 or 148
   else
      a.sind=147
   end
end, function(a)
   if is_game_paused'dancing' then
      a.dance_update(a)
      a.sind = abs(a.dance_time) > .5 and 149 or 147
   elseif is_game_paused'chest' then
      a.sind=148
   end
end
)

create_actor([['grabbed_item', 4, {'rel','spr_obj'}]], [[
   rel_actor=@1, sind=@2, iyy=@3, create_func=@4,
   throwable=true,
   flippable=true,
   being_held=true,
   {i=@6, throwing=false, tl_max_time=.2}, { i=nf, u=@5 }, { throwing=true, visible=false, tl_max_time=.05 }
]], function(a)
   if btnp(4) or btn(5) then
      sfx'6'
      a.create_func(a.x, a.y+a.iyy/8, a.xf)
      return true
   end
end, function(a)
   sfx'5'
end)

create_actor(
[['pl', 2, {'anim','col','mov','tcol','hurtable','knockable','stunnable','spr','danceable'}]], [[
   name="'lank'",
   x=@1,
   y=@2,
   sinds={144, 145, 146},
   rx=.375,
   ry=.375,
   iyy=-2,
   spd=.02,
   anim_len=3,
   anim_spd=5,
   max_health=LANK_START_HEALTH,
   health=LANK_START_HEALTH,
   i=@3, u=@4, destroyed=@5, d=@6
]], function(a)
   a.ltop = g_att.lank_top(a)
end, function(a)
   -- movement logic
   if a.stun_countdown == 0 then
      if not btn'5' then
         if (xbtn() != 0) and not (a.item and (a.item.brang or a.item.shield)) then a.xf = btn'0' end
         a.ax = xbtn()*a.spd
         a.ay = ybtn()*a.spd
         if g_debug then
            a.ax *= 3
            a.ay *= 3
            a.touchable=false
         else
            a.touchable=true
         end
      else
         a.ax = 0 a.ay = 0
      end
   end

   if a.item and (a.item.banjo or a.item.brang) then
      a.ax = 0 a.ay = 0
   end

   -- item logic
   if not btn'5' and not a.item then
      if btnp'4' and g_energy_tired then
         if not get_selected_item().interact then
            sfx'7'
         end
      elseif btnp'4' and not g_energy_tired then
         if get_selected_item().name == 'bomb' then
            if remove_money(5) then
               a.item = g_att.grabbed_item(a, 5, -6, g_att.bomb)
               -- a.item = g_att.grabbed_item(32, -7, function(a) g_att.chicken(a.x, a.y) end)
               -- a.item = g_att.grabbed_item(49, -9, function(a) g_att.pot(a.x, a.y) end)
               sfx'5'
            else
               sfx'7'
            end
         elseif not get_selected_item().interact then
            a.item = gen_pl_item(a)
            sfx'5'
         end
      end
   end

   local item = a.item

   if item then
      if not item.alive then
         a.item = nil
      end

      if (not btn'4' or btn'5') then
         item.being_held = false
      end

      a.ax *= .5
      a.ay *= .5
   end

   a.anim_sind = nil

   -- walking animation logic
   if flr((abs(a.dx) + abs(a.dy))*50) > 0 then
      a.anim_len = 3
   else
      a.anim_len = 1
   end

   -- shaking logic
   if a.stun_countdown != 0 then
      if a.item then
         a.item.xx = a.xx
      end
   end
end, function(a)
   if a.item then a.item.alive = false end
-- draw
end, function(a)
   a.ltop.outline_color = a.outline_color
   scr_spr_out(a)
   scr_spr_out(a.ltop)
   -- if a.item and a.item.throwable then scr_spr_out(a.item) end

   if a.item and not a.item.spr then
      scr_spr_out(a.item)
   end

   scr_spr(a)
   scr_spr(a.ltop)
   -- if a.item and a.item.throwable then scr_spr(a.item) end

   if a.item and not a.item.spr then
      scr_spr(a.item)
   end
end
)

-- SECTION: TITLE
create_actor([['title_move', 0, {'mov'}]], [[
   x=0, y=0, dx=.1, dy=.1, ax=0, ay=0, ix=1, iy=1, ixx=0, iyy=0
]])

-- SECTION: VIEW
create_actor([['view_instance', 4, {'view'}]], [[
   tl_loop=true,
   w=@1, h=@2, follow_dim=@3, follow_act=@4,
   update_view=@5,
   center_view=@6,
   change_ma=@7,
   {},
   {tl_max_time=4},
   {follow_act=false}
]],
function(a)
   batch_call(update_view_helper, [[{@1,'x','w','ixx'},{@1,'y','h','iyy'}]],a)
end, function(a)
   if a.follow_act then
      a.x, a.y = a.follow_act.x, a.follow_act.y
   end
   a:update_view()
end, function(a, ma)
   a.follow_act = ma
   a.tl_next = a.timeoutable and 2 or 1
end)


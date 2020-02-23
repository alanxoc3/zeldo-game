function look_at_pl(a)
   if g_pl then
      a.xf = a.x-g_pl.x > 0
   end
end

create_parent(
[[ 'interactable', {'spr','wall','confined'},
   {
      interactable_trigger=nf,
      trig_x=0,
      trig_y=0,
      trig_rx=.75,
      trig_ry=.75,
      trig=nil,
      i=@1, interactable_init=@1
   }
]], function(a)
   a.trig = g_att.gen_trigger_block(a, a.trig_x, a.trig_y, a.trig_rx, a.trig_ry, nf, function(trig, other)
      if npc_able_to_interact(a, other) then
         change_cur_ma(a)
         if able_to_interact(a, other) then
            a:interactable_trigger()
         end
      else
         if get_cur_ma() == a then
            change_cur_ma()
         end
      end
   end)
end)

create_parent(
[[ 'nnpc', {'danceable', 'interactable'},
   {
      rx=.5,ry=.5,iyy=-2,
      u=@1
   }
]], look_at_pl)

function npc_able_to_interact(a, other)
   return (a.x > other.x-INTERACT_SPACE and not other.xf or a.x < other.x+INTERACT_SPACE and other.xf)
end

function able_to_interact()
   return not g_menu_open
      and get_selected_item().interact
      and not is_game_paused()
      and btnp'4'
end

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

function npc_dance_logic(a,bad_text,good_text,mem_loc,money)
   if g_pause_reason == 'dancing' then
      change_cur_ma(a)
      if not zdget'BANJO_TUNED' then
         tbox(bad_text)
      else
         tbox(good_text, function()
            if not zdget(mem_loc) then
               add_money(money)
               zdset(mem_loc)
            end
         end)
      end
   end
end

function get_npc_reload_room(mem_loc)
   return function()
      zdset(mem_loc)
      g_att.transitioner(g_cur_room_index, g_pl.x-g_cur_room.x, g_pl.y-g_cur_room.y, g_pl)
   end
end

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

-- SECTION: CHARS
create_actor([['navy_blocking', 2, {'nnpc'}, NAVY_OUT]], [[
      name="'navy'",
      sind=97,
      x=@1, y=@2, interactable_trigger=@3, pause_end=@4
   ]],x,y,function(a)
      if zdget'HAS_BOOMERANG' then
         tbox([[
            trigger=@1,
            "'a boomerang?'","''",
            "'isn't that a toy?'","''",
            "'i hope you can save my'",
            "'sister with that thing.'"
         ]], get_npc_reload_room'NAVY_OUT')
      elseif zdget'HAS_SHIELD' then
         tbox([[
            trigger=@1,
            "'a shield! good choice!'","",
            "'you can use that protect'",
            "'my sister from monsters!'"
         ]], get_npc_reload_room'NAVY_OUT')
      else
         tbox[[
            "'my sister has been in the'",
            "'forest all day.'",
            "'find something to protect'",
            "'yourself with, then bring'",
            "'her home.'"
         ]]
      end
   end, function(a)
      npc_dance_logic(a,[["'umm...'"]], [[
         "'nice playing lank!'", "''",
         "'if i had money, i would'",
         "'give it to you!'", trigger=@1
      ]], HAS_BANJO, 0) -- will not give money, because you have the banjo.
   end
)

create_actor([['teach', 2, {'nnpc'}]], [[
      name="'teach'",
      sind=96,
      x=@1, y=@2, interactable_trigger=@3,
      pause_end=@4
   ]], function()
      if zdget'BANJO_TUNED' then
         tbox[[
            "'try playing yer banjo on'",
            "'a save spot!'"
         ]]
      else
         tbox[[
            "'Hi Lank, have you been'",
            "'practicing the banjo?'"
         ]]
      end
   end, function(a)
      if g_pause_reason == 'dancing' then
         change_cur_ma(a)
         if not zdget'BANJO_TUNED' then
            tbox([[
               "'Oh, your banjo is out of'",
               "'tune!'",
               "'Let me fix that for you.'",
               trigger=@1
            ]], get_npc_reload_room'BANJO_TUNED')
         else
            tbox[[
               "'now that's my student!'"
            ]]
         end
      end
   end
)

create_actor([['lark', 2, {'nnpc'}]], [[
   name="'lark'",
   sind=99,
   x=@1, y=@2, interactable_trigger=@3,
   pause_end=@4
]],function()
   tbox[[
      "'i'm your biggest fan!'"
   ]]
end, function(a)
   npc_dance_logic(a,[[
      "'i'm still your biggest fan!'"
   ]], [[
      "'hey, that was good!'", trigger=@1
   ]], LARK_DANCE, 60)
end
)

create_actor([['jane',2,{'nnpc'}]], [[
   name="'jane'", sind=81,
   x=@1, y=@2, interactable_trigger=@3,
   pause_end=@4
]],function()
   tbox([[
      "'My husband always works'",
      "'so hard.'",
      "'What should I make him'",
      "'for dinner?'"
   ]])
end, function(a)
   npc_dance_logic(a,[[
      "'That hurt my ears.'"
   ]], [[
      "'I love that song!'", trigger=@1
   ]], JANE_DANCE, 24)
end
)

create_actor([['bob_build', 2, {'nnpc'}, BOB_OUT]], [[
      name="'bob'",
      sind=80,
      x=@1, y=@2, interactable_trigger=@3,
      pause_end=@4
   ]],function()
      if zdget'LETTER' then
         tbox([[
            "'Is that letter for me?'",
            "''",
            "'Oh...",
            "''",
            "'It's dinner time!!!'",
            trigger=@1
         ]], get_npc_reload_room'BOB_OUT')
      else
         tbox([[
            "'Hey Lank, I'm hungry.'",
            "''",
            "'I mean...'",
            "''",
            "'I'm fixing the road.'"
         ]])
      end
   end, function(a)
      npc_dance_logic(a,[[
         "'I can't work with that'",
         "'terrible music!'"
      ]], [[
         "'If only music could'",
         "'quench my hunger.'", trigger=@1
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


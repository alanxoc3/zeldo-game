-- SECTION: CHARS
create_actor([[navy_blocking;2;nnpc,mem_dep|
   name:"navy";
   sind:97;mem_loc:NAVY_OUT;
   u:nf;
   f_reload:!get_npc_reload_room/NAVY_OUT;
   f_money:!memloc_money/HAS_BANJO/0;

   -- brang:!tbox/"brang..."/~f_reload;

   -- !npc_dance_logic/"umm..."/~f_money;

   x:@1;y:@2;interactable_trigger:@3;pause_end:@4;
]],function(a)
   if zdget'HAS_BOOMERANG' then
      tbox("a boomerang?^^isn't that a toy^^i hope you can save my^sister with that thing.", a.f_reload)
   elseif zdget'HAS_SHIELD' then
      tbox("a shield! good choice!^^you can use that protect^my sister from monsters!", a.f_reload)
   else
      tbox"my sister has been in the^forest all day.^find something to protect^yourself with, then bring^her home."
   end
end, _g.npc_dance_logic("umm...", "nice playing lank!^^if i had money, i would^give it to you!", _g.memloc_money(HAS_BANJO, 0)))

create_actor([[teach;2;nnpc,|
   name:"teach";
   sind:96;
   x:@1;y:@2;interactable_trigger:@3;
   pause_end:@4;
]], function()
   if zdget'BANJO_TUNED' then
      tbox"try playing yer banjo on^a save spot!"
   else
      tbox"hi lank have you been^practicing the banjo?"
   end
end, function(a)
   if g_pause_reason == 'dancing' then
      change_cur_ma(a)
      if not zdget'BANJO_TUNED' then
         tbox("oh, your banjo is out of^tune!^let me fix that for you.", _g.get_npc_reload_room(BANJO_TUNED))
      else
         tbox"now that's my student!"
      end
   end
end
)

create_actor([[lark;2;nnpc,|
   name:"lark";
   sind:99;x:@1;y:@2;interactable_trigger:!tbox_closure/"i'm your biggest fan!";
   pause_end:@3;
]], _g.npc_dance_logic("hey that was bad!", "hey that was good!", _g.memloc_money(LARK_DANCE, 60)))

create_actor([[jane;2;nnpc,|
   name:"jane";sind:81;
   x:@1;y:@2;interactable_trigger:!tbox_closure/"my husband always works^so hard.^what should i make him^for dinner?";
   pause_end:@3;
]], _g.npc_dance_logic("that hurt my ears.", "i love that song!", _g.memloc_money(JANE_DANCE, 24)))

create_actor([[bob_build;2;nnpc,mem_dep|
   name:"bob";sind:80;
   mem_loc:BOB_OUT;
   x:@1;y:@2;interactable_trigger:@3;

   pause_end:@4;
]],function()
   if zdget'LETTER' then
      tbox("is that letter for me?^^oh..^^it's dinner time!!!", _g.get_npc_reload_room(BOB_OUT))
   else
      tbox"hey lank. i'm hungry.^^i mean...^^i'm fixing the road."
   end
end, _g.npc_dance_logic("i can't work with that^terrible music!","if only music could^quench my hunger.", _g.memloc_money(BOB_DANCE, 14)))

create_actor([[keep;2;nnpc,|
   name:"keep";
   sind:83;
   x:@1;y:@2;interactable_trigger:!tbox_closure/"buy somethin' will ya?";

   pause_end:@3;
]], _g.npc_dance_logic("that song sucked.", "that song was okay.", _g.memloc_money(KEEP_DANCE, 1)))

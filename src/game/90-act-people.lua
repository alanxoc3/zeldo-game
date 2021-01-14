-- SECTION: CHARS
navy_dance_function = _g.npc_dance_logic("umm...", "nice playing lank!^^if i had money, i would^give it to you!")
create_actor([[navy_blocking;2;nnpc,mem_dep|
   name:"navy";
   sind:97;mem_loc:NAVY_OUT;
   u:nf;
   f_reload:!get_npc_reload_room/NAVY_OUT;
   f_money:!memloc_money/HAS_BANJO/0;

   x:@1;y:@2;pause_end:@3;

   interactable_trigger:!tbox_actor_logic
      /HAS_BOOMERANG/"a boomerang?^^isn't that a toy^^i hope you can save my^sister with that thing."/~f_reload
      /HAS_SHIELD/"a shield! good choice!^^you can use that protect^my sister from monsters!"/~f_reload
      /ALWAYS_TRUE/"my sister has been in the^forest all day.^find something to protect^yourself with and bring^her home."/nf
   ;
]], navy_dance_function)

create_actor([[navy_house;2;nnpc,mem_dep|
   name:"navy";
   sind:97;xf:true;mem_loc:NAVY_OUT;mem_loc_expect:false;
   x:@1;y:@2;interactable_trigger:@3;pause_end:@4;
]],function(a)
   tbox"hi lank."
end, navy_dance_function)

create_actor([[teach;2;nnpc,|
   name:"teach";
   sind:96;
   x:@1;y:@2;
   pause_end:@3;

   interactable_trigger:!tbox_actor_logic
      /BANJO_TUNED/"try playing yer banjo on^a save spot!"/nf
      /ALWAYS_TRUE/"hi lank have you been^practicing the banjo?"/nf
   ;
]], function(a)
   if g_pause_reason == 'dancing' then
      change_cur_ma(a)
      if zdget'BANJO_TUNED' then
         tbox"now that's my student!"
      else
         tbox("oh, your banjo is out of^tune!^let me fix that for you.", _g.get_npc_reload_room(BANJO_TUNED))
      end
   end
end)

create_actor([[lark;2;nnpc,|
   name:"lark";
   sind:99;x:@1;y:@2;interactable_trigger:@3;
   pause_end:@4;
]], function(a)
   if g_pl.health < g_pl.max_health then
      tbox("please let me help you.", function() g_pl.health = g_pl.max_health end)
   else
      tbox"i'm your biggest fan!^^visit me if you're hurt."
   end
end, _g.npc_dance_logic("i can't fix banjos.", "you helped my soul!", _g.memloc_money(LARK_DANCE, 60)))

create_actor[[jane;2;nnpc,|
   name:"jane";sind:81;
   x:@1;y:@2;
   f_money:!memloc_money/JANE_DANCE/24;

   interactable_trigger:!tbox_closure/"my husband always works^so hard.^what should i make him^for dinner?";
   pause_end:!npc_dance_logic/"that hurt my ears."/"i love that song!"/~f_money;
]]

create_actor[[bob_build;2;nnpc,mem_dep|
   name:"bob";sind:80;
   mem_loc:BOB_OUT;
   x:@1;y:@2;
   f_reload:!get_npc_reload_room/BOB_OUT;
   f_money:!memloc_money/BOB_DANCE/14;
   pause_end:!npc_dance_logic/"i can't work with that^terrible music!"/"if only music could^quench my hunger."/~f_money;

   interactable_trigger:!tbox_actor_logic
      /LETTER/"is that letter for me?^^oh..^^it's dinner time!!!"/~f_reload
      /ALWAYS_TRUE/"hey lank. i'm hungry.^^i mean...^^i'm fixing the road."/nf ;
]]

create_actor[[keep;2;nnpc,|
   name:"keep";
   sind:83;
   x:@1;y:@2;interactable_trigger:!tbox_closure/"buy somethin' will ya?";
   f_money:!memloc_money/KEEP_DANCE/1;
   pause_end:!npc_dance_logic/"that song sucked."/"that song was okay."/!f_money;
]]

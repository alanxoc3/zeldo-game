function npc_able_to_interact(a, other)
   return a.xf != other.xf
      and able_to_interact(a, other)
end

function able_to_interact(a, other)
   return not g_menu_open
      and get_selected_item().interact
      and not is_game_paused()
      and btnp'4'
end

g_att.navy_blocking = function(x, y)
   local navy_trigger_func = function()
      zdset'NAVY_OUT'
      g_att.transitioner(g_cur_room_index, g_pl.x-g_cur_room.x, g_pl.y-g_cur_room.y)
   end
   return not zdget(NAVY_OUT) and create_actor([[
      id='navy_blocking', par={'confined','spr','wall','danceable'},
      att={
         sind=97,
         x=@1, y=@2, i=@3,
         rx=.5,ry=.5,iyy=-2,
         pause_end=@4
      }
      ]],x,y,function(a)
         g_att.gen_trigger_block(a, 0, 0, .75, .75, nf, function(trig, other)
            if npc_able_to_interact(a, other) then
               change_cur_ma(a)
               if zdget'HAS_BOOMERANG' then
                  tbox([[
                     trigger=@1,
                     "A boomerang?","",
                     "Isn't that thing a toy?","",
                     "I hope you can save my",
                     "sister with that thing."
                  ]], navy_trigger_func)
               elseif zdget'HAS_SHIELD' then
                  tbox([[
                     trigger=@1,
                     "A shield! Good choice!","",
                     "You can use that protect",
                     "my sister from monsters!"

                     "Find something to protect",
                     "yourself with, then bring",
                     "her home."
                  ]], navy_trigger_func)
               else
                  tbox[[
                     "My sister has been in the",
                     "forest all day.",
                     "Find something to protect",
                     "yourself with, then bring",
                     "her home."
                  ]]
               end
            end
         end)
      end, function(a)
         if g_pause_reason == 'dancing' then
            if zdget(BANJO_TUNED) then
               tbox[[
                  "Nice playing lank!", "",
                  "If I had money, I would",
                  "give it to you!"
               ]]
            else
               tbox[[
                  "Umm... Lank, maybe you",
                  "should practice that",
                  "instrument a bit more."
               ]]
            end
         end
      end
   )
end

g_att.teach = function(x, y)
   return create_actor([[
      id='teach', par={'confined','spr','wall','danceable'},
      att={
         sind=96,
         x=@1, y=@2, i=@3,
         rx=.5,ry=.5,iyy=-2,
         pause_end=@4
      }
      ]],x,y,function(a)
         g_att.gen_trigger_block(a, 0, 0, .75, .75, nf, function(trig, other)
            if npc_able_to_interact(a, other) then
               if zdget'BANJO_TUNED' then
                  tbox([[
                     "To save you progress, try",
                     "playing the banjo on a",
                     "save platform!"
                  ]], navy_trigger_func)
               else
                  tbox([[
                     "Hi Lank, have you been",
                     "practicing the banjo?"
                  ]], navy_trigger_func)
               end
            end
         end)
      end, function(a)
         if g_pause_reason == 'dancing' then
            if not zdget(BANJO_TUNED) then
               tbox([[
                  "Oh, your banjo is out of",
                  "tune!",
                  "Let me fix that for you.",
                  trigger=@1
               ]], function()
                  zdset'BANJO_TUNED'
                  g_att.transitioner(g_cur_room_index, g_pl.x-g_cur_room.x, g_pl.y-g_cur_room.y)
               end)
            else
               tbox[[
                  "Now that's my student!"
               ]]
            end
         end
      end
   )
end

g_att.lark = function(x, y)
   return g_att.npc(x,y,"Lark","I'm your biggest fan!",99)
end


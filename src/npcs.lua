g_att.npc = function(x, y,name,text,sind)
   return create_actor([[
      id='npc', par={'confined','spr','wall'},
      att={
         x=@1, y=@2, name=@3,
         i=@6, u=@7,
         sind=@5,rx=.5,ry=.5,iyy=-2,
         text=@4
      }
      ]],x,y,name,text,sind,function(a)
         local big_w = 6/8
         batch_call(gen_text_trigger_block, [[
            {@1,0,@2}, {@1,1,@2},
            {@1,2,@2}, {@1,3,@2}
         ]], a, a.text)
      end, function(a)
         a.xf = a.x-g_pl.x > 0
      end
   )
end

g_att.lark = function(x, y)
   return g_att.npc(x,y,"Lark","I'm your biggest fan!",99)
end

g_att.sign = function(x, y, text_obj, sind)
   return create_actor([[
      id='sign', par={'hurtable','confined','spr','wall'},
      att={
         name="Sign", health=10, max_health=10, evil=true,
         sind=@3,rx=.5,ry=.5,
         x=@1, y=@2, i=@4
      }
      ]],x,y,sind,
      function(a)
         a.trig = gen_text_trigger_block(a, 3, text_obj)
      end
   )
end

-- Opened is an optional parameter.
g_att.chest = function(x, y, direction)
   return create_actor([[
      id='chest', par={'confined','spr','wall'},
      att={
         name="Chest",
         sind=50,rx=.375,ry=.375,
         chest_opened=false,
         xf=@3,
         x=@1, y=@2, i=@4
      }
      ]],x,y,direction,
      function(a)
         a.trig = gen_trigger_block_dir(a, a.xf and 1 or 0, function(b, other)
               if not a.chest_opened and not g_menu_open and g_selected == G_INTERACT and not g_tbox_active and btnp'4' then
                  a.sind = 51
                  a.chest_openened = true
               end
            end
         )
      end
   )
end

function gen_text_trigger_block(sign, dir, text_obj)
   return gen_trigger_block_dir(sign, dir, function(a, other)
      if not g_menu_open and g_selected == G_INTERACT and not g_tbox_active and btnp'4' then
         change_cur_ma(sign)
         tbox_with_obj(text_obj)
      end
   end
   )
end

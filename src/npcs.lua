g_att.npc = function(x, y,name,text,sind)
   return create_actor([[
      id='npc', par={'nnpc'},
      att={
         x=@1, y=@2, name=@3,
         interactable_trigger=@5,
         sind=@4,rx=.5,ry=.5,iyy=-2,
         pause_end=@6
      }
      ]],x,y,name,sind,function(a)
         tbox_with_obj(text)
      end, function(a)
         if g_pause_reason == 'dancing' then
            tbox([["nice playing lank!",trigger=@1]],function() add_money(10) end)
         end
      end
   )
end

g_att.save_platform = function(x, y, platform_id)
   return create_actor([[
      id='sign', par={'confined','trig'},
      att={
         rx=.625, ry=.625, x=@1, y=@2, intersects=@3, contains=@3, pause_end=@4,
         trigger_update=nf
      }
   ]], x, y, function(a)
      if g_pause_reason == 'dancing' and zdget'BANJO_TUNED' then
         memcpy(REAL_SAVE_LOCATION, TEMP_SAVE_LOCATION, SAVE_LENGTH)
         tbox[["The game has been saved!"]]
      end
   end, function(a) a:contains_or_intersects(g_pl) end)
end

g_att.sign = function(x, y, text_obj, sind)
   return create_actor([[
      id='sign', par={'interactable'},
      att={
         rx=.5,      ry=.5,
         trig_x=0,   trig_y=.125,
         trig_rx=.75, trig_ry=.625,
         x=@1, y=@2, sind=@3, interactable_trigger=@4
      }
      ]],x,y,sind, function(a)
         tbox_with_obj(text_obj)
      end
   )
end

g_att.shop_item = function(x, y, mem_loc)
   return not zdget(mem_loc) and create_actor([[
      id='shop_item', par={'unpausable', 'interactable'},
      att={
         x=@1, y=@2,
         interactable_trigger=@3,

         sind=4, rx=.5, ry=.5,
         trig_x=0,   trig_y=.125,
         trig_rx=.5, trig_ry=.625
      }
      ]], x, y, function(a)
         a:kill()
         g_att.item_show(g_pl, 4)
         pause'chest' -- not a chest, but is the same functionality.
         stop_music'1'
         zdset(mem_loc)
      end
   )
end

-- for the chest.
g_att.item_show = function(a, sind)
   return create_actor([[
      id='item_show', par={'spr','rel','unpausable'},
      att={
         rel_actor=@1,
         rel_y=-1.125,
         sind=@2,
         {tl_max_time=2, e=@3}
      }
   ]],a,sind, function(a)
      unpause()
      resume_music()
   end)
end


-- a few types of triggers...
-- interactable triggers (press z to make it do something).
-- step inside triggers (houses are a good example).
-- directional trigger (easier to put a trigger next to an object).

-- Not sure if we need this...
-- triggers_template={{rel_x, rel_y, rx, ry, func}},

g_att.chest = function(x, y, direction, mem_loc)
   return create_actor([[
      id='chest', par={'unpausable','interactable'},
      att={
         sind=50,rx=.375,ry=.375,
         x=@1, y=@2, xf=@3,tl_cur=@4,
         interactable_trigger=@6,
         trig_x=@5,   trig_y=0,
         trig_rx=.5,  trig_ry=.375,
         {},
         {interactable_trigger=nf, i=@7, tl_max_time=2, e=@8},
         {i=nf, e=nf}
      }
      ]],x,y,direction,zdget(mem_loc) and 3 or 1, direction and -.125 or .125,
      function(a)
         a.sind = 51
         a.tl_next = true
      end, function(a)
         pause'chest'
         stop_music'1'
         a.trig.alive = false
         a.item_show = g_att.item_show(g_pl, 1)
      end, function(a)
         a.item_show:kill()
         zdset(mem_loc)
         unpause()resume_music()
      end
   )
end

g_att.gen_trigger_block = function(a, off_x, off_y, rx, ry, contains, intersects)
   return create_actor([[
      id='trigger_block', par={'rel', 'confined', 'trig'},
      att={
         rel_actor=@1,
         rel_x=@2,
         rel_y=@3,
         rx=@4,
         ry=@5,
         contains=@6,
         intersects=@7,
         not_contains_or_intersects=@8
      }
      ]], a, off_x, off_y, rx, ry, contains or nf, intersects or nf, function()
         if get_cur_ma() == a then
            change_cur_ma()
         end
      end
   )
end

-- todo: trim code here.
g_att.house = function(x, y, room, rx, ry, sind)
   return create_actor([[
      id='house', par={'confined','spr'},
      att={
         x=@1, y=@2,
         room=@3, room_x=@4, room_y=@5,
         contains=@6, i=@7,
         destroyed=@8, sind=@9,
         iyy=-4,
         sw=2, sh=2
      }
      ]],x,y,room,rx,ry,
      -- trigger
      function(a, other)
         if other.pl then
            g_att.transitioner(room, rx, ry, 'u')
         end
      end, function(a)
         a.b1 = gen_static_block(a.x-.75,a.y, .25, .5)
         a.b2 = gen_static_block(a.x+.75,a.y, .25, .5)
         a.b3 = gen_static_block(a.x,a.y-4/8, 1,.25)
         a.trig = g_att.gen_trigger_block(a, 0, 1/8, .5, 5/8, a.contains)
      end, function(a)
         a.b1.alive, a.b2.alive, a.b3.alive, a.trig.alive = false
      end, sind or 46
   )
end

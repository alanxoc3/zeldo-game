create_actor2([['save_platform', 2, {'confined','trig'}]], [[
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

create_actor2([['sign', 4, {'interactable'}]], [[
   name="Sign",
   rx=.5,      ry=.5,
   trig_x=0,   trig_y=.125,
   trig_rx=.75, trig_ry=.625,
   x=@1, y=@2, text_obj=@3, sind=@4, interactable_trigger=@5
]], function(a)
   tbox_with_obj(a.text_obj)
end
)

g_att.shop_item = function(name, x, y, sind, cost, mem_loc)
   assert(mem_loc != nil)
   return not zdget(mem_loc) and create_actor([[
      id='shop_item', par={'unpausable', 'interactable'},
      att={
         name=@1,
         x=@2, y=@3,
         interactable_trigger=@5,

         sind=@4, rx=.5, ry=.5,
         trig_x=0,   trig_y=.125,
         trig_rx=.5, trig_ry=.625
      }
      ]], name, x, y, sind, function(a)
         if remove_money(cost) then
            a:kill()
            g_att.item_show(g_pl, 4, mem_loc)
            pause'chest' -- not a chest, but is the same functionality.
            stop_music'1'
         end
      end
   )
end

-- for the chest.
create_actor2([['item_show', 3, {'spr','rel','unpausable'}]], [[
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

create_actor2([['chest', 4, {'unpausable','interactable'}]], [[
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

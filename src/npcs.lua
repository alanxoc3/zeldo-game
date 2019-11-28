g_att.npc = function(x, y,name,text,sind)
   return create_actor([[
      id='npc', par={'confined','spr','wall','danceable'},
      att={
         x=@1, y=@2, name=@3,
         i=@6, u=@7,
         sind=@5,rx=.5,ry=.5,iyy=-2,
         text=@4,pause_end=@8
      }
      ]],x,y,name,text,sind,function(a)
         g_att.gen_trigger_block(a, 0, 0, .75, .75, nf, function(trig, other)
            if a.xf != other.xf and not g_menu_open and get_selected_item().interact and not is_game_paused() and btnp'4' then
               change_cur_ma(a)
               tbox_with_obj(a.text)
            end
         end)
      end, function(a)
         a.xf = a.x-g_pl.x > 0
      end, function(a)
         if g_pause_reason == 'dancing' then
            tbox([["nice playing lank!",trigger=@1]],function() add_money(10) end)
         end
      end
   )
end

g_att.lark = function(x, y)
   return g_att.npc(x,y,"Lark","I'm your biggest fan!",99)
end

g_att.sign = function(x, y, text_obj, sind)
   return create_actor([[
      id='sign', par={'confined','spr','wall'},
      att={
         sind=@3,rx=.5,ry=.5,x=@1, y=@2, i=@4
      }
      ]],x,y,sind,
      function(a)
         g_att.gen_trigger_block(a, 0, .125, .5, .625, nf, function(trig, other)
            if not g_menu_open and get_selected_item().interact and not is_game_paused() and btnp'4' then
               change_cur_ma(a)
               tbox_with_obj(text_obj)
            end
         end)
      end
   )
end

g_att.shop_item = function(x, y, text_obj, sind)
   return create_actor([[
      id='shop_item', par={'hurtable','confined','spr','wall'},
      att={
         name="Sign", health=10, max_health=10, evil=true,
         sind=@3,rx=.5,ry=.5,
         x=@1, y=@2, i=@4
      }
      ]],x,y,sind,
      function(a)
         text_obj.trigger = function()
            if remove_money(50) then
               enable_item(1) enable_item(2) enable_item(3)
               enable_item(4) enable_item(6) enable_item(7)
               enable_item(8)
            else
               sfx'7'
            end
         end
         a.trig = gen_text_trigger_block(a, 'd', text_obj)
      end
   )
end

g_att.item_show = function(a, sind)
   return create_actor([[
      id='item_show', par={'spr','rel'},
      att={
         rel_actor=@1,
         rel_y=-1.125,
         sind=@2
      }
   ]],a,sind)
end


-- a few types of triggers...
-- interactable triggers (press z to make it do something).
-- step inside triggers (houses are a good example).
-- directional trigger (easier to put a trigger next to an object).

-- Not sure if we need this...
-- triggers_template={{rel_x, rel_y, rx, ry, func}},

g_att.chest = function(x, y, direction, mem_loc)
   return create_actor([[
      id='chest', par={'confined','spr','wall','unpausable'},
      att={
         sind=50,rx=.375,ry=.375,
         x=@1, y=@2, xf=@3,tl_cur=@4,
         {i=@6},
         {i=@7, tl_max_time=2, e=@8},
         {i=@5, e=nf}
      }
      ]],x,y,direction,zdget(mem_loc) and 3 or 1, function(a) a.sind = 51 end,
      function(a)
         a.trig = gen_trigger_block_dir(a, a.xf and 'l' or 'r', function(b, other)
               if other.xf != a.xf and not g_menu_open and get_selected_item().interact and not is_game_paused() and btnp'4' then
                  a.sind = 51
                  a.tl_next = true
               end
            end
         )
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

function gen_text_trigger_block(a, dir, text_obj)
   return gen_trigger_block_dir(a, dir, function(trig, other)
      if not g_menu_open and get_selected_item().interact and not is_game_paused() and btnp'4' then
         change_cur_ma(a)
         tbox_with_obj(text_obj)
      end
   end
   )
end

g_att.gen_trigger_block = function(a, off_x, off_y, rx, ry, contains, intersects)
   return create_actor([[
      id='trigger_block', par={'rel', 'confined', 'trig'},
      att={
         rel_actor=@1, rel_x=@2, rel_y=@3, rx=@4, ry=@5, contains=@6, intersects=@7
      }
      ]], a, off_x, off_y, rx, ry, contains or nf, intersects or nf
   )
end

function gen_trigger_block_dir(a, dir, ...)
   local x, y = dir_to_coord(dir)
   return g_att.gen_trigger_block(a, x*a.rx*2,y*a.ry*2,.5+abs(y)*3/8,.5+abs(x)*3/8, ...)
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

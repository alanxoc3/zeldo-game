-- TODO: refactor the save platform!
ncreate_actor([[save_spot;2;confined,trig,drawable_obj]], [[
   name:"save spot";
   rx:.625;ry:.625;
   x:@1;y:@2;
   intersects:@3;contains:@3;
   pause_end:@4;not_contains_or_intersects:@5;
]], function(a)
   change_cur_ma(a)
end, function(a)
   if do_actors_intersect(a, g_pl) then
      if g_pause_reason == 'dancing' then
         if zdget'BANJO_TUNED' then
            memcpy(REAL_SAVE_LOCATION, TEMP_SAVE_LOCATION, SAVE_LENGTH)
            tbox[["the game has been saved!"]]
         else
            sfx'7'
            tbox[["the game won't save for^terrible music."]]
         end
      end
   end
end, function(a)
   if get_cur_ma() == a then
      change_cur_ma()
   end
end)

ncreate_actor([[sign;3;drawable,interactable]], [[
   name:"sign";sind:43;
   rx:.5;ry:.5;
   trig_x:0;trig_y:.125;
   trig_rx:.75;trig_ry:.625;
   x:@1;y:@2;text_obj:@3;interactable_trigger:@4;
]], function(a)
   tbox(a.text_obj)
end)

ncreate_actor([[grave;3;drawable,interactable]], [[
   name:"grave";sind:45;
   rx:.5;ry:.5;
   trig_x:0;trig_y:.125;
   trig_rx:.75;trig_ry:.625;
   x:@1;y:@2;text_obj:@3;interactable_trigger:@4;
]], function(a)
   tbox(a.text_obj)
end)

ncreate_actor([[shop_brang;2;shop_item,]], [[
   name:"brang";sind:4;
   x:@1;y:@2;mem_loc:HAS_BOOMERANG;
]])

ncreate_actor([[shop_shield;2;shop_item,]], [[
   name:"shield";sind:6;
   x:@1;y:@2;mem_loc:HAS_SHIELD;
]])

-- for the chest.
ncreate_actor([[item_show;3;post_drawable,confined,spr,rel;update,]], [[
   rel_actor:@1;sind:@2;mem_loc:@3;
   rel_y:-1.125;

   tl_max_time=2,e=@4;
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

ncreate_actor([[chest;4;drawable,interactable;update,]], [[
   name:"chest";
   sind:50;rx:.375;ry:.375;
   x:@1;y:@2;xf:@3;mem_loc:@4;
   trig_y:0;
   trig_rx:.5;trig_ry:.375;
   interactable_trigger:@6;

   i=@5,;i=nf,interactable_trigger=nf,sind=51;
]], function(a)
   a.tl_next = zdget(a.mem_loc)
   a.trig_x = a.xf and -.125 or .125
   a:interactable_init()
end, function(a)
   a.tl_next = true
   pause'chest'
   stop_music'1'
   a.item_show = _g.item_show(g_pl, 1, a.mem_loc)
end
)

ncreate_actor([[gen_trigger_block;7;rel,confined,trig]], [[
   rel_actor:@1;rel_x:@2;rel_y:@3;rx:@4;ry:@5;contains:@6;intersects:@7;
   not_contains_or_intersects:@8;
]], function(a)
   if get_cur_ma() == a.rel_actor then
      change_cur_ma()
   end
end
)

-- todo: trim code here.
ncreate_actor([[house;6;drawable,confined,spr]], [[
   x:@1;y:@2;room:@3;room_x:@4;room_y:@5;sind:@6;
   i:@7;destroyed:@8;
   iyy:-4;sw:2;sh:2;
]], function(a)
   a.b1 = _g.static_block(a.x-.75,a.y, .25, .5)
   a.b2 = _g.static_block(a.x+.75,a.y, .25, .5)
   a.b3 = _g.static_block(a.x,a.y-4/8, 1,.25)
   a.trig = _g.gen_trigger_block(a, 0, 1/8, .5, 5/8, function(trig, other)
      if other.pl then
         transition(a.room, a.room_x, a.room_y, g_pl)
      end
   end, nf)
end, function(a)
   a.b1.alive, a.b2.alive, a.b3.alive, a.trig.alive = false
end
)

-- SECTION: OBJECTS
ncreate_actor([[money;4;drawable,bounded,confined,tcol,spr,col,mov]], [[
   sind:36;rx:.125;ry:.125;
   x:@1;y:@2;dx:@3;dy:@4;
   touchable:false;
   hit:@5;
   destroyed:@7;

   tl_max_time=5,;
   i=@6,;
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

ncreate_actor([[static_block;4;confined,wall]],[[
   x:@1;y:@2;rx:@3;ry:@4;
   static:true;
   touchable:true;
]]
)

ncreate_actor([[thing_destroyed;3;confined,mov,drawable,bounded;update,]], [[
   parent:@1;c:@2;d:@5;

   i=@4,tl_max_time=@3;
]], function(a)
   local p = a.parent
   a.x = p.x+p.ixx/8 + rnd(.25)-.125
   a.y = p.y+p.iyy/8 + rnd(.25)-.125
   a.dx = p.dx
   a.dy = p.dy
end, function(a)
   scr_pset(a.x, a.y, a.c)
end)

ncreate_actor([[pot_projectile;3;drawable,col,confined,mov,spr,bounded,tcol]], [[
   tile_solid:true;
   sind:49;
   x:@1;y:@2;xf:@3;
   touchable:false;
   i:@4;
   destroyed:@6;
   hit:@7;
   tile_hit:@8;

   u=@5,tl_max_time=.3;
]], function(a)
   a.ax = bool_to_num(a.xf)*.04
end, function(a)
   a.iyy = -cos(a.tl_tim/a.tl_max_time/4)*8
end, function(a)
   sfx'9'
   destroy_effect(a, 10, 1, 13, 12)
   _g.money(a.x, a.y, a.dx, a.dy)
end, function(a, o)
   if o.touchable and not o.pl then
      call_not_nil(o, 'hurt', o, 0, 60)
      call_not_nil(o, 'knockback', o, .6, bool_to_num(a.xf), 0)
      a.tl_next = true
   end
end, function(a)
   a.tl_next = true
end)

-- x, y, sind
ncreate_actor([[pot;2;drawable,bounded,confined,tcol,spr,col,mov]], [[
   static:true;
   rx:.375;ry:.375;
   x:@1;y:@2;sind:49;
   touchable:true;
   i:@3;
]], function(a)
   _g.gen_trigger_block(a, 0, 0, .5, .5, nf, function(trig, other)
      if btnp(4) and not other.item then
         other.item = _g.grabbed_item(g_pl, a.sind, -7, function(x, y, xf)
            _g.pot_projectile(other.x, other.y, xf)
         end)
         a:kill()
      end
   end)
end
)

-- TODO: Bomb support.
ncreate_actor([[box;2;drawable,confined,wall,spr,col]], [[
   static:true;
   rx:.375;ry:.375;sind:35;x:@1;y:@2;
]])

ncreate_actor([[tall_tree;2;drawable,confined,wall,spr,col]], [[
   static:true;
   sw:1;sh:2;iyy:-4;
   rx:.5;ry:.5;sind:26;x:@1;y:@2;
]])

ncreate_actor([[spikes;3;trig,pre_drawable,confined,spr]], [[
   static:true;touchable:false;
   rx:.375;ry:.375;sind:54;x:@1;y:@2;offset:@3;u:@4;
   intersects:@5;contains:@5;i:@6;
]], function(a)
    if (a.tl_tim + a.offset) % 1 < .75 then
        a.sind = 54
    else
        a.sind = 53
    end
end, function(a, o)
  if a.sind == 53 then
    call_not_nil(o, 'hurt', o, 1, 15)
  end
end)

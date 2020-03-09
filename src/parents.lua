------------------------------------------
--           actor definitions          --
------------------------------------------

-- to generate an actor.
create_parent(
[['act', {}, {'room_init','pause_init','pause_update','pause_end','clean','delete'}, {
   alive=true,
   stun_countdown=0,
   i=nf, u=nf,
   update=@1,
   clean=@2,
   kill=@3,
   delete=@4,
   room_init=nf,
   pause_init=nf,
   pause_update=nf,
   pause_end=nf,
   destroyed=nf,
   get=@5 -- super useful
}
]], function(a)
   if a.alive and a.stun_countdown <= 0 then
      if tl_node(a,a) then
         a.alive = false
      end
   elseif a.stun_countdown > 0 then
      a.stun_countdown -= 1
   end
end, function(a)
   if not a.alive then
      a:destroyed()
      a:delete()
   end
end, function(a)
   a.alive = nil
end, del_act, function(a, ...)
   local arr, cur_act = gun_vals(...), a
   for i=1,#arr do
      cur_act = cur_act[arr[i]]
      if not cur_act then
         break
      end
   end
   return cur_act
end)

create_parent[[
   'confined', {'act'}, {}, {}
]]

create_parent[[
   'loopable', {'act'}, {},
   {tl_loop=true}
]]

create_parent([[
   'bounded', {'act'}, {},
   {check_bounds=@1}
]], function(a)
   if a.x+a.dx < g_cur_room.x+.5 then
      a.x = g_cur_room.x+.5
      a.dx = 0
   end

   if a.x+a.dx > g_cur_room.x+g_cur_room.w-.5 then
      a.x = g_cur_room.x+g_cur_room.w-.5
      a.dx = 0
   end

   if a.y+a.dy < g_cur_room.y+.5 then
      a.y = g_cur_room.y+.5
      a.dy = 0
   end

   if a.y+a.dy > g_cur_room.y+g_cur_room.h-.5 then
      a.y = g_cur_room.y+g_cur_room.h-.5
      a.dy = 0
   end
end)

create_parent(
[[ 'timed', {'act'}, {},
   {
      t=0,
      tick=@1
   }
]], function(a)
   a.t += 1
end)

create_parent(
[[ 'pos', {'act'}, {},
   {
      x=0,
      y=0
   }
]]
)

create_parent(
[[ 'vec', {'pos'}, {},
   {
      dx=0,
      dy=0,
      vec_update=@1
   }
]], function(a)
   a.x += a.dx
   a.y += a.dy
end)

create_parent(
[[ 'mov', {'vec'}, {},
   {
      ix=.85,
      iy=.85,
      ax=0,
      ay=0,
      move=@1,
      stop=@2
   }
]], function(a)
   a.dx += a.ax a.dy += a.ay
   a.dx *= a.ix a.dy *= a.iy
   if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
   if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end, function(a)
   a.ax, a.ay, a.dx, a.dy = 0, 0, 0, 0
end)

create_parent[[ 'move_pause', {'act'}, {'update', 'move', 'vec_update', 'tick'}, {}]]

create_parent(
[[ 'dim', {'pos'}, {'debug_rect'},
   {
      rx=.375,
      ry=.375,
      debug_rect=@1
   }
]], function(a)
   scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry, 8)
end)

-- used with player items/weapons.
create_parent(
[[ 'rel', {'act'}, {'rel_update'},
   {
      rel_actor=nil,
      rel_x=0,
      rel_y=0,
      rel_dx=0,
      rel_dy=0,
      flippable=false,
      rel_update=@1
   }
]], function(a)
   local a2 = a.rel_actor
   if a2 then
      if a2.alive then
         a.x, a.y   = a2.x  + a.rel_x , a2.y  + a.rel_y
         a.dx, a.dy = a2.dx + a.rel_dx, a2.dy + a.rel_dy
         a.rel_x += a.rel_dx
         a.rel_y += a.rel_dy
         a.xx, a.yy = a2.xx, a2.yy
         if a.flippable then
            a.xf = a2.xf
         end
      else
         a.alive = false
      end
   end
end)

create_parent(
[[ 'drawable_obj', {'act'}, {'reset_off'},
   {
      ixx=0,
      iyy=0,
      xx=0,
      yy=0,
      visible=true,
      reset_off=@1
   }
]], function(a)
   a.xx, a.yy = 0, 0
end)

create_parent[['drawable',     {'drawable_obj'}, {'d'}, {d=nf}]]
create_parent[['pre_drawable', {'drawable_obj'}, {'d'}, {d=nf}]]
create_parent[['post_drawable',{'drawable_obj'}, {'d'}, {d=nf}]]

create_parent(
[[ 'spr_obj', {'vec', 'drawable_obj'}, {},
   {
      sind=0,
      outline_color=BG_UI,
      sw=1,
      sh=1,
      xf=false,
      yf=false,
      draw_spr=@1,
      draw_out=@2,
      draw_both=@3
   }
]], scr_spr, scr_out, scr_spr_and_out
)

create_parent(
[[ 'spr', {'vec','spr_obj'}, {},
   {
      d=@1
   }
]], scr_spr_and_out)

create_parent(
[[ 'knockable', {'mov'}, {},
   {
      knockback=@1
   }
]], function(a, speed, xdir, ydir)
   a.dx = xdir * speed
   a.dy = ydir * speed
end)

create_parent(
[[ 'stunnable', {'mov','drawable_obj'}, {},
   {
      stun_update=@1
   }
]], function(a)
   if a.stun_countdown > 0 then
      a.ay, a.ax = 0, 0
      a.xx = rnd_one()
   end
end)

create_parent(
[[ 'hurtable', {'act'}, {},
   {
      health=-1,
      max_health=-1,
      hurt_func=nf,
      hurt=@1
   }
]], function(a, damage, stun_val)
   if a.max_health >= 0 and a.stun_countdown <= 0 then
      a.stun_countdown = stun_val
      a.health = min(a.max_health, a.health-damage)
      if a.health <= 0 then a.alive = false end
      a:hurt_func()
   end
end)

create_parent(
[[ 'anim', {'spr','timed'}, {},
   {
      sinds={},
      anim_loc=1,
      anim_off=0,
      anim_len=1,
      anim_spd=0,
      anim_sind=nil,
      anim_update=@1
   }
]], function(a)
   if a.anim_sind then
      a.sind = a.anim_sind
   else
      if a.t % a.anim_spd == 0 then
         a.anim_off += 1
         a.anim_off %= a.anim_len
      end

      a.sind = a.sinds[a.anim_loc + a.anim_off] or 0xffff
   end
end)

create_parent(
[[ 'wall', {'vec','dim'}, {},
   {
      block=true,static=true,touchable=true,hit=nf
   }
]])

create_parent(
[[ 'trig', {'vec','dim'}, {},
   {
      contains=nf,
      intersects=nf,
      not_contains_or_intersects=nf,
      contains_or_intersects=@1,
      trigger_update=@1
   }
]], function(a, b)
   if does_a_contain_b(a, b) then
      a:contains(b)
   elseif do_actors_intersect(a, b) then
      a:intersects(b)
   else
      a:not_contains_or_intersects(b)
   end
end)

create_parent(
[[ 'col', {'vec','dim'}, {},
   {
      static=false,
      touchable=true,
      hit=nf,
      move_check=@1
   }
]], function(a, acts)
   local hit_list = {}
   local move_check = function(dx, dy)
      local ret_val = dx+dy

      -- using nested closures :)
      local col_help = function(axis, spd_axis, a, b, pos, spd)
         if spd != 0 and pos < abs(a[axis]-b[axis]) then
            if a.touchable and b.touchable then
               local s_f = function(c)
                  if not c.static then
                     c[spd_axis] = (a[spd_axis] + b[spd_axis])/2
                  end
               end
               s_f(a) s_f(b)
               ret_val = 0
            end

            hit_list[b][spd_axis]=zsgn(spd)
         end
      end

      foreach(acts, function(b)
         if a != b and (not a.static or not b.static) then
            local x,y = abs(a.x+dx-b.x), abs(a.y+dy-b.y)
            if x < a.rx+b.rx and y < a.ry+b.ry then
               hit_list[b] = hit_list[b] or gun_vals[[dx=0,dy=0]]

               batch_call(col_help, [[
                  {'x', 'dx', @1, @2, @3, @4},
                  {'y', 'dy', @1, @2, @5, @6}
               ]], a, b, x, dx, y, dy)
            end
         end
      end)

      return ret_val
   end

   a.dx = move_check(a.dx, 0)
   a.dy = move_check(0, a.dy)

   -- hitting all the acts in the list.
   -- actor b, dirs d
   for b, d in pairs(hit_list) do
      a:hit(b,  d.dx,  d.dy)
   end
end)

create_parent(
[[ 'tcol', {'vec','dim'}, {},
   {
      tile_solid=true,
      tile_hit=nf,
      coll_tile=@1
   }
]], function(a, solid_func)
   local x, dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
   local y, dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
   if a.tile_solid then
      a.x, a.y, a.dx, a.dy = x, y, dx, dy
   end
end)

create_parent(
[[ 'danceable', {'act'}, {},
   {
      initial_time=0,
      dance_update=@1,
      pause_update=@1,
      pause_init=@2
   }
]], function(a)
   if is_game_paused'dancing' then
      a.dance_time = cos(t()-a.initial_time)
      if a.initial_xf then
         a.xf = a.dance_time > 0
      else
         a.xf = a.dance_time < 0
      end
   end
end, function(a)
   a.initial_xf = a.xf
   a.initial_time = t()
end)


-- SECTION: CHARS
create_parent(
[[ 'interactable', {'spr','wall','confined'}, {},
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
[[ 'nnpc', {'drawable','danceable', 'interactable'}, {},
   {
      rx=.5,ry=.5,iyy=-2,
      u=@1
   }
]], look_at_pl)

-- SECTION: INVENTORY
create_parent(
[[ 'bashable', {'rel', 'knockable', 'col'}, {},
   {
      bash_dx=1,
      rel_bash_dx=1,
      hit=@1, bash=@1
   }
]], function(a, o)
   if o != a.rel_actor then
      call_not_nil(o, 'knockback', o, a.bash_dx, bool_to_num(a.xf), 0)
      if a.rel_actor then
         call_not_nil(a.rel_actor, 'knockback', a.rel_actor, a.rel_bash_dx, bool_to_num(a.xf), 0)
      end
   end
end
)

create_parent(
[[ 'item', {'drawable', 'rel', 'confined', 'spr_obj'}, {},
   {being_held=true, destroyed=@1}
]], function(a)
   if a == a.rel_actor.item then a.rel_actor.item = nil end
end)

create_parent(
[[ 'pokeable', {'rel','drawable_obj','item'}, {},
   {
      i=@1,
      u=@2,
      e=@3,
      poke_init=@1,
      poke_update=@2,
      poke_end=@3,
      poke=20,
      poke_dist=20,
      poke_energy=0
   }
]], function(a) -- i
   a.xf = a.rel_actor.xf
   a.ixx = a.xf and a.poke_ixx or -a.poke_ixx
   use_energy(a.poke_energy)
end, function(a) -- u
   local spd = a.poke_dist/a.tl_max_time/FPS
   a.rel_dx = bool_to_num(a.xf)*spd
   pause_energy()
end, function(a) -- e
   a.rel_dx = 0
   a.rel_x = a.xf and -a.poke_dist or a.poke_dist
end
)

-- SECTION: NPCS
create_parent(
[[ 'shop_item', {'drawable','interactable'}, {'update'},
   {
      costable=true,
      interactable_trigger=@1,
      rx=.5, ry=.5,
      iyy=-3,
      trig_x=0,   trig_y=.125,
      trig_rx=.5, trig_ry=.625,
      mem_loc=BOGUS_SPOT, cost=99
   }
]], function(a)
   if remove_money(a.cost) then
      a:kill()
      g_att.item_show(g_pl, a.sind, a.mem_loc)
      pause'chest' -- not a chest, but is the same functionality.
      stop_music'1'
   else
      sfx'7'
   end
end
)

-- exists based on memory
create_parent(
[[ 'mem_dep', {'act'}, {},
   {
      room_init=@1,
      mem_loc=BOGUS_SPOT,
      mem_loc_expect=true
   }
]], function(a)
   if zdget(a.mem_loc) == a.mem_loc_expect then
      a:delete()
   end
end
)

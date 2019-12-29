-- attachment module
-- goes after libraries. (lib and draw)

g_act_arrs, g_att, g_par = {}, {}, {}

-- params: str, opts
function create_parent(...)
   local params = gun_vals(...)
   g_par[params.id] = function(a)
      a = a or {}
      return a[params.id] and a or attach_actor(params.id, params.par, params.att, a)
   end
end

-- params: {id, provided, parents, mem_loc?}, str, ...
function create_actor2(meta, template_str, ...)
   local template_params, id, provided, parents, mem_loc = {...}, munpack(gun_vals(meta))

   g_att[id] = function(...)
      if not mem_loc or not zdget(mem_loc) then
         local func_params, params = {...}, {}
         for i=1,provided do
            add(params, func_params[i] or false)
         end

         foreach(template_params, function(x)
            add(params, x)
         end)

         return attach_actor(id, parents, gun_vals(template_str, munpack(params)), {})
      end
   end
end

-- opt: {id, att, par}
function attach_actor(id, parents, template, a)
   -- step 1: atts from parent
   foreach(parents, function(par_id) a = g_par[par_id](a) end)
   tabcpy(template, a)

   -- step 2: add to list of objects
   if not a[id] then
      g_act_arrs[id] = g_act_arrs[id] or {}
      add(g_act_arrs[id], a)
   end

   -- step 3: attach timeline
   a.id, a[id] = id, true

   return a
end

function acts_loop(id, func, ...)
   for a in all(g_act_arrs[id]) do
      if a[func] then
         a[func](a, ...) end
   end
end

function del_act(a)
   for k, v in pairs(g_act_arrs) do
      if a[k] then del(v, a) end
   end
end

------------------------------------------
--           actor definitions          --
------------------------------------------

-- to generate an actor.
create_parent(
[[ id='act',
   att={
      alive=true,
      stun_countdown=0,
      i=nf, u=nf,
      update=@1,
      clean=@2,
      kill=@3,
      pause_update=nf,
      pause_init=nf,
      pause_end=nf,
      destroyed=nf
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
      del_act(a)
   end
end, function(a) a.alive = nil end)

create_parent[[
   id='confined', par={'act'},
   att={}
]]

create_parent[[
   id='loopable', par={'act'},
   att={tl_loop=true}
]]

create_parent([[
   id='bounded', par={'act'},
   att={check_bounds=@1}
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
[[ id='timed', par={'act'},
   att={
      t=0,
      tick=@1
   }
]], function(a)
   a.t += 1
end)

create_parent(
[[ id='pos', par={'act'},
   att={
      x=0,
      y=0
   }
]]
)

create_parent(
[[ id='vec', par={'pos'},
   att={
      dx=0,
      dy=0,
      vec_update=@1
   }
]], function(a)
   a.x += a.dx
   a.y += a.dy
end)

create_parent(
[[ id='mov', par={'vec'},
   att={
      ix=.85,
      iy=.85,
      ax=0,
      ay=0,
      move=@1
   }
]], function(a)
   a.dx += a.ax a.dy += a.ay
   a.dx *= a.ix a.dy *= a.iy
   if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
   if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end)

create_parent(
[[ id='dim', par={'pos'},
   att={
      rx=.375,
      ry=.375,
      debug_rect=@1
   }
]], function(a)
   scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry, 8)
end)

-- used with player items/weapons.
create_parent(
[[ id='rel', par={'act'},
   att={
      rel_actor=nil,
      rel_x=0,
      rel_y=0,
      rel_dx=0,
      rel_dy=0,
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
         a.xf = a2.xf
      else
         a.alive = false
      end
   end
end)

create_parent(
[[ id='drawable_obj', par={'act'},
   att={
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

create_parent(
[[ id='drawable', par={'act', 'drawable_obj'},
   att={d=nf}
]])

create_parent(
[[ id='spr_obj', par={'vec', 'drawable_obj'},
   att={
      sind=0,
      outline_color=1,
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
[[ id='spr', par={'vec','spr_obj','drawable'},
   att={
      d=@1
   }
]], scr_spr_and_out)

create_parent(
[[ id='knockable', par={'mov'},
   att={
      knockback=@1
   }
]], function(a, speed, xdir, ydir)
   a.dx = xdir * speed
   a.dy = ydir * speed
end)

create_parent(
[[ id='stunnable', par={'mov','drawable_obj'},
   att={
      stun_update=@1
   }
]], function(a)
   if a.stun_countdown > 0 then
      a.ay, a.ax = 0, 0
      a.xx = rnd_one()
   end
end)

create_parent(
[[ id='hurtable', par={'act'},
   att={
      health=-1,
      max_health=-1,
      hurt=@1
   }
]], function(a, damage, stun_val)
   if a.max_health >= 0 and a.stun_countdown <= 0 then
      a.stun_countdown = stun_val
      a.health = min(a.max_health, a.health-damage)
      if a.health <= 0 then a.alive = false end
   end
end)

create_parent(
[[ id='anim', par={'spr','timed'},
   att={
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
[[ id='wall', par={'vec','dim'},
   att={
      block=true,static=true,touchable=true,hit=nf
   }
]])

create_parent(
[[ id='trig', par={'vec','dim'},
   att={
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
[[ id='col', par={'vec','dim'},
   att={
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
               hit_list[b] = hit_list[b] or gun_vals'dx=0,dy=0'

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
      b:hit(a, -d.dx, -d.dy)
   end
end)

create_parent(
[[ id='tcol', par={'vec','dim'},
   att={
      'tile_hit'=nf,
      'coll_tile'=@1
   }
]], function(a, solid_func)
   a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
   a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
end)

create_parent(
[[ id='view', par={'act', 'confined'},
   att={
      x=0, y=0,
      w=1, h=1,
      follow_dim=1,
      room_crop=2,
      follow_act=nil
   }
]])

create_parent(
[[ id='unpausable', par={'act'},
   att={}
]])

create_parent(
[[ id='danceable', par={'act'},
   att={dance_update=@1, pause_update=@1, dance_init=@2, pause_init=@2}
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

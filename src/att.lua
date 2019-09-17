-- attachment module
-- goes after libraries. (lib and draw)

g_act_arrs, g_att = {}, {}

-- params: str, opts
function create_parent(...)
   local params = gun_vals(...)
   g_att[params.id] = function(a)
      return attach_actor(params, a or {})
   end
end

-- params: str, opts
function create_actor(...)
   return attach_actor(gun_vals(...))
end

-- opt: {id, att, par, tl}
function attach_actor(opt, a)
   -- step 1: atts from parent
   foreach(opt.par, function(par_id) a = g_att[par_id](a) end)

   tl_attach(a, opt.tl)
   copy_atts(a,opt.att)

   -- step 2: add to list of objects
   local id = opt.id
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
[[ id="act",
   att={
      alive=true,
      stun_countdown=0,
      i=nf, u=nf,
      update=@1,
      clean=@2,
      destroyed=nf,
      delete=@3
   }
]], function(a)
   if a.alive and a.stun_countdown == 0 then
      tl_update(a)
   end
end, function(a)
   if not a.alive then
      a:destroyed()
      a:delete()
   end
end, function(a) del_act(a) end)

create_parent([[id="confined",att={},par={"act"}]])

create_parent([[id="bounded",att={check_bounds=@1},par={"act"}]], function(a)
   local cur_room = g_rooms[g_cur_room]

   if a.x+a.dx < cur_room.x+.5 then
      a.x = cur_room.x+.5
      a.dx = 0
   end

   if a.x+a.dx > cur_room.x+cur_room.w-.5 then
      a.x = cur_room.x+cur_room.w-.5
      a.dx = 0
   end

   if a.y+a.dy < cur_room.y+.5 then
      a.y = cur_room.y+.5
      a.dy = 0
   end

   if a.y+a.dy > cur_room.y+cur_room.h-.5 then
      a.y = cur_room.y+cur_room.h-.5
      a.dy = 0
   end
end)

create_parent(
[[ id="timed",
   att={
      t=0,
      tl_tim=0,
      tick=@1
   },
   par={"act"}
]], function(a)
   a.t += 1
end)

create_parent(
[[ id="pos",
   att={
      x=0,
      y=0
   },
   par={"act"}
]]
)

create_parent(
[[ id="vec",
   att={
      dx=0,
      dy=0,
      vec_update=@1
   },
   par={"pos"}
]], function(a)
   a.x += a.dx
   a.y += a.dy
end)

create_parent(
[[ id="mov",
   att={
      ix=.85,
      iy=.85,
      ax=0,
      ay=0,
      move=@1
   },
   par={"vec"}
]], function(a)
   a.dx += a.ax a.dy += a.ay
   a.dx *= a.ix a.dy *= a.iy
   if a.ax == 0 and abs(a.dx) < .01 then a.dx = 0 end
   if a.ay == 0 and abs(a.dy) < .01 then a.dy = 0 end
end)

create_parent(
[[ id="dim",
   att={
      rx=.375,
      ry=.375,
      debug_rect=@1
   },
   par={"pos"}
]], function(a)
   scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry, 8)
end)

-- used with player items/weapons.
create_parent(
[[ id="rel",
   att={
      rel_x=0,
      rel_y=0,
      rel_dx=0,
      rel_dy=0,
      rel_update=@1
   },
   par={"act"}
]], function(a, a2)
   a.x, a.y, a.dx, a.dy = a2.x+a.rel_x, a2.y+a.rel_y, a2.dx+a.rel_dx, a2.dy+a.rel_dy
   a.xx, a.yy = a2.xx, a2.yy
end)

create_parent(
[[ id="drawable",
   att={
      ixx=0,
      iyy=0,
      xx=0,
      yy=0,
      d=nf,
      reset_off=@1
   },
   par={"act"}
]], function(a)
   a.xx, a.yy = 0, 0
end)

create_parent(
[[ id="spr",
   att={
      sind=0,
      sw=1,
      sh=1,
      xf=false,
      yf=false,
      draw_spr=@1
   },
   par={"vec","drawable"}
]], scr_spr)

create_parent(
[[ id="ospr",
   att={
      draw_out=@1
   },
   par={"spr"}
]], scr_spr_out)

create_parent(
[[ id="knockable",
   att={
      knockback=@1
   },
   par={"mov"}
]], function(a, speed, xdir, ydir)
   card_shake(15)
   if xdir != 0 then a.dx = xdir * speed
   else              a.dy = ydir * speed end
end)

create_parent(
[[ id="stunnable",
   att={
      stun=@1,
      stun_update=@2
   },
   par={"mov","drawable"}
]], function(a, len)
   if a.stun_countdown == 0 then
      a.stun_countdown = len
   end
end, function(a)
   if a.stun_countdown != 0 then
      a.ay, a.ax = 0, 0
      a.xx = rnd_one()
      a.stun_countdown -= 1
   end
end)

create_parent(
[[ id="hurtable",
   att={
      health=33,
      max_health=33,
      hurt=@1
   },
   par={"act"}
]], function(a, damage)
   a.health = min(a.max_health, a.health-damage)
   if a.health <= 0 then a.alive = false end
end)

create_parent(
[[ id="anim",
   att={
      sinds={},
      anim_loc=1,
      anim_off=0,
      anim_len=1,
      anim_spd=0,
      anim_sind=nil,
      anim_update=@1
   },
   par={"spr","timed"}
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
[[ id="wall",
   att={
      block=true,static=true,touchable=true,hit=nf
   },
   par={"vec","dim"}
]])

create_parent(
[[ id="trig",
   att={
      trigger=nf,
      is_in_trig=@1
   },
   par={"vec","dim"}
]], function(a, pl)
   if pl.x-pl.rx > a.x-a.rx and pl.x+pl.rx < a.x+a.rx
      and pl.y-pl.ry > a.y-a.ry and pl.y+pl.ry < a.y+a.ry then
      a.trigger(a, pl)
   end
end)

create_parent(
[[ id="item",
   att={},
   par={"confined","ospr"}
]])

create_parent(
[[ id="col",
   att={
      static=false,
      touchable=true,
      xb=0,
      yb=0,
      hit=nf,
      move_check=@1
   },
   par={"vec","dim"}
]], function(a, acts)
   local hit_list = {}
   local move_check = function(dx, dy)
      local touched = false

      -- using nested closures :)
      local col_help = function(axis, spd_axis, a, b, pos, spd)
         if spd != 0 and pos < abs(a[axis]-b[axis]) then
            if a.touchable and b.touchable then
               v=a[spd_axis] + b[spd_axis]
               local s_f = function(c) if not c.static then c[spd_axis] = v/2 end end
               s_f(a) s_f(b)
               touched = true
            end

            hit_list[b][axis]=spd>0 and 1 or 0 + spd<0 and 0xffff or 0
         end
      end

      foreach(acts, function(b)
         if a != b and (not a.static or not b.static) then
            local x,y = abs(a.x+dx-b.x), abs(a.y+dy-b.y)
            if x < (a.rx+b.rx) and y < (a.ry+b.ry) then 
               if not hit_list[b] then hit_list[b] = {x=0, y=0} end

               batch_call(col_help, [[
                  {"x", "dx", @1, @2, @3, @4},
                  {"y", "dy", @1, @2, @5, @6}
               ]], a, b, x, dx, y, dy)
            end
         end
      end)

      if touched then
         dx *= -a.xb
         dy *= -a.yb
      end

      return dx + dy
   end

   a.dx = move_check(a.dx, 0)
   a.dy = move_check(0, a.dy)

   -- hitting all the acts in the list.
   -- actor b, dirs d
   for b, d in pairs(hit_list) do
      a:hit(b,  d.x,  d.y)
      b:hit(a, -d.x, -d.y)
   end
end)

create_parent(
[[ id="tcol",
   att={
      "tile_hit"=nf,
      "coll_tile"=@1
   },
   par={"vec","dim"}
]], function(a, solid_func)
   a.x, a.dx = coll_tile_help(a.x, a.y, a.dx, a.rx, a.ry, 0, a, a.tile_hit, solid_func)
   a.y, a.dy = coll_tile_help(a.y, a.x, a.dy, a.ry, a.rx, 2, a, a.tile_hit, function(y, x) return solid_func(x, y) end)
end)

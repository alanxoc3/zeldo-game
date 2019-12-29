-- input is the particle states
function init_particles(_ps)
   g_ps = _ps
   g_pt=0

   -- clears, but also creates the cont field.
   clear_particles()
end

-- draws all the particles that are alive!
function draw_particles()
   for s in all(g_ps) do
      for p in all(s.cont) do
         s.draw(p)
      end
   end
end

-- this should only be called once a frame.
-- updates all the particles
function update_particles()
   for s in all(g_ps) do
      for p in all(s.cont) do
         if not s.update(p) then
            del(s.cont, p)
         end
      end
   end

   g_pt += 1
end

-- type, x, y, number of particles, rate
function spawn_particles(_t, _x, _y, _n, _r)
   if g_pt % _r == 0 then
      local s = g_ps[_t]
      for i=1, _n do
         add(s.cont, s.create(_x, _y))
      end
   end
end

-- clear all the particles from the buffer!
function clear_particles()
   -- clear the existing particles.
   for s in all(g_ps) do s.cont = {} end
end
--
--
--
--- tokens: 141
function create_snow_p()
   -- ang point down.
   local ang = .73+rnd(.04)
   local spd = .75+rnd(1)
   return {
      x=rnd(128),
      y=-5,
      dx=cos(ang)*spd,
      dy=sin(ang)*spd,
      rad=rnd(.7) + .5,
      age=0
   }
end

function update_snow_p(_p)
   if _p.x < -2 or _p.y < -10 or _p.x > 130 or _p.y > 128 then
      return false
   else
      _p.x   += _p.dx
      _p.y   += _p.dy
      _p.age += 1
   end

   return true
end

function draw_snow_p(_p)
   local col = 7
   circfill(_p.x, _p.y, _p.rad, col)
end

g_snow = {
   create = create_snow_p,
   update = update_snow_p,
   draw   = draw_snow_p,
   cont   = {},
}


function create_rain_p()
   -- ang point down.
   local ang = rnd(.1) + .625
   local spd = 2.5+rnd(1)
   return {
      x=rnd(160),
      y=-5,
      dx=cos(ang)*spd,
      dy=sin(ang)*spd,
      age=flr(rnd(25))
   }
end

function update_rain_p(_p)
   if _p.age > 80 or _p.x < 0 or _p.y < -10 or _p.x > 160 or _p.y > 128 then
      return false
   else
      _p.x   += _p.dx
      _p.y   += _p.dy
      _p.age += 1
   end

   return true
end

function draw_rain_p(_p)
   local col
   if _p.age > 75 then col=1
   elseif _p.age > 40 then col=13
   else col=12 end
   line(_p.x,_p.y,_p.x+_p.dx,_p.y+_p.dy,col)
end

g_rain = {
   create = create_rain_p,
   update = update_rain_p,
   draw   = draw_rain_p,
}

-- function tbox_stash_push()
   -- g_tbox_active_backup, g_tbox_messages_backup = g_tbox_active, g_tbox_messages
   -- tbox_clear()
-- end

-- function tbox_stash_pop()
   -- tbox_clear()
   -- g_tbox_messages, g_tbox_active = g_tbox_messages_backup, g_tbox_active_backup
-- end

-- function scr_circ(x, y, r, col)
--    circ(scr_x(x),scr_y(y), r*8, col)
-- end
-- 
-- function scr_line(x1, y1, x2, y2, col)
--    line(scr_x(x1),scr_y(y1),scr_x(x2),scr_y(y2), col)
-- end
-- 
-- function scr_print(txt, x, y, col)
   -- print(txt, scr_x(x),scr_y(y), col)
-- end

-- TODO: Force is outdated. Update me please.
-- function create_force(pl)
--    return create_actor([[
--       id='lank_force', par={'item'},
--       att={
--          rx=.3,
--          ry=.3,
--          sind=36,
--          xf=@2,
--          destroyed=@3,
--          u=@4,
--          rel_actor=@1,
--          touchable=false
--       }
--       ]], g_pl, pl.xf, function(a)
--          -- random room index
--          local i = flr(rnd(5))+1
--          transition_room(g_save_spots[i].room, g_save_spots[i].x, g_save_spots[i].y)
--       end, function(a)
--          item_check_being_held(a)
--       end
--    )
-- end

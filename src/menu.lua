-- a box with a character inside.
function draw_ma(x, y, sind, flip)
   camera(-x,-y)

   rectfill(0, 0, 17, 17, 5)
   rectfill(1, 1, 16, 16, 13)

   fillp(flr(g_pat_1))
   rectfill(2, 2, 15, 15, 0xd6)
   fillp()

   spr_out(sind, 5, 5, 1, 1, flip, false, 1)

   camera()
end

function draw_energy_bar(x, y)
   local width = 102
   local cur_energy = flr(max(min(g_energy/g_max_energy*width,width-1),1))

   -- blue part
   fillp(flr(g_pat_3))
   rectfill(x,y,x+cur_energy,y+5,0x6c)
   fillp()

   rect(x,y+1,x+cur_energy,y+4,0xd)

   -- tip
   rectfill(x+cur_energy,y,x+cur_energy,y+5,9)
   rectfill(x+cur_energy,y+2,x+cur_energy,y+3,10)

   -- outline
   rect    (x,  y,  x+width,  y+5,1)
end

-- 5927
function draw_health_bar(x, y, max_health, health, flip)
   -- normalize health to draw
   health = health/max_health*37+1
   local x_begin, x_end = 1, health

   if flip then
      health = 39-health
      x_begin, x_end = health, 38
   end

   camera(-x,-y)
   batch_call(rectfill, [[
      {0, 0, 39, 3, 1},
      {@1, 1, @2, 1, 11},
      {@1, 2, @2, 2, 3},
      {@3, 1, @3, 2, 9},
      {@3, 1, @3, 1, 10}
   ]], x_begin, x_end, health)
   camera()
end

function draw_stat(x, y, a, flip)
   if a and a.alive then
      local health_str = flr(a.health).."/"..a.max_health
      local operator = x+20
      local operator2 = operator
      local operator3 = operator

      if flip then
         operator, operator2, operator3 = align_right(a.id, x-17), x-59, align_right(health_str, x-17)
      end

      -- four things: ma, name, bar, health
      draw_ma(flip and (x-17) or x,y,a.sind, flip)
      zprint(a.id,operator,y, false)
      draw_health_bar(operator2,y+7,a.max_health,a.health, flip)
      zprint(health_str,operator3,y+13,true)
   end
end

function draw_status()
   -- power orbs
   spr(40, 108, 3)
   zprint(get_square_str(), 116, 4)

   -- energy bar
   draw_energy_bar(1,3)

   -- status panels
   draw_stat(1, 108, g_pl)
   draw_stat(126, 108, g_cur_enemy, true)
end

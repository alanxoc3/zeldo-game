-- a box with a character inside.
function draw_ma(x, y, a)
   local ox, oy, oox, ooy = g_x, g_y, g_off_x, g_off_y
   --local old_off_y = g_off_y
   camera(-x, -y)
   g_off_x = -a.x
   g_off_y = -a.y
   g_x = -9/8
   g_y = -11/8
   -- function scr_x(x) return (x+g_off_x)*8-flr(g_x*8) end
   -- print(g_off_x, 50, 2)
   -- print(g_off_y, 100, 2)

   batch_call(rectfill, [[
      {0, 0, 17, 17, 5},
      {1, 1, 16, 16, 6},
      {2, 2, 15, 15, 0}
   ]], patternize(0x43,4))

   clip(x+2, y+2, 14, 14)
   acts_loop("drawable", "d")

   clip() camera()
   g_x, g_y, g_off_x, g_off_y = ox, oy, oox, ooy
end

function draw_energy_bar(x, y)
   local width = 103
   local cur_energy = flr(max(min(g_energy/g_max_energy*width,width-1),1))

   camera(-x,-y)
   batch_call(rect, [[
      {0,2,@1,3,@2},
      {1,1,@1,4,0x100d},
      {@1,0,@1,5,9},
      {@1,2,@1,3,10},
      {0,0,@3,5,1}
   ]], cur_energy, patternize(0x6c,3), width)
   camera()
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
   batch_call(rect, [[
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

      if flip then
         operator, operator2 = x-17, x-59
      end

      draw_ma(flip and (x-17) or x,y,a)
      draw_health_bar(operator2,y+7,a.max_health,a.health, flip)

      zprint(a.name,align_text(a.name, operator, flip),y)
      zprint(health_str,align_text(health_str, operator, flip),y+13,true)
   end
end

function draw_status()
   -- power orbs
   spr_out(39, 107, 2, 1, 1, false, false, 1)
   spr(39, 107, 2)

   zprint(get_money_str(), 116, 4)

   -- energy bar
   draw_energy_bar(1,3)

   -- status panels
   batch_call(draw_stat, [[
      {1, 108, @1},
      {126, 108, @2, true}
   ]], g_pl, g_cur_enemy)
end

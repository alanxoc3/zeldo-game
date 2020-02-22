-- a box with a character inside.

function change_cur_ma(a)
   g_right_ma_view:change_ma(a)
end

function get_cur_ma()
   return g_right_ma_view.follow_act
end

function draw_ma(view, x, y, a)
   local old_view = g_view
   g_view = view
   map_and_act_draw(x/8,y/8, [[0,0,13,1]])
   g_view = old_view
end

function draw_energy_bar(x, y)
   local width = 54
   local cur_energy = flr(min(width-g_energy/g_max_energy*width, width))

   camera(-x,-y)

   if cur_energy > 0 then
      rectfill(-width, 2, -width, 5, 13)
      rectfill(width-1, 2, width-1, 5, 13)
      rectfill(-cur_energy, 2, cur_energy-1, 5, 2)
      rectfill(-cur_energy, 2, cur_energy-1, 4, 8)
   end
   camera()
end

-- 5927
function draw_health_bar(x, y, max_health, health, flip)
   -- normalize health to draw
   health = health/max_health*37+1
   local x_begin, x_end = 0, health

   if flip then
      health = 39-health
      x_begin, x_end = health, 38
   end

   camera(-x,-y)
   batch_call(rectfill, [[
      {@1, 0, @2, 2, 11},
      {@1, 3, @2, 3, 3}
   ]], x_begin, x_end)
   camera()
end

function draw_stat(view, x, y, flip)
   local a = view.follow_act
   if a and a.alive then
      local operator = x+20
      local operator2 = operator

      if flip then
         operator, operator2 = x-17, x-59
      end

      draw_ma(view, flip and (x-8) or x+9,y+9,a)

      -- TODO: Refactor here.
      if a.hurtable then
         local health_str = a.max_health < 0 and '???/???' or flr(a.health)..'/'..a.max_health
         draw_health_bar(operator2,y+7,a.max_health,a.health, flip)
         zprint(health_str,align_text(health_str, x+61, not flip),y+13,true, 7, 5)
      elseif a.costable then
         draw_money(x-33, y+13, a.cost)
      end

      if a.name then
         zprint(a.name,align_text(a.name, operator, flip),y-1, true, 7, 5)
      end
   end
end

function get_money_str(money)
   local new_str = '0'..money
   return sub(new_str, #new_str-1, #new_str)
end

function draw_money(x, y, amount)
   zprint("$"..get_money_str(amount), x+3, y, true, 7, 5)
end

function draw_status()
   local x = 48
   local y = 106
   -- power orbs
   draw_money(x-28, y+13, g_money)

   -- energy bar
   draw_energy_bar(64,1)

   -- status panels
   batch_call(draw_stat, [[
      {@1, 3, 106},
      {@2, 124, 106, true}
   ]], g_left_ma_view, g_right_ma_view)
end

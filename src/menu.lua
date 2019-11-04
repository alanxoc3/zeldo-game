-- a box with a character inside.

function change_cur_ma(a)
   if not a.pl and a.hurtable then
      g_right_ma_view.follow_act = a
   end
end

function draw_ma(view, x, y, a)
   local old_view = g_view
   g_view = view
   map_and_act_draw(x/8,y/8, {0,5,6})
   g_view = old_view
end


function draw_energy_bar(x, y)
   local width = 104
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

function draw_stat(view, x, y, flip)
   local a = view.follow_act
   if a and a.alive then
      local operator = x+20
      local operator2 = operator

      if flip then
         operator, operator2 = x-17, x-59
      end

      draw_ma(view, flip and (x-8) or x+9,y+9,a)

      if a.hurtable then
         local health_str = a.max_health < 0 and '???/???' or flr(a.health)..'/'..a.max_health
         draw_health_bar(operator2,y+7,a.max_health,a.health, flip)
         zprint(health_str,align_text(health_str, operator, flip),y+13,true)
      end

      zprint(a.name,align_text(a.name, operator, flip),y)
   end
end

function draw_status()
   -- power orbs
   spr_and_out(39, 111, 6, 1, 1, false, false, 1)
   zprint(get_money_str(), 116, 4)

   -- energy bar
   draw_energy_bar(1,3)

   -- status panels
   batch_call(draw_stat, [[
      {@1, 1, 108},
      {@2, 126, 108, true}
   ]], g_left_ma_view, g_right_ma_view)
end

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

function draw_bar(x1,y1,x2,y2,num,dem,align,fg,bg)
   local bar_off = x2-x1-min(num/dem, 1)*(x2-x1)
   if align == 0 then bar_off /= 2 end

   if num > 0 then
      batch_call(rectfill, [[
         {@1, @2, @1, @4, 13},
         {@3, @2, @3, @4, 13},
         {@5, @2, @6, @4, @7},
         {@5, @4, @6, @4, @8}
      ]], x1, y1, x2, y2,
         ceil(x1+(align >= 0 and bar_off or 0)),
         flr(x2-(align <= 0 and bar_off or 0)),
         fg, bg)
   end
end

function draw_stat(view, x, y, flip)
   local a = view.follow_act
   if a and a.alive then
      local operator = x+20
      local operator2 = operator

      if flip then
         operator, operator2 = x-17, x-58
      end

      draw_ma(view, flip and (x-8) or x+9,y+9,a)

      -- TODO: Refactor here.
      if a.hurtable then
         -- Health Bar.
         draw_bar(operator2, y+7, operator2+38, y+10, a.health,a.max_health, flip and 1 or -1, 11, 3)
         local health_str = a.max_health < 0 and '???/???' or flr(a.health)..'/'..a.max_health
         zprint(health_str,align_text(health_str, x+20, flip),y+13,true, 7, 5)
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

   draw_money(x, y+13, g_money)
   draw_bar(10, 2, 117, 6, g_energy, MAX_ENERGY, 0, 8, 2)

   -- status panels
   batch_call(draw_stat, [[
      {@1, 3, 106},
      {@2, 124, 106, true}
   ]], g_left_ma_view, g_right_ma_view)
end

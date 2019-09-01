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
   local width = 88
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

function draw_health_bar(x, y, max_health, health, flip)
   -- normalize health to draw
   local health = (health/max_health)*37+1

   x = flip and (x-42) or x
   -- outline
   rect    (x,y,x+39,y+3,1)

   -- green
   if flip then
      health = 39-health
      -- green
      rectfill(x+health,y+1,x+38,y+1,11)
      rectfill(x+health,y+2,x+38,y+2,3)
   else
      -- green
      rectfill(x+1,y+1,x+health,y+1,11)
      rectfill(x+1,y+2,x+health,y+2,3)
   end

   -- tip
   rectfill(x+health,y+1,x+health,y+2,9)
   rectfill(x+health,y+1,x+health,y+1,10)
end

-- todo: make the code size smaller here.
function draw_stat(x, y, name, sind, max_health, health, flip)
   -- temp, for time.
   health = max(0, min(max_health, flr(health)))

   local operator = flip and -17 or 20

   -- four things: ma, name, bar, health
   draw_ma(flip and (x-17) or x,y,sind, flip)
   zprint(name,x+operator,y, false, flip)
   draw_health_bar(x+operator,y+7,max_health,health, flip)
   zprint(flr(health).."/"..max_health,x+operator,y+13,true, flip)
end

function draw_status()
   -- item
   spr(g_all_items[g_selected].sind, 1, 2)

   -- power orbs
   spr(40, 108, 3)
   zprint(get_square_str(), 116, 4)

   draw_energy_bar(14,3)

   -- dividers
   rectfill(11,2,11,9,5)
   rectfill(105,2,105,9,5)

   -- draw bottom bar:
   if g_pl and g_pl.alive then
      draw_stat(1, 108, g_pl.id, g_pl.sind, g_pl.max_health, g_pl.health)
   end

   if g_cur_enemy and g_cur_enemy.alive then
      draw_stat(126, 108, g_cur_enemy.id, g_cur_enemy.sind, g_cur_enemy.max_health, g_cur_enemy.health, true)
   end

   -- divider
   rectfill(63,107,64,126,6)
end

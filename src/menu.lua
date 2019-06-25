-- menu enemy
g_ma = 56
g_ma_out = true
g_ma_col = 0xd6
function draw_ma(x, y)
   camera(-x,-y)
   -- rectfill(0, 108, 19, 127, 1)
   rectfill(0, 1, 17, 18, 5)
   rectfill(1, 2, 16, 17, 13)
   fillp(flr(g_pat_1))
   rectfill(2, 3, 15, 16, g_ma_col)

   -- rectfill(2, 110, 17, 125, g_ma_col)
   fillp()
   if g_ma_out then
      spr_out(g_ma, 5, 6, 1, 1, false, false, 1)
   else
      spr(g_ma, 4, 4, 1, 1, false, false, 1)
   end
   -- rect(2, 110, 17, 125, 1)
   camera()
end

-- change style
-- change to actor
-- change to sprite

function draw_energy_bar(x, y, energy)
   local max_energy = 100
   local cur_energy = min(energy/max_energy*36,36)
   rectfill(x-1-cur_energy,y-1,x+1+1+cur_energy,y+2,13)
   rectfill(x-cur_energy,y,x+1+cur_energy,y+1,12)
   rect(x-37,y-2,x+38,y+3,5)
end

function draw_status_bars()
   -- screen

   -- top bar
   -- spr(44, 94, 2)
   -- spr(45, 84, 2)
   -- spr(46, 74, 2)
   -- zprint("7", 89+10, 4)

   -- yoff = 1
   -- for i=flr(g_pl.max_hearts)-1,0,-1 do
      -- s = (i < g_pl.hearts) and 41 or 42
      -- spr(s, 15 + i*4, yoff)
      -- yoff = (yoff==1) and 3 or 1
   -- end

   local x = 63
   local r = 38
   --rectfill(12,3,62,8,13)
   -- rectfill(12,5,62,6,12)
   --
   draw_energy_bar(63,5,t()*50)

   rectfill(23,2,23,9,5)
   zprint("009", 2, 4)
   spr(40, 14, 2)
   -- spr(g_all_items[g_selected].sind, 2, 2)

   -- power orbs
   spr(40, 106, 2)
   zprint("009", 127-12-4+2+2, 4)

   -- dividers
   -- rectfill(12, 2,12, 9,7)
   rectfill(104,2,104,9,5)

end

-- menu enemy
g_ma = 56
g_ma_out = true
g_ma_col = 0xd6
function draw_ma(x, y)
   camera(-x,-y)
   -- rectfill(0, 108, 19, 127, 1)
   rectfill(0, 0, 17, 19, 5)
   rectfill(1, 1, 16, 18, 13)
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

function draw_status_bars()
   -- screen

   -- top bar
   -- rectfill(0, 0, 127, 10, 0)
   spr(g_all_items[g_selected].sind, 2, 2)
   rectfill(12,2,12,9,7)

   yoff = 1
   for i=flr(g_pl.max_hearts)-1,0,-1 do
      s = (i < g_pl.hearts) and 41 or 42
      spr(s, 15 + i*4, yoff)
      yoff = (yoff==1) and 3 or 1
   end

   -- bottom rect
   --rectfill(0, 107, 127, 127, 0)

   rectfill(104,2,104,9,7)
   spr(40, 106, 2)
   zprint("9", 127-12-4+2+2, 4)
end

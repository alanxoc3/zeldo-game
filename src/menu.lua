-- like a box with a character inside.
function draw_ma(x, y, sind, flip)
   camera(-x,-y)

   rectfill(0, 1, 17, 18, 5)
   rectfill(1, 2, 16, 17, 13)

   fillp(flr(g_pat_1))
   rectfill(2, 3, 15, 16, 0xd6)
   fillp()

   spr_out(sind, 5, 6, 1, 1, flip, false, 1)

   camera()
end

-- change style
-- change to actor
-- change to sprite

function draw_energy_bar(x, y, energy)
   local width = 41
   local max_energy = 100
   local cur_energy = flr(min(energy/max_energy*width,width))
   rectfill(x-cur_energy,y-1,x+1+cur_energy,y+2,13)
   rectfill(x+1-cur_energy,y,x+cur_energy,y+1,12)
   rect(x-width,y-2,x+width+1,y+3,5)

   rectfill(x-width-3,y-3,x-width-3,y+4,5)
   rectfill(x+width+4,y-3,x+width+4,y+4,5)

   spr_out(g_all_items[g_selected].sind, x-3, y-3, 1, 1, false, false, 5)
end

function draw_bot_bar()
   draw_ma(1,107,56)
   draw_ma(109,107,76, true)
   zprint("lank",21,109)
   zprint("5/100",21,121)
   zprint("cannon",84,109)

   -- red
   rectfill(21,115,60,118,8)
   rect    (21,115,60,118,2)

   -- green
   rectfill(21,115,45,118,11)
   rect    (21,115,45,118,3)

   rectfill(45,115,45,118,6)
   rectfill(45,116,45,117,7)

   rectfill(63,107,64,126,6)
end

function draw_top_bar()
   draw_energy_bar(66,5,flr(t()*50))
   -- zprint("009", 2, 4)
   -- spr(40, 01, 2) spr(40, 05, 3) spr(40, 09, 2) spr(40, 13, 3)

   -- power orbs
   spr(40, 0, 2)
   zprint("009", 9, 4)

   -- items
   --spr(g_all_items[g_selected].sind, 64-4, 2)
   spr(46, 114, 2)
   zprint("9", 124, 4)

   -- dividers
   -- rectfill(12, 2,12, 9,7)

end

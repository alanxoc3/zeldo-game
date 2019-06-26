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
   local width = 88
   local max_energy = 100
   local cur_energy = flr(max(min(energy/max_energy*width,width-1),1))
   -- rectfill(x,  y,x+width,y+5,1)
   -- rectfill(x,  y+2,x+width,y+3,1)

   rectfill(x,y+1,x+cur_energy,y+4,0xd)

   fillp(flr(g_pat_3))
   rectfill(x,y+2,x+cur_energy,y+3,0x6c)
   fillp()

   -- tip
   rectfill(x+cur_energy,y+1,x+cur_energy,y+4,0x79)
   rectfill(x+cur_energy,y+2,x+cur_energy,y+3,0x7a)

   -- outline
   rect    (x,  y,  x+width,  y+5,1)

end

function draw_bot_bar()
   draw_ma(1,107,56)
   draw_ma(109,107,76, true)
   zprint("lank",21,108)
   zprint("5/100",21,121, true)
   zprint("cannon",84,108)

   -- red
   -- rectfill(21,115,60,117,8)
   -- rect    (21,115,60,117,2)

   -- green
   rectfill(21,115,45,117,11)
   rect    (21,115,45,117,3)


   rect    (21,115,60,118,1)

   -- tip
   rectfill(45,116,45,117,9)
   rectfill(45,116,45,116,10)


   -- divider
   rectfill(63,107,64,126,6)
end

function draw_top_bar()
   -- item
   spr(g_all_items[g_selected].sind, 1, 2)

   -- power orbs
   spr(40, 108, 3)
   zprint("009", 116, 4)

   draw_energy_bar(14,3,0*sin(t()/2)*60+50)

   -- dividers
   rectfill(11,2,11,9,5)
   rectfill(105,2,105,9,5)
end

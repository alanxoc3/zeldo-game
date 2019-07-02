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

function draw_health_bar(x, y, max_health, health)
   health = min(max_health, flr(health))
   health = max(0, health)

   zprint(flr(health).."/"..max_health,21,121,true)

   health = (health/max_health)*37+1

   -- green
   rectfill(x,y,x+health,y+2,11)
   rect    (x,y,x+health,y+2,3)

   rect    (x,y,x+39,y+3,1)

   -- tip
   rectfill(x+health,y+1,x+health,y+2,9)
   rectfill(x+health,y+1,x+health,y+1,10)

end

-- returns the x position of the text, to align right.
function zprint_right(text,x,...)
   zprint(text,x-#text*4-1,...)
end

function draw_bot_left(name, sind, max_health, health)
   zprint(name,21,108)
   draw_ma(1,107,sind)
   draw_health_bar(21,115,max_health,health)
end

function draw_bot_right(name, sind, max_health, health)
   zprint_right(name,109,108)
   draw_ma(109,107,sind)
   draw_health_bar(67,115,max_health,health)
end

function draw_bot_bar()
   -- draw_ma(109,107,76, true)
   -- zprint_right("5/100",109,121,true)
   -- zprint_right("cannon",109,108)
   draw_bot_left("lank", 56, 50, sin(t())*100)
   draw_bot_right("cannon", 76, 50, sin(t())*100)

   -- draw_health_bar(67,115,50,sin(t()+.5)*50)

   -- divider
   rectfill(63,107,64,126,6)
end

function draw_top_bar()
   -- item
   spr(g_all_items[g_selected].sind, 1, 2)

   -- power orbs
   spr(40, 108, 3)
   zprint("009", 116, 4)

   draw_energy_bar(14,3,sin(t()/2)*60+50)

   -- dividers
   rectfill(11,2,11,9,5)
   rectfill(105,2,105,9,5)
end

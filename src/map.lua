-- 5181
g_off_x = 0
g_off_y = 0
function draw_cur_room(x, y)
   local cur_room = g_rooms[g_cur_room]

   -- g_y = 0
   local rw = min(16, cur_room.w)
   local rh = min(12, cur_room.h)
   local rx = x - rw/2
   local ry = y - rh/2

   g_off_x = -(16-rw)/2+rx
   g_off_y = -(16-rh)/2+ry

   for k,v in pairs({5, 1, 1}) do
      rect(rx*8+k,ry*8+k, (rx+rw)*8-k-1, (ry+rh)*8-k-1, v)
   end

   clip(rx*8+4, ry*8+4, rw*8-8, rh*8-8)

   if g_menu_open then g_pal = g_pal_gray
   else g_pal = g_pal_norm end
   restore_pal()

   rectfill(0,0,127,127,cur_room.c)

   scr_map(cur_room.x, cur_room.y, cur_room.x, cur_room.y, cur_room.w, cur_room.h)

   isorty(g_act_arrs["drawable"])
   acts_loop("drawable", "draw")

   clip()
   camera(0)
end

function isorty(t)
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i-=1
        end
    end
end

function map_init()
   g_rooms = gun_vals([[
      $all$=                   { n=$debug$,           c=03, x=0,   y=0,  w=128,h=64 },

      $lark_home$=             { n=$house$,           c=04, x=20,  y=0,  w=06, h=7  },
      $lank_home$=             { n=$house$,           c=04, x=0,   y=7,  w=08, h=8  },

      $lank_path$=           { n=$village$,  i=@1,  c=03, x=0,   y=15, w=16, h=6  },
      $village$=               { n=$village$,  i=@2,  c=03, x=16,  y=15, w=16, h=17 },

      $field$=                 { n=$field$,           c=03, x=32,  y=15, w=32, h=17 },

      $grave_path$=        { n=$cemetary$,        c=05, x=32,  y=0,  w=16, h=8  },
      $graveyard$=             { n=$cemetary$,        c=05, x=96, y=0,  w=16, h=32 },
      $canyon_path$=           { n=$cemetary$,        c=05, x=32,  y=8,  w=16, h=7  },

      $canyon_1$=           { n=$canyon$,          c=04, x=48,  y=0,  w=16, h=15 },
      $canyon_2$=           { n=$canyon$,          c=04, x=84,  y=12, w=12, h=20 },
      $canyon_3$=           { n=$canyon$,          c=04, x=80,  y=0,  w=16, h=12 },

      $maze_1$=            { n=$forest$,          c=03, x=48,  y=32, w=16, h=8  },

      $tech_entrance$=         { n=$tech$,            c=13, x=112, y=56, w=16, h=8  },
      $tech_generator$=        { n=$tech$,            c=13, x=96,  y=32, w=16, h=32 },
      $ivan_boss_room$=        { n=$tech$,            c=13, x=112, y=44, w=16, h=12 },
      $computer_room$=         { n=$tech$,            c=13, x=112, y=32, w=16, h=12 }
   ]], function() -- @1
      gen_house(2,17.5,"lank_home", 4, 14.5) -- lank house.
      gen_top(5, 18)
   end, function() -- @2
      gen_house(22,17.5,"lark_home", 23, 6.5) -- lark house
   end)

   g_doors = gun_vals([[
      $lark_home$={ d={$village$,          22, 18} },
      $lank_home$={ d={$lank_path$,       2, 18} },
      $lank_path$=    { r={$village$,          17, 18} },
      $tech_entrance$=  { u={$ivan_boss_room$,  120, 55}, l={$tech_generator$,  111, 60} },
      $tech_generator$= { r={$tech_entrance$,   113, 60} },
      $ivan_boss_room$= { u={$computer_room$,   120, 43}, d={$tech_entrance$,   120, 57} },
      $computer_room$=  { d={$ivan_boss_room$,  120, 45} }, 
      $maze_1$=  { u={$field$,  52, 31} }, 
      $village$=        { l={$lank_path$,      15, 18}, r={$field$,            33, 28} },
      $field$=          { l={$village$,          31, 28}, r={$grave_path$,   33,  2}, d={$maze_1$,       52, 33} },
      $grave_path$= { l={$field$,            63, 29}, r={$graveyard$,       97, 29} },
      $graveyard$=      { l={$grave_path$,   47,  6}, r={$canyon_path$,      33,  8}, },
      $canyon_path$=    { l={$graveyard$,       111, 29}, r={$canyon_1$,           49, 11} }, 
      $canyon_1$=       { l={$canyon_path$, 47,11}, r={$canyon_2$,    85,30} },
      $canyon_2$=       { l={$canyon_1$, 63,04}, u={$canyon_3$, 88,11} },
      $canyon_3$=       { d={$canyon_2$, 90,13} }, 
   ]])

end

function load_room(new_room, rx, ry)
   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]

   -- take care of actors.
   acts_loop("confined", "kill")
   if cur_room.i then cur_room.i() end

   local x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   g_pl.x = rx
   g_pl.y = ry
   g_ma = 54 -- todo: something about this menu actor variable.

   load_view(x, y, w, h, 5, 11, 2, 2)
   center_view(g_pl.x, g_pl.y)

   -- get rid of current text.
   tbox_clear()
end

function room_update()
   cur_door = g_doors[g_cur_room]

   -- plus .5 and minus .375 is because there is a screen border.
   if cur_door then
      if g_pl.y > g_ry+g_rh-.375 and cur_door.d then
         load_room(cur_door.d[1], cur_door.d[2], cur_door.d[3])
      elseif g_pl.y < g_ry + .5 and cur_door.u then
         load_room(cur_door.u[1], cur_door.u[2], cur_door.u[3])
      elseif g_pl.x > g_rx+g_rw-.375 and cur_door.r then
         load_room(cur_door.r[1], cur_door.r[2], cur_door.r[3])
      elseif g_pl.x < g_rx +.5 and cur_door.l then
         load_room(cur_door.l[1], cur_door.l[2], cur_door.l[3])
      end
   end
end

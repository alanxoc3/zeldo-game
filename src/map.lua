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
      $all$=                   {        c=4, x=0,   y=0,  w=128,h=64 },
      $lark's house$=          {        c=4, x=20,  y=0,  w=6,  h=7  },
      $lank's house$=          {        c=4, x=0,   y=7,  w=8,  h=8  },
      $lank's path$=           { i=@1,  c=3, x=0,   y=15, w=16, h=6  },
      $village$=               { i=@2,  c=3, x=16,  y=15, w=16, h=17 },
      $field$=                 {        c=3, x=32,  y=14, w=32, h=18 },
      $graveyard path$=        {        c=5, x=32,  y=0,  w=15, h=6  },
      $graveyard$=             {        c=5, x=112, y=0,  w=16, h=32 },
      $canyon path$=           {        c=5, x=32,  y=6,  w=15, h=8  },
      $canyon$=                {        c=4, x=47,  y=0,  w=17, h=14 },
      $castle entrance$=       {        c=4, x=84,  y=0,  w=12, h=20 },
      $maze trap$=             {        c=3, x=40,  y=32, w=16, h=12 },
      $maze start$=            {        c=3, x=32,  y=32, w=8,  h=8  },
      $maze 1$=                {        c=3, x=56,  y=32, w=8,  h=8  },
      $maze 2$=                {        c=3, x=32,  y=40, w=8,  h=8  },
      $maze 3$=                {        c=3, x=56,  y=40, w=8,  h=8  },
      $maze 4$=                {        c=3, x=32,  y=48, w=8,  h=8  },
      $maze end$=              {        c=3, x=56,  y=48, w=8,  h=8  },
      $maze boss path$=        {        c=3, x=48,  y=56, w=16, h=8  },
      $maze boss$=             {        c=3, x=40,  y=44, w=16, h=12 },
      $sword sanctuary$=       {        c=3, x=32,  y=56, w=16, h=8  },
      $tech entrance$=         {        c=13,x=112, y=56, w=16, h=8  },
      $tech generator$=        {        c=13,x=96,  y=32, w=16, h=32 },
      $ivan boss room$=        {        c=13,x=112, y=44, w=16, h=12 },
      $computer room$=         {        c=13,x=112, y=32, w=16, h=12 }
   ]], function() -- @1
      gen_house(2,17.5,"lank's house", 4, 14.5)
      gen_top(5, 18)
   end, function() -- @2
      gen_house(22,17.5,"lark's house", 23, 6.5)
   end)

   g_doors = gun_vals([[
      $lark's house$=   { d={$village$,          22, 18} },
      $lank's house$=   { d={$lank's path$,       2, 18} },
      $lank's path$=    { r={$village$,          17, 18} },
      $tech entrance$=  { u={$ivan boss room$,  120, 55},
                          l={$tech generator$,  111, 60} },
      $tech generator$= { r={$tech entrance$,   113, 60} },
      $ivan boss room$= { u={$computer room$,   120, 43},
                          d={$tech entrance$,   120, 57} },
      $computer room$=  { d={$ivan boss room$,  120, 45} },

      $village$=        { l={$lank's path$,      15, 18},
                          r={$field$,            33, 28} },
      $field$=          { l={$village$,          31, 28},
                          r={$graveyard path$,   33,  3},
                          d={$maze start$,       36, 33} },
      $graveyard path$= { l={$field$,            63, 23},
                          r={$graveyard$,       113, 29} },
      $graveyard$=      { l={$graveyard path$,   46,  3},
                          r={$canyon path$,      33,  8}, },
      $canyon path$=    { l={$graveyard$,       127, 17},
                          r={$canyon$,           48, 12} },
      $canyon$=         { u={$castle entrance$,  90, 19},
                          l={$canyon path$,      46, 12} },
      $castle entrance$={ d={$canyon$,           59,  1} },
      $maze trap$=      {
                          u={$maze trap$,        48, 43},
                          r={$maze trap$,        41, 38},
                          l={$maze trap$,        55, 38},
                          d={$maze trap$,        48, 33}
                        },
      $maze start$=     {
                          u={$field$,            52, 31},
                          l={$maze 1$,           63, 36}
                        },
      $maze 1$=         {
                          r={$maze start$,       33, 36},
                          d={$maze 2$,           36, 41},
                          u={$maze trap$,        48, 43},
                          l={$maze trap$,        55, 38}
                        },
      $maze 2$=         {
                          u={$maze 1$,           60, 39},
                          d={$maze 3$,           60, 41},
                          r={$maze trap$,        41, 38},
                          l={$maze trap$,        55, 38}
                        },
      $maze 3$=         {
                          u={$maze 2$,           36, 47},
                          r={$maze 4$,           33, 52},
                          l={$maze trap$,        55, 38},
                          d={$maze trap$,        48, 33}
                        },
      $maze 4$=         {
                          l={$maze 3$,           63, 44},
                          r={$maze end$,         57, 52},
                          u={$maze trap$,        48, 43},
                          d={$maze trap$,        48, 33}
                        },
      $maze end$=       {
                          l={$maze 4$,           39, 52},
                          d={$maze boss path$,   60, 57}
                        },
      $maze boss path$= { u={$maze end$,         60, 55},
                          d={$maze boss$,        48, 45} },
      $maze boss$=      { u={$maze boss path$,   52, 63},
                          d={$sword sanctuary$,  36, 57} },
      $sword sanctuary$={ u={$maze boss$,        48, 55} }
   ]], function() -- @1
      gen_house(2,17.5,"lank's house", 4, 7)
      gen_top(5, 18)
   end, function() -- @2
      gen_house(22,17.5,"lark's house", 3, 6)
   end)

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

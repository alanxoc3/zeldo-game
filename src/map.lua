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
   $lank's house$=          {        c=4, x=0,   y=7,  w=8,  h=8,  d={$lank's path$, 2, 3} },
   $lank's path$=           { i=@1,  c=3, x=0,   y=15, w=16, h=6,  r={$village$, 1, 3} },
   $village$=               {        c=3, x=16,  y=15, w=16, h=17, l={$lank's path$,  15, 3}, r={$field$,        1,  14} },
   $field$=                 {        c=3, x=32,  y=14, w=32, h=18, l={$village$,        15, 13}, r={$graveyard path$, 1,  3}, d={$maze start$,     4,  1} },
   $graveyard path$=        {        c=5, x=32,  y=0,  w=15, h=6,  l={$field$,     31, 9}, r={$graveyard$, 1,  29} },
   $graveyard$=             {        c=5, x=112, y=0,  w=16, h=32, l={$graveyard path$,       14, 3}, r={$canyon path$,          1, 2}, d={$graveyard$, 8, 1} },
   $canyon path$=           {        c=5, x=32,  y=6,  w=15, h=8,  l={$graveyard$,       15, 17}, r={$canyon$,           1, 12} },
   $canyon$=                {        c=4, x=47,  y=0,  w=17, h=14, u={$castle entrance$, 6,  19}, l={$canyon path$,      14, 6} },
   $castle entrance$=       {        c=4, x=84,  y=0,  w=12, h=20, d={$canyon$, 12, 1} },
   $maze trap$=             {        c=3, x=40,  y=32, w=16, h=12, u={$maze trap$, 8, 11}, r={$maze trap$, 1, 6}, l={$maze trap$, 15, 6}, d={$maze trap$, 8, 1} },
   $maze start$=            {        c=3, x=32,  y=32, w=8,  h=8,  u={$field$,     20, 17}, l={$maze 1$, 7,  4} },
   $maze 1$=                {        c=3, x=56,  y=32, w=8,  h=8,  r={$maze start$, 1, 4}, d={$maze 2$,     4, 1}, u={$maze trap$, 8, 11}, l={$maze trap$, 15, 6} },
   $maze 2$=                {        c=3, x=32,  y=40, w=8,  h=8,  u={$maze 1$,    4, 7}, d={$maze 3$,    4, 1}, r={$maze trap$, 1, 6}, l={$maze trap$, 15, 6} },
   $maze 3$=                {        c=3, x=56,  y=40, w=8,  h=8,  u={$maze 2$, 4, 7}, r={$maze 4$,    1, 4}, l={$maze trap$, 15, 6}, d={$maze trap$, 8, 1} },
   $maze 4$=                {        c=3, x=32,  y=48, w=8,  h=8,  l={$maze 3$,    7, 4}, r={$maze end$,  1, 4}, u={$maze trap$, 8, 11}, d={$maze trap$, 8, 1} },
   $maze end$=              {        c=3, x=56,  y=48, w=8,  h=8,  l={$maze 4$,          7, 4}, d={$maze boss path$, 12, 1} },
   $maze boss path$=        {        c=3, x=48,  y=56, w=16, h=8,  u={$maze end$,   4, 7}, d={$maze boss$,  8, 1} },
   $maze boss$=             {        c=3, x=40,  y=44, w=16, h=12, u={$maze boss path$, 4, 7}, d={$memory sword sanctuary$, 4, 1} },
   $memory sword sanctuary$={        c=3, x=32,  y=56, w=16, h=8,  u={$maze boss$, 8, 11} }
   ]], function() -- @1
      gen_house(2,17.5,"lank's house")
      gen_top(5, 18)
      printh("testing alan again")
   end)
end

function load_room(new_room, rx, ry)
   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]

   -- take care of actors.
   acts_loop("confined", "kill")
   if cur_room.i then cur_room.i() end

   local x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   g_pl.x = x + rx
   g_pl.y = y + ry
   g_ma = 54 -- todo: something about this menu actor variable.

   load_view(x, y, w, h, 5, 11, 2, 2)
   center_view(g_pl.x, g_pl.y)

   -- get rid of current text.
   tbox_clear()
end

function room_update()
   cur_room = g_rooms[g_cur_room]

   -- "room", out_x, out_y, x, y, rx, ry
   foreach(cur_room.doors or {}, function(d)
      if point_in_rect(g_pl, {x=g_rx+d[4], y=g_ry+d[5], rx=d[6], ry=d[7]}) then
         load_room(d[1], d[2], d[3])
      end
   end)

   -- plus .5 and minus .375 is because there is a screen border.
   if g_pl.y > g_ry+g_rh-.375 and cur_room.d then
      load_room(cur_room.d[1], cur_room.d[2], cur_room.d[3])
   elseif g_pl.y < g_ry + .5 and cur_room.u then
      load_room(cur_room.u[1], cur_room.u[2], cur_room.u[3])
   elseif g_pl.x > g_rx+g_rw-.375 and cur_room.r then
      load_room(cur_room.r[1], cur_room.r[2], cur_room.r[3])
   elseif g_pl.x < g_rx +.5 and cur_room.l then
      load_room(cur_room.l[1], cur_room.l[2], cur_room.l[3])
   end
end

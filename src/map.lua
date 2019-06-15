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
$debug$={      n=$debug$,    c=03, x=00,y=00,w=128,h=64 },
$vilfd$={      n=$hiroll$,   c=03, x=00,y=16,w=64,h=16,l={$for_1$,063,36}},

$villa$={i=@01,n=$hiroll$,   c=03,x=000,y=16,w=32,h=16,l={$for_1$,063,38},r={$field$,033,29}},
$field$={      n=$hiroll$,   c=03,x=032,y=16,w=32,h=16,l={$villa$,031,29},r={$cem_1$,033,02}},

$for_1$={i=@02,n=$forest$,   c=03,x=048,y=32,w=16,h=08,r={$villa$,001,29},l={$for_2$,063,44},u={$for_0$,040,62},d={$for_0$,040,54}},
$for_2$={      n=$forest$,   c=03,x=048,y=40,w=16,h=08,r={$for_1$,049,36},l={$for_0$,046,58},u={$for_0$,040,62},d={$for_3$,060,49}},
$for_3$={      n=$forest$,   c=03,x=048,y=48,w=16,h=08,r={$for_0$,034,58},l={$for_4$,063,60},u={$for_2$,060,47},d={$for_0$,040,54}},
$for_4$={i=@03,n=$forest$,   c=03,x=048,y=56,w=16,h=08,r={$for_3$,049,52},l={$for_0$,046,58},u={$for_5$,040,51},d={$for_0$,040,54}},
$for_5$={      n=$forest$,   c=03,x=032,y=40,w=16,h=12,u={$for_6$,040,39},d={$for_4$,052,57}},
$for_6$={      n=$forest$,   c=03,x=032,y=32,w=16,h=08,d={$for_5$,040,41}},
$for_0$={      n=$forest$,   c=03,x=032,y=52,w=16,h=12 },

$cem_1$={      n=$cemetary$, c=05,x=032,y=00,w=16,h=08,l={$field$,063,29},r={$cem_2$,097,29}},
$cem_2$={i=@04,n=$cemetary$, c=05,x=096,y=00,w=16,h=32,l={$cem_1$,047,06},r={$cem_3$,033,12}},
$cem_3$={      n=$cemetary$, c=05,x=032,y=08,w=16,h=08,l={$cem_2$,111,29},r={$mnt_1$,049,12}},

$mnt_1$={      n=$canyon$,   c=04,x=048,y=00,w=16,h=16,l={$cem_3$,047,12},r={$mnt_2$,085,30}},
$mnt_2$={      n=$canyon$,   c=04,x=084,y=12,w=12,h=20,l={$mnt_1$,063,04},u={$mnt_3$,088,11}},
$mnt_3$={i=@05,n=$canyon$,   c=04,x=080,y=00,w=16,h=12,d={$mnt_2$,090,13}},

$tom_1$={      n=$tomb$,     c=05,x=112,y=24,w=10,h=08,l={$cem_2$,109,03},u={$tom_2$,120,23}},
$tom_2$={      n=$tomb$,     c=05,x=112,y=12,w=16,h=12,d={$tom_1$,120,25},u={$tom_3$,120,11}},
$tom_3$={      n=$tomb$,     c=05,x=112,y=00,w=16,h=12,d={$tom_2$,120,13}},
$tom_0$={      n=$tomb$,     c=05,x=122,y=24,w=06,h=08,r={$cem_2$,099,03}},

$cas_1$={      n=$castle$,   c=13,x=064,y=22,w=10,h=10,d={$mnt_3$,088,02},r={$cas_2$,075,27}},
$cas_2$={      n=$castle$,   c=13,x=074,y=22,w=10,h=10,l={$cas_1$,073,27},u={$cas_3$,079,21}},
$cas_3$={      n=$castle$,   c=13,x=064,y=12,w=20,h=10,d={$cas_2$,079,23},u={$cas_4$,072,11}},
$cas_4$={      n=$castle$,   c=13,x=064,y=00,w=16,h=12,d={$cas_3$,072,13}},

$tec_1$={      n=$tech$,     c=13,x=112,y=56,w=16,h=08,l={$tec_2$,111,60},u={$tec_3$,120,55}},
$tec_2$={      n=$tech$,     c=13,x=096,y=44,w=16,h=20,r={$tec_1$,113,60}},
$tec_3$={      n=$tech$,     c=13,x=112,y=44,w=16,h=12,d={$tec_1$,120,57},u={$tec_4$,120,43}},
$tec_4$={      n=$tech$,     c=13,x=112,y=32,w=16,h=12,d={$tec_3$,120,45}},

$h_gra$={      n=$house$,    c=04,x=000,y=00,w=08,h=08,d={$cem_2$,100,28}},
$h_sho$={      n=$house$,    c=04,x=008,y=00,w=08,h=08,d={$villa$,012,25}},
$h_nav$={      n=$house$,    c=03,x=016,y=00,w=08,h=08,d={$for_4$,056,59}},
$b_lan$={      n=$house$,    c=04,x=024,y=00,w=08,h=08,d={$h_lan$,028,09}},
$b_lar$={      n=$house$,    c=04,x=024,y=00,w=08,h=08,d={$h_lar$,028,09}},

$h_ban$={      n=$house$,    c=04,x=000,y=08,w=08,h=08,d={$villa$,006,23}},
$h_bob$={      n=$house$,    c=04,x=008,y=08,w=08,h=08,d={$villa$,020,25}},
$h_inf$={      n=$house$,    c=04,x=016,y=08,w=08,h=08,d={$villa$,026,23}},
$h_lan$={      n=$house$,    c=04,x=024,y=08,w=08,h=08,d={$villa$,016,19},u={$b_lan$,028,07}},
$h_lar$={      n=$house$,    c=04,x=024,y=08,w=08,h=08,d={$for_1$,060,35},u={$b_lar$,028,07}},

$endless$={    n=$endless$,c=13, x=96,  y=32, w=16, h=12 }
   ]], function() -- village @01
      gen_house(16,18.5,"h_lan", 28, 15)
      gen_house(20,24.5,"h_bob", 12, 15)
      gen_house(12,24.5,"h_sho", 12, 07)
      gen_house(06,22.5,"h_ban", 04, 15)
      gen_house(26,22.5,"h_inf", 20, 15)
      gen_top(7, 26)
   end, function() -- for_1 @02
      gen_house(60,34.5,"h_lar", 28, 15)
   end, function() -- for_4 @03
      gen_house(56,58.5,"h_nav", 20, 07)
   end, function() -- cem_2 @04
      gen_house(100,27.5,"h_gra", 04, 07)
   end, function() -- mnt_3 @05
      gen_house(088,01.5,"cas_1", 69, 31, 102)
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
   cur_door = g_rooms[g_cur_room]

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

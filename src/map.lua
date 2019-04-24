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

   clip(rx*8+1,ry*8+1,rw*8-2,rh*8-2)
   rectfill(0,0,127,127,5)
   clip(rx*8+2,ry*8+2,rw*8-4,rh*8-4)
   rectfill(0,0,127,127,1)
   clip(rx*8+4, ry*8+4, rw*8-8, rh*8-8)

   if g_menu_open then g_pal = g_pal_gray
   else g_pal = g_pal_norm end
   restore_pal()

   rectfill(0,0,127,127,cur_room.c)

	scr_map(cur_room.x, cur_room.y, cur_room.x, cur_room.y, cur_room.w, cur_room.h)

   printh("thing1: "..rw)
   printh("thing2: "..rh)


   -- rectfill(rx+1, ry+1, rx+rw-2, ry+rh-2, 1)
   -- rectfill(1+rx, 13+ry, rw, rh, 1)
   -- rectfill(0, 0, 127, 127, cur_room.c)
   -- rectfill(rx+2, ry+2, rx+rw-3, ry+rh-3, cur_room.c)
   
   -- scr_rectfill(cur_room.x+4/8, cur_room.y+4/8, cur_room.x+cur_room.w-5/8, cur_room.y+cur_room.h-5/8, cur_room.c)
	-- scr_map(88, 24, cur_room.x, cur_room.y, 8, 8)

   isorty(g_act_arrs["spr"])
   acts_loop("spr", "draw")

   if g_menu_open then
   -- fillp(0b1001001101101100.1)
   -- rectfill(0,0,127,127,0x5d)
   -- fillp()
   end

	-- scr_map(cur_room.x, cur_room.y, 0, 0, cur_room.w, cur_room.h, 1)
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
   g_rooms = gun_vals[[
   $lank's path$={
      c=3,
      x=0,
      y=15,
      w=16,
      h=6,
      r={$village$, 1, 4}
   },

   $village$={
      c=3,
      x=16,
      y=15,
      w=16,
      h=17,
      l={$lank's path$,  15, 4},
      r={$field$,        1,  14}
   },

   $field$={
      c=3,
      x=32,
      y=14,
      w=32,
      h=18,
      l={$village$,        15, 13},
      r={$graveyard path$, 1,  3},
      d={$maze start$,     4,  1}
   },

   $graveyard path$={
      c=5,
      x=48,
      y=0,
      w=16,
      h=6,
      l={$field$,     31, 9},
      r={$graveyard$, 1,  18}
   },

   $graveyard$={
      c=5,
      x=112,
      y=11,
      w=16,
      h=21,
      l={$graveyard path$,       15, 3},
      u={$fairy grave entrance$, 8, 11},
      r={$canyon$,               1, 12}
   },

   $fairy grave entrance$={
      c=5,
      x=112,
      y=0,
      w=16,
      h=12,
      d={$graveyard$, 8, 1}
   },

   $canyon$={
      c=4,
      x=32,
      y=0,
      w=16,
      h=14,
      u={$castle entrance$, 6,  19},
      l={$graveyard$,       15, 6}
   },

   $castle entrance$={
      c=4,
      x=84,
      y=0,
      w=12,
      h=20,
      d={$canyon$, 11, 1}
   },

   $maze trap$={
      c=3,
      x=40,
      y=32,
      w=16,
      h=12,
      u={$maze start$, 4, 7}
   },

   $maze start$={
      c=3,
      x=32,
      y=32,
      w=8,
      h=8,
      u={$field$,     20, 17},
      d={$maze trap$, 8,  1},
      l={$maze 1$, 7,  4}
   },

   $maze 1$={
      c=3,
      x=56,
      y=32,
      w=8,
      h=8,
      u={$maze trap$,  8, 6},
      l={$maze trap$,  8, 6},
      r={$maze start$, 1, 4},
      d={$maze 2$,     4, 1}
   },

   $maze 2$={
      c=3,
      x=32,
      y=40,
      w=8,
      h=8,
      u={$maze trap$, 8, 6},
      l={$maze trap$, 8, 6},
      r={$maze trap$, 8, 6},
      d={$maze 3$,    4, 1}
   },

   bossw={c=3, x=80,  y=0,  w=16, h=12, d={$dun73$,4,1},   u={$dun63$,5,8}},
   gravp={c=5, x=29,  y=25, w=19, h=7,  l={$field$,29,18}, r={$grave$,0,18}, u={$templ$,8,12}},
   mount={c=4, x=50,  y=0,  w=12, h=25, d={$field$,12,.5},  u={$castl$,8,12}},
   templ={c=5, x=32,  y=52,  w=16, h=12, d={$gravp$,11,.5}, u={$temple_r1$,2.5,6}, $doors$={
      {$crypt_novi$,2.5,8,3.5,1.5,.5,.5},
      {$crypt_ivan$,2.5,8,12.5,1.5,.5,.5}
   }},
   temple_r1={c=5, x=54,  y=46,  w=5, h=6, d={$templ$,8,.5}, u={$temple_r2$,2.5,6}},
   temple_r2={c=5, x=59,  y=46,  w=5, h=6, d={$temple_r1$,2.5,.5}},

   lankp={c=3, x=32,  y=32, w=10, h=20, r={$villa$,0,20},   $doors$={{$lanks_house$,4,8,5,2.5,.5,.5}}},
   grave={c=5, x=48,  y=25, w=16, h=21, l={$gravp$,19,4}, u={$grave_boss$,8,12}, $doors$={{$gravekeepers_house$,4,8,14,16.5,.5,.5}}},
   castl={c=5, x=64,  y=12, w=16, h=12, d={$mount$,6,.5},   $doors$={{$castle_1$,8,12,8,1.5,.5,.5}}},

   crypt_novi={c=13, x=118, y=24, w=5,  h=8, d={$templ$,3.5,2}, r={$crypt_r1$,0,5.5}},
   crypt_ivan={c=13, x=123, y=24, w=5,  h=8, d={$templ$,12.5,2}, l={$crypt_r1$,16,2.5}},

   crypt_r1={c=13, x=112, y=32, w=16,  h=8, d={$crypt_r2$,11.5,.5}, l={$crypt_novi$,5,5.5}, r={$crypt_ivan$,0,2.5}, u={$crypt_r3$,1.5,16}},
   crypt_r2={c=13, x=112, y=40, w=16,  h=8, u={$crypt_r1$,11.5,8}},
   crypt_r3={c=13, x=104, y=32, w=8,  h=16, d={$crypt_r1$,1.5,.5}, u={$crypt_r4$,4.5,8}},
   crypt_r4={c=13, x=104, y=24, w=14,  h=8, d={$crypt_r3$,4.5,.5}, u={$crypt_boss$,8,12}},
   crypt_boss={c=13, x=112, y=12, w=16,  h=12, d={$crypt_r4$,10,.5}},

   house_1={c=4, x=42, y=46, w=6,  h=6, d={$villa$,17,8}},
   house_2={c=4, x=48, y=46, w=6,  h=6, d={$villa$,6, 19}},
   house_3={c=4, x=42, y=32, w=6,  h=7, d={$villa$,15,14}},

   fandude_house={c=4, x=42, y=39, w=6,  h=7, d={$villa$,5,3}, u={$endless$,8,12}},
   endless={c=3, x=80, y=12, w=16, h=12, d={$fandude_house$,3,.5}},

   lanks_house={c=4, x=64, y=24, w=8,  h=8, d={$lankp$,5,3}},
   shop={c=4, x=72, y=24, w=8,  h=8, d={$villa$,4,12} },
   banjo_academy={c=4, x=80, y=24, w=8,  h=8, d={$villa$,17,20}},
   gravekeepers_house={c=4, x=88, y=24, w=8,  h=8, d={$grave$,14,17}},
   grave_boss={c=5, x=112, y=12, w=16,  h=12, d={$grave$,8,.5}}
   ]]
end

function load_room(new_room, rx, ry)
   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]
   x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   -- for debugging now
   g_pl.x = x + rx
   g_pl.y = y + ry
   -- end debugging
   g_ma = 54

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

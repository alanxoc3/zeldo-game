g_menu_cursor_timer=0
g_ma_timer=0

g_selected=4
g_new_selected=4
g_was_selected=false

-- 0 = banjo
-- 1 = sword
-- 2 = squareforce
-- 3 = lantern
-- 4 = dash
-- 5 = boomerang
-- 6 = bomb
-- 7 = shield
-- 8 = bow

function menu_btn_helper(key_code, expr, add)
   if btnp(key_code) and expr then g_new_selected += add end
end

g_item_descs = {
   "^banjo:play a sick tune!",
   "^sword:hurts bad guys.",
   "^sqr'force:don't let ivan take it from you!",
   "^lantern:lights up dark places.",
   "^dash:a quick dodge move.",
   "^b'rang:stuns enemies and kills really weak ones.",
   "^bomb:only 5 power squares to blows things up!",
   "^shield:be safe from enemy attacks.",
   "^bow:shoots enemies. requires 2 power squares.",
}

function menu_update()
   if not g_menu_open and btn(5) then
      tbox_stash_push()
   end

   if g_menu_open and not btn(5) then
      tbox_stash_pop()
   end

   old_selected = g_menu_open and g_new_selected
   g_menu_open = btn(5)

   if g_menu_open then
      if g_pl.item then g_pl.item.holding = false end

      -- for some reason, negative values don't work here.
      batch_call(menu_btn_helper, "{0,@,0xffff},{1,@,1},{2,@,0xfffd},{3,@,3}", 
         g_new_selected%3 - 1 >= 0,
         g_new_selected%3 + 1 <= 2,
         g_new_selected   - 3 >= 0,
         g_new_selected   + 3 <= 8
      )

      if old_selected != g_new_selected then
         tbox_clear()
         tbox(g_item_descs[g_new_selected+1])
         g_ma = 7+g_new_selected
      end

      g_was_selected=true
      g_menu_cursor_timer += 1

      if g_menu_cursor_timer % 30 == 0 then
         g_menu_pattern  = rotl(g_menu_pattern, 4)
      end
   else
      if g_was_selected then
         g_selected, g_new_selected, g_was_selected = g_new_selected, 4, false
      end
      g_ma = 54
   end

   g_ma_timer += 1
   if g_ma_timer % 15 == 0 then
      g_ma_pat = rotl(g_ma_pat, 4)
   end
end

g_menu_pattern=0x1040.1040 -- 0b1001001101101100.1001001101101100
-- g_menu_pattern=0b1111000011110000.1111000011110000
-- g_menu_pattern = 0b0000010011100100.0000010011100100
-- g_menu_pattern=0x1248.1248
-- todo: make this work if item doesn't exist.
function draw_menu()
   pal()

   -- rectfill(44,40,83,79,0x1001)
   -- rectfill(47,43,80,76,5)

   -- rectfill(48,44,79,75,0xd6)
   -- rectfill(0,0,0,0,0x1001)

   -- rectfill(0,0,127,127,0)
   rectfill(32,32,87,87,5)
   rectfill(33,33,86,86,1)

   -- line(0,0,100,100,0xd)
   -- line(1,0,101,100,0xd)
   local pattern = 0b1001001101101100.1001001101101100
   -- here, i make sure that the fillp will move with the box.
   local ypos = 35 + sin(t()/10)*10
   fillp(flr(rotr(pattern, 4*flr(ypos))))
   -- make a rel_fillp function:
   --  it would allow the fillp to go up and down, based on a y position.
   --  rel_fillp(pattern, y)

   rectfill(35,ypos,84,ypos+49,0xd6)
   -- clip(35,35,50,50)
   -- clip()
   fillp()


   local select_x, select_y = 0, 0
   for i=0,2 do
      for j=0,2 do
         local ind, x, y = (i*3 + j), (40 + j * 16), (40 + i * 16)
         local rel_func2 = function(x1, y1, x2, y2, c)
            rectfill(x+x1,y+y1,x+x2,y+y2,c)
         end

         if ind == g_new_selected then
            batch_call(rel_func2, [[
               {-3,-3,10,10,1},
               {-2,-2,9,9,9},
               {-1,-1,8,8,10}
            ]])
            fillp(flr(g_ma_pat))
            rectfill(x-1,y-1,x+8,y+8,0x9a)
            fillp()
            select_x = x
            select_y = y
         else
            rectfill(x-3,y-3,x+10, y+10,1)
            rectfill(x-2,y-2,x+9,y+9,7)
            -- fillp(flr(g_ma_pat))
   fillp(flr(g_menu_pattern))
            rectfill(x-1,y-1,x+8,y+8,0xd6)
            fillp()

            for i=1,15 do pal(i, g_pal_gray[i]) end
         end

         spr(7+ind, x, y)
         pal()
      end
   end

   local spr_ind = (g_menu_cursor_timer % 60 > 40) and 68 or 69
   local rel_spr = function(x1, y1, ...) spr(spr_ind, select_x+x1, select_y+y1, ...) end
   batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")

end

-- menu enemy
g_ma = 54
g_ma_pat = 0x1284.1284 -- 0b0000010011100100.0000010011100100
g_ma_col = 0xd6
-- g_ma_pat = 0b1000010000100001.1000010000100001
-- g_ma_pat = 0b1100100111000110.1100100111000110
-- g_ma_col = 0x9a
function draw_ma()
   -- rectfill(0, 108, 19, 127, 1)
   rectfill(2, 110, 17, 125, 1)
   rectfill(3, 111, 16, 124, 7)
   fillp(flr(g_ma_pat))
   rectfill(4, 112, 15, 123, g_ma_col)
   -- rectfill(2, 110, 17, 125, g_ma_col)
   fillp()
   spr_out(g_ma, 6, 114, 1, 1, false, false, 1)
   -- rect(2, 110, 17, 125, 1)
end

-- change style
-- change to actor
-- change to sprite

function draw_status_bars()
   -- screen

   -- top bar
   -- rectfill(0, 0, 127, 10, 0)
   spr(g_selected+7, 2, 2)
   rectfill(12,2,12,9,7)

   yoff = 1
   for i=flr(g_pl.max_hearts)-1,0,-1 do
      s = (i < g_pl.hearts) and 240 or 241
      spr(s, 15 + i*4, yoff)
      yoff = (yoff==1) and 3 or 1
   end

   -- bottom rect
   --rectfill(0, 107, 127, 127, 0)

   rectfill(104,2,104,9,7)
   spr(197, 106, 2)
   zprint("9", 127-12-4+2+2, 4)

   draw_ma()
end

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

      if g_menu_cursor_timer % 15 == 0 then
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

g_menu_pattern=0b1001001101101100.1001001101101100
-- g_menu_pattern=0x1248.1248
-- todo: make this work if item doesn't exist.
function draw_menu()
   pal()

   fillp(flr(g_menu_pattern)+0b0.1)
   rectfill(0,0,127,127,0x5d)

   rectfill(44,40,83,79,0x1001)
   rectfill(47,43,80,76,5)

   fillp(0x8421)
   rectfill(48,44,79,75,0xd6)
   rectfill(0,0,0,0,0x1000)

   for i=0,2 do
      for j=0,2 do
         local ind, x, y = (i*3 + j), (42 + j * 18), (38 + i * 18)
         local rel_func2 = function(x1, y1, x2, y2, c)
            rectfill(x+x1,y+y1,x+x2,y+y2,c)
         end

         if ind == g_new_selected then
            batch_call(rel_func2, "{-3,-3,10,10,1}, {-2,-2,9,9,9}, {-2,-2,9,9,9}, {-1,-1,8,8,10}, {-4,-4,-2,-2,1}, {-2,9,-4,11,1}, {11,-4,9,-2,1}, {9,9,11,11,1}")
         else
            batch_call(rel_func2, "{-3,-3,10,10,1}, {-2,-2,9,9,5}, {-2,-2,9,9,5}, {-1,-1,8,8,13}, {-4,-4,-2,-2,1}, {-2,9,-4,11,1}, {11,-4,9,-2,1}, {9,9,11,11,1}")
         end

         if ind == g_new_selected then
            local spr_ind = (g_menu_cursor_timer % 60 > 40) and 68 or 69
            local rel_spr = function(x1, y1, ...) spr(spr_ind, x+x1, y+y1, ...) end
            batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")
         else
            for i=1,15 do pal(i, g_pal_gray[i]) end
         end

         spr(7+ind, x, y)
         pal()
      end
   end
end

-- menu enemy
g_ma = 54
g_ma_pat = 0b0000010011100100.0000010011100100
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
   rectfill(0,0,127, g_v1*8-1,0)
   spr(g_selected+7, 2, 2)
   rectfill(12,2,12,9,7)

   yoff = 1
   for i=flr(g_pl.max_hearts)-1,0,-1 do
      s = (i < g_pl.hearts) and 240 or 241
      spr(s, 15 + i*4, yoff)
      yoff = (yoff==1) and 3 or 1
   end

   rectfill(104,2,104,9,7)
   spr(197, 106, 2)
   zprint("9", 127-12-4+2+2, 4)

   rectfill(0,128-g_v2*8,127,127,0)
   draw_ma()
end

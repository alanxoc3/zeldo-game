g_item_descs = {
   "^banjo:play a sick tune!",
   "^sword:hurts bad guys.",
   "^sqr'force:don't let ivan take it from you!",
   "^lantern:lights up dark places.",
   "^interact:talk to people, pick up things, read signs.",
   "^b'rang:stuns enemies and kills really weak ones.",
   "^bomb:only 5 power squares to blows things up!",
   "^shield:be safe from enemy attacks.",
   "^bow:shoots enemies. requires 2 power squares.",
}

function menu_init()
   g_menu_cursor_timer=0
   g_ma_timer=0

   g_selected=4
   g_new_selected=4

   -- global_items
   g_all_items = gun_vals([[
      banjo    = {sind=08, desc=$^banjo:play a sick tune!$},
      sword    = {sind=09, desc=$^sword:hurts bad guys.$},
      force    = {sind=10, desc=$^sqr'force:don't let ivan take it from you!$},
      shovel   = {sind=11, desc=$^shovel:dig things up. kill the grass.$},
      interact= {sind=43, desc=$^interact:talk to people, pick up things, read signs.$},
      boomrang = {sind=12, desc=$^b'rang:stuns enemies and kills really weak ones.$},
      bomb     = {sind=13, desc=$^bomb:only 5 power squares to blows things up!$},
      shield   = {sind=14, desc=$^shield:be safe from enemy attacks.$},
      bow      = {sind=15, desc=$^bow:shoots enemies. requires 2 power squares.$},
      letter   = {sind=44, desc=$^letter:dinner is ready for a special someone.$},
      soul     = {sind=45, desc=$^soul:the soul of an angry family member.$},
      chicken  = {sind=46, desc=$^chicken:looks delicious.$},
      key      = {sind=47, desc=$^key:i wonder what it opens.$}
   ]])

   g_cur_items = { 
      {x=0,y=0,id="key"},
      {x=1,y=0,id="chicken"},
      {x=2,y=0,id=nil},
      {x=0,y=1,id=nil},
      {x=1,y=1,id="interact"},
      {x=2,y=1,id=nil},
      {x=0,y=2,id=nil},
      {x=1,y=2,id=nil},
      {x=2,y=2,id=nil}
   }
end



function menu_btn_helper(key_code, x, y)
   return btnp(key_code) and g_cur_items[1+x+y*3] and g_cur_items[1+x+y*3].id
end

function menu_update()
   -- tbox logic
   if not g_menu_open and btn(5) then tbox_stash_push() end
   if g_menu_open and not btn(5) then tbox_stash_pop() end

   -- reset if starting menu again.
   -- if not (g_menu_open and g_new_selected) then g_new_selected = 4 end

   g_menu_open  = btn(5)

   if g_menu_open then
      -- todo: do i want this logic here?
      -- if g_pl.item then g_pl.item.holding = false end

      -- below only allows movement on available items and within bounds.
      local x = g_new_selected%3
      local y = flr(g_new_selected/3)

      if menu_btn_helper(0,x-1,y) then x-=1 end
      if menu_btn_helper(1,x+1,y) then x+=1 end
      if menu_btn_helper(2,x,y-1) then y-=1 end
      if menu_btn_helper(3,x,y+1) then y+=1 end

      x, y = max(0,min(x,2)), max(0,min(y,2))
      g_new_selected = y*3+x
      -- printh("x is: "..x.." y is: "..y)
   else
      -- reset next time menu is opened. set item.
      g_selected, g_new_selected = g_new_selected, 4
   end

   g_ma_timer += 1
   if g_ma_timer % 15 == 0 then
      g_ma_pat = rotl(g_ma_pat, 4)
   end

   g_menu_cursor_timer += 1
   if g_menu_cursor_timer % 30 == 0 then
      g_menu_pattern  = rotl(g_menu_pattern, 4)
   end
end

g_menu_pattern=0x1040.1040


function draw_inactive_box(x, y, sind)
   rectfill(x-7,y-7,x+6,y+6,1)
   rectfill(x-6,y-6,x+5,y+5,7)
   fillp(flr(g_menu_pattern))
   rectfill(x-5,y-5,x+4,y+4,0xd6)
   fillp()

   for i=1,15 do pal(i, g_pal_gray[i]) end
   spr(sind, x-4, y-4)
   pal()
end

function draw_active_box(x, y, sind)
   rectfill(x-7,y-7,x+6,y+6,1)
   rectfill(x-6,y-6,x+5,y+5,9)
   rectfill(x-5,y-5,x+4,y+4,10)

   fillp(flr(g_ma_pat))
   rectfill(x-5,y-5,x+4,y+4,0x9a)
   fillp()

   spr(sind, x-4, y-4)
end

-- todo: make this work if item doesn't exist.
function draw_menu(x, y)
   pal()

   local select_x, select_y = 0, 0

   --printh("start")
   for item in all(g_cur_items) do
      local lx, ly = (x - 16 + item.x * 16), (y - 16 + item.y * 16)
      local ind = item.x+item.y*3+1
      if item.id then
         --printh("index is: "..ind.." x: "..item.x.." y: "..item.y)
         if ind-1 == g_new_selected then
            draw_active_box(lx,ly,g_all_items[g_cur_items[ind].id].sind)
            select_x = lx-4
            select_y = ly-4
         else
            draw_inactive_box(lx,ly,g_all_items[g_cur_items[ind].id].sind)
         end
      else
         circfill(lx,ly,1,1)
      end
   end

   local spr_ind = (g_menu_cursor_timer % 60 > 40) and 38 or 39
   local rel_spr = function(x1, y1, ...) spr(spr_ind, select_x+x1, select_y+y1, ...) end
   batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")
end

-- menu enemy
g_ma = 54
g_ma_out = true
g_ma_pat = 0x1284.1284
g_ma_col = 0xd6
function draw_ma()
   -- rectfill(0, 108, 19, 127, 1)
   rectfill(2, 110, 17, 125, 1)
   rectfill(3, 111, 16, 124, 7)
   fillp(flr(g_ma_pat))
   rectfill(4, 112, 15, 123, g_ma_col)
   -- rectfill(2, 110, 17, 125, g_ma_col)
   fillp()
   if g_ma_out then
      spr_out(g_ma, 6, 114, 1, 1, false, false, 1)
   else
      spr(g_ma, 6, 114, 1, 1, false, false, 1)
   end
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
      s = (i < g_pl.hearts) and 41 or 42
      spr(s, 15 + i*4, yoff)
      yoff = (yoff==1) and 3 or 1
   end

   -- bottom rect
   --rectfill(0, 107, 127, 127, 0)

   rectfill(104,2,104,9,7)
   spr(40, 106, 2)
   zprint("9", 127-12-4+2+2, 4)

   -- draw_ma()
end

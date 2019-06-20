function menu_init()
   g_menu_cursor_timer=0
   g_ma_timer=0

   g_selected=1
   g_new_selected=1

   -- global_items
   g_all_items = gun_vals([[
      banjo    = {sind=08, desc=$^banjo:play a sick tune!$},
      sword    = {sind=09, desc=$^sword:hurts bad guys.$},
      force    = {sind=10, desc=$^sqr'force:don't let ivan take it from you!$},
      shovel   = {sind=11, desc=$^shovel:dig things up. kill the grass.$},
      interact = {sind=43, desc=$^interact:talk to people, pick up things, read signs.$},
      boomrang = {sind=12, desc=$^b'rang:stuns enemies and kills really weak ones.$},
      bomb     = {sind=13, desc=$^bomb:only 5 power squares to blows things up!$},
      shield   = {sind=14, desc=$^shield:be safe from enemy attacks.$},
      bow      = {sind=15, desc=$^bow:shoots enemies. requires 2 power squares.$},
      letter   = {sind=44, desc=$^letter:dinner is ready for a special someone.$},
      soul     = {sind=45, desc=$^soul:the soul of an angry family member.$},
      chicken  = {sind=46, desc=$^chicken:looks delicious.$},
      key      = {sind=47, desc=$^key:i wonder what it opens.$}
   ]])

   g_cur_items = {}

   --add(g_cur_items, "interact")
   add(g_cur_items, "interact")
   add(g_cur_items, "key")
   add(g_cur_items, "interact")
   add(g_cur_items, "bow")
   add(g_cur_items, "letter")
   add(g_cur_items, "soul")

   del(g_cur_items, "key")
   del(g_cur_items, "interact")
end

g_item_order  ={5,4,6,2,8,1,3,7,9}
g_item_reverse={6,4,7,2,1,3,8,5,9}
function index_to_coord(ind)
   local order = g_item_order[ind]-1
   return order%3, flr(order/3)
end

function menu_update()
   -- tbox logic
   if not g_menu_open and btn(5) then tbox_stash_push() end
   if g_menu_open and not btn(5) then tbox_stash_pop() end

   -- reset if starting menu again.
   -- if not (g_menu_open and g_new_selected) then g_new_selected = 4 end

   g_menu_open  = btn(5)

   if g_menu_open then
      -- printh("oh ok: "..g_new_selected)
      -- todo: do i want this logic here?
      -- if g_pl.item then g_pl.item.holding = false end

      -- from index to coordinate
      local x, y = index_to_coord(g_new_selected)

      if btnp(0) then x -= 1 end
      if btnp(1) then x += 1 end
      if btnp(2) then y -= 1 end
      if btnp(3) then y += 1 end

      -- only allow movement within bounds.
      x, y = max(0,min(x,2)), max(0,min(y,2))

      -- from coordinate to index
      g_new_selected = g_item_reverse[y*3+x+1]
   else
      -- reset next time menu is opened. set item.
      g_selected, g_new_selected = g_new_selected, 1
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
   rect(x-7,y-7,x+6,y+6,1)
   rect(x-6,y-6,x+5,y+5,13)
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

   printh("start")
   for ind=1,9 do 
      local item = g_cur_items[ind]
      local item_x, item_y = index_to_coord(ind)
      local lx, ly = (x - 16 + item_x * 16), (y - 16 + item_y * 16)

      if ind == g_new_selected then
         select_x = lx-4
         select_y = ly-4
         printh(g_new_selected)
      end

      if item then
         if ind == g_new_selected then
            draw_active_box(lx,ly,g_all_items[item].sind)
         else
            draw_inactive_box(lx,ly,g_all_items[item].sind)
         end
      else
         rectfill(lx-1,ly-1,lx,ly, 1)
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
   spr(g_selected+6, 2, 2)
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

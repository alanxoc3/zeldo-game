function act_poke(a, ix1, ix2)
   if a.poke > 0 then
      a.poke -= 1
      a.ixx = a.xf and ix1 or -ix1
   else
      a.ixx = a.xf and ix2 or -ix2
   end
end

function inventory_init()
   g_selected="interact"
   g_new_selected=1

   g_inventory = {}
   -- add and delete examples
   -- add(g_inventory, "soul")
   -- del(g_inventory, "interact")

   -- global_items
   g_all_items = gun_vals([[
      sword    = {func=@1, sind=09, desc=$^sword:hurts bad guys.$},
      banjo    = {func=@2, sind=08, desc=$^banjo:play a sick tune!$},
      shield   = {func=@3, sind=14, desc=$^shield:be safe from enemy attacks.$},
      brang    = {func=@4, sind=12, desc=$^brang:stun baddies. get items.h$},
      force    = {sind=10, desc=$^sqr'force:don't let ivan take it from you!$},
      shovel   = {sind=11, desc=$^shovel:dig things up. kill the grass.$},
      bomb     = {sind=13, desc=$^bomb:only 5 power squares to blows things up!$},
      bow      = {sind=15, desc=$^bow:shoots enemies. needs 2 power squares.$},
      letter   = {sind=44, desc=$^letter:dinner is ready for a special someone.$},
      soul     = {sind=45, desc=$^soul:the soul of an angry family member.$},
      chicken  = {sind=46, desc=$^chicken:looks delicious.$},
      key      = {sind=47, desc=$^key:i wonder what it opens.$},
      interact = {sind=43, desc=$^interact:talk to people, pick up things, read signs.$},
      nothing  = {sind=43, desc=$^empty:there is no item in this space.$}
   ]], create_sword, create_banjo, create_shield, create_brang)

   add(g_inventory, "interact")
   add(g_inventory, "sword")
   add(g_inventory, "banjo")
   add(g_inventory, "shield")
   add(g_inventory, "brang")
end

g_item_order  ={5,4,6,2,8,1,3,7,9}
g_item_reverse={6,4,7,2,1,3,8,5,9}
function index_to_coord(ind)
   local order = g_item_order[ind]-1
   return order%3, flr(order/3)
end

function inventory_update()
   -- tbox logic
   if not g_menu_open and btn(5) then
      tbox_stash_push()
      tbox(g_all_items[g_inventory[g_new_selected]].desc)
   end

   if g_menu_open and not btn(5) then
      tbox_stash_pop()
      g_selected, g_new_selected = g_inventory[g_new_selected] or "interact", 1
   end

   g_menu_open  = btn(5)

   if g_menu_open then
      if g_pl.item then g_pl.item.holding = false end

      -- from index to coordinate
      local x, y = index_to_coord(g_new_selected)

      if btnp(0) then x -= 1 end
      if btnp(1) then x += 1 end
      if btnp(2) then y -= 1 end
      if btnp(3) then y += 1 end

      -- only allow movement within bounds.
      x, y = max(0,min(x,2)), max(0,min(y,2))

      -- from coordinate to index
      local next_selected = g_item_reverse[y*3+x+1]

      if g_new_selected != next_selected then
         tbox_clear()

         if g_inventory[next_selected] then
            tbox(g_all_items[g_inventory[next_selected]].desc)
         else
            tbox(g_all_items.nothing.desc)
         end
      end

      g_new_selected = next_selected
   end
end

function draw_inactive_box(x, y, sind)
   rect(x-7,y-7,x+6,y+6,1)
   rect(x-6,y-6,x+5,y+5,13)
   fillp(flr(g_pat_2))
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

   fillp(flr(g_pat_1))
   rectfill(x-5,y-5,x+4,y+4,0x9a)
   fillp()

   spr(sind, x-4, y-4)
end

-- todo: make this work if item doesn't exist.
function inventory_draw(x, y)
   pal()

   local select_x, select_y = 0, 0

   -- printh("start")
   for ind=1,9 do 
      local item = g_inventory[ind]
      local item_x, item_y = index_to_coord(ind)
      local lx, ly = (x - 16 + item_x * 16), (y - 16 + item_y * 16)

      if ind == g_new_selected then
         select_x = lx-4
         select_y = ly-4
         -- printh(g_new_selected)
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

   local spr_ind = (g_tim % 60 > 40) and 38 or 39
   local rel_spr = function(x1, y1, ...) spr(spr_ind, select_x+x1, select_y+y1, ...) end
   batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")
end


function create_brang(pl)
   return create_actor([[
      id=$lank_brang$,
      att={
         holding=true,
         rx=.375,
         ry=.375,
         sinds={12,68,69,70},
         anim_len=4,
         anim_spd=10,
         xf=@1,
         touchable=false
      },
      par={$confined$,$anim$,$col$,$mov$},
      tl={
         {d=@7, hit=@2, i=@3, u=@4, t=.25},
         {d=@7, hit=@2, i=@5, u=@6}
      }
      ]],
      pl.xf,
      -- hit
      function(a, other)
         if other.evil then
            if other.knockable then
               other.knockback(other, .05, a.xf and -1 or 1, 0)
            end

            if other.stunnable then
               other.stun(other, 60)
            end

            if a.cur == 1 then
               tl_next(a)
            end
         elseif other.pl then
            if a.cur == 2 then
               a.alive = false
               pl.item = false
            end
         end
      end,
      -- init 1
      function(a)
         a.x, a.y = pl.x, pl.y
         a.ax = a.xf and -.07 or .07
      end,
      -- update 1
      function(a)
         if not a.holding then
            tl_next(a)
         end
      end,
      -- init 2
      function(a)
         -- if pl.item == a then
            -- pl.item = nil
         -- end

      end,
      -- update 2
      function(a)
         amov_to_actor(a, pl, .07)
         -- if not a.holding then
            -- a.alive, pl.item = false
         -- end
      end, scr_spr
      )
end

function create_shield(pl)
   local dist = .625
   return create_actor([[
      id=$lank_shield$,
      att={
         block=true,
         holding=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         poke=20,
         sind=14,
         xf=@1,
         touchable=false
      },
      par={$rel$,$spr$,$col$},
      tl={
         {hit=@2, i=@3, u=@4, t=.4},
         {hit=@2, u=@5}
      }
   ]],
      pl.xf,
      -- hit
      function(a, other)
         if other.evil then
            a.poke=10

            if other.knockable then
               local knockback_val = (a.cur == 1) and .4 or .2
               other.knockback(other, knockback_val, a.xf and -1 or 1, 0)
               pl.knockback(pl, .1, a.xf and 1 or -1, 0)
            end

            if a.cur == 1 and other.stunnable then
               other.stun(other, 60)
            end
         end
      end,
      -- init 1
      function(a) 
         a.rel_dx = a.xf and -dist/10 or dist/10
         a.ixx = a.xf and -3 or 3
         a.poke = 20
      end,
      -- update 1
      function(a)
         act_poke(a,  0, 1)
         if abs(a.rel_dx + a.rel_x) < dist then
            a.rel_x += a.rel_dx
         else
            local neg_one = -dist
            a.rel_dx, a.rel_x = 0, a.xf and neg_one or dist
         end
      end,
      -- update 2
      function(a)
         act_poke(a,  0, 1)
         if not a.holding then
            a.alive, pl.item = false
         end
      end
   )

end

function create_banjo(pl)
   return create_actor([[
      id=$lank_banjo$,
      att={
         holding=true,
         rx=.3,
         ry=.3,
         sind=8,
         xf=@1,
         touchable=false,
      },
      par={$rel$,$spr$,$col$},
      tl={
         {i=@2, u=@3}
      }
      ]],
      pl.xf,
      -- init 1
      function(a) 
         -- a.rel_x=a.xf and 2/8 or -2/8
         a.rel_y=0
      end,
      -- update 1
      function(a)
         if not a.holding then
            a.alive, pl.item = false
         end
      end
   )

end

function create_sword(pl)
   return create_actor([[
      id=$lank_sword$,
      att={
         holding=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=9,
         poke=0,
         xf=@1,
         touchable=false
      },
      par={$rel$,$spr$,$col$},
      tl={
         {hit=@2, i=@3, u=@4, t=.4},
         {hit=@2, u=@5}
      }
      ]],
      pl.xf,
      -- hit
      function(a, other)
         if other.evil then
            a.poke = 10

            if other.knockable then
               other.knockback(other, (a.cur == 1) and .3 or .1, a.xf and -1 or 1, 0)
               pl.knockback(pl, .3, a.xf and 1 or -1, 0)
            end

            if other.stunnable then
               other.stun(other, 30)
            end

            if other.hurtable  then
               other.hurt(other, hurt_val)
            end
         end
      end,
      -- init 1
      function(a)
         a.rel_dx = a.xf and -.125 or .125
         a.ixx = a.xf and -1 or 1
         a.poke = 20
      end,
      -- update 1
      function(a)
         act_poke(a, -1, 0)
         if abs(a.rel_dx + a.rel_x) < 1 then
            a.rel_x += a.rel_dx
         else
            local neg_one = -1
            a.rel_dx, a.rel_x = 0, a.xf and neg_one or 1
         end
      end,
      -- update 2
      function(a)
         act_poke(a, -1, 0)
         if not a.holding then
            a.alive, pl.item = false
         end
      end
      )
end

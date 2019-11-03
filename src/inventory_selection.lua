g_att.item_selector = function()
   return create_actor([[
      id='item_selector',
      att={
         u=@1
      },
      par={'rel'}
      ]], function(a)
         -- from index to coordinate
         local x, y = (g_selected-1)%3, flr((g_selected-1)/3)

         x += xbtnp()
         y += ybtnp()

         -- only allow movement within bounds.
         x, y = max(0,min(x,2)), max(0,min(y,2))

         -- from coordinate to index
         local next_selected = y*3+x+1

         if g_selected != next_selected then
            g_items_drawn[g_selected].selected = false
            g_items_drawn[next_selected].selected = true

            -- tbox_clear()

            -- if get_selected_item(next_selected) then
            -- else
            -- end
         end

         g_selected = next_selected
         a.rel_x = (x - 1) * 1.5
         a.rel_y = (y - 1.25) * 1.5
      end
   )
end

g_att.inventory_item = function(x, y, item)
   return create_actor([[
      id='inventory_item',
      att={
         d=@6, u=@5, rel_x=@1, rel_y=@2, sind=@3, visible=@3, xf=@4
      },
      par={'rel','spr_obj', 'drawable'},
      tl={}
      ]],x,y,item.sind,g_pl.xf, function(a)
         a.outline_color = a.selected and 2 or 1
      end
   )
end

function create_inventory_items()
   if not g_items_drawn then
      sfx'3'
      g_item_selector = g_att.item_selector()
      g_items_drawn = {}
      local inventory_space = 1.125
      for ind=1,9 do
         local item = g_items[ind]
         local item_x, item_y = (ind-1)%3-1, flr((ind-1)/3)-1.375

         if item.enabled then
            g_items_drawn[ind] = g_att.inventory_item(item_x*inventory_space, item_y*inventory_space, item)
         end
      end
   end
end

function destroy_inventory_items()
   foreach(g_items_drawn, function(a) a.alive = false end)
   if g_item_selector then
      sfx'4'
      g_item_selector.alive = false
   end
   g_item_selector = nil
   g_items_drawn = nil
   g_pl.outline_color = 1
end

function inventory_init()
   -- global_items
   g_items = gun_vals([[
      {name='bomb'    , enabled=true, func=@6, sind=5, desc="bomb:only 5 power squares to blows things up!"},
      {name='brang'   , enabled=true, func=@2, sind=4, desc="brang:stun baddies. get items."},
      {name='force'   , enabled=true, func=@8, sind=36, desc="sqr'force:don't let ivan take it from you!"},
      {name='shield'  , enabled=true, func=@4, sind=6, desc="shield:be safe from enemy attacks."},
      {name='interact', enabled=true, func=nf, sind=false, desc="interact:talk to people, pick up things, read signs."},
      {name='bow'     , enabled=true, func=@7, sind=7, desc="bow:shoots enemies. needs 2 power squares."},
      {name='banjo'   , enabled=true, func=@1, sind=1, desc="banjo:play a sick tune!"},
      {name='sword'   , enabled=true, func=@5, sind=2, desc="sword:hurts bad guys."},
      {name='shovel'  , enabled=true, func=@3, sind=3, desc="shovel:dig things up. kill the grass."}
   ]], create_banjo, create_brang, create_shovel, create_shield, create_sword, create_bomb, create_bow, create_force)

   g_selected=G_INTERACT
end

function get_selected_item(ind)
   local item = g_items[ind or g_selected]
   return item.enabled and item or nil
end

function inventory_update()
   -- tbox logic
   local item = get_selected_item()

   if not g_tbox_active and not g_menu_open and btn'5' then
      g_selected = G_INTERACT 
   end
   g_menu_open = not g_tbox_active and btn'5'

   if g_menu_open and not btn'5' then
      if not get_selected_item() then
         g_selected = G_INTERACT
      end
   end


   if g_menu_open then
      create_inventory_items()
      if g_pl.item then g_pl.item.holding = false end
   else
      destroy_inventory_items()
   end
end

function draw_inv_box(x, y, sind, inactive)
   x = x + g_pl.x
   y = y + g_pl.y
   spr_out(sind, scr_x(x), scr_y(y), 1, 1, false, false, 1)
   spr(sind, scr_x(x), scr_y(y))

   -- pal()
end


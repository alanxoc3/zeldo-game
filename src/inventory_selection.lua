g_att.item_selector = function()
   return create_actor([[
      id='item_selector', par={'rel'},
      att={
         u=@1
      }
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
         end

         g_selected = next_selected
         a.rel_x = (x - 1) * 1.5
         a.rel_y = (y - 1.25) * 1.5
      end
   )
end

g_att.inventory_item = function(x, y, item)
   return create_actor([[
      id='inventory_item', par={'rel','spr_obj', 'drawable'},
      att={
         u=@5, rel_x=@1, rel_y=@2, sind=@3, visible=@3, xf=@4
      }
      ]],x,y,item.sind,g_pl.xf and item.flippable, function(a)
         a.outline_color = a.selected and 2 or 1
      end
   )
end

function create_inventory_items()
   if not g_items_drawn then
      sfx'3'
      g_item_selector = g_att.item_selector()
      g_items_drawn = {}
      for ind=1,9 do
         local item = g_items[ind]

         if item.enabled then
            g_items_drawn[ind] = g_att.inventory_item(item.xoff/8, item.yoff/8, item)
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
      {name='force'   , xoff=-7, yoff=-9, enabled=true, func=@8, sind=36, flippable=true},
      {name='brang'   , xoff=0, yoff=-10, enabled=true, func=@2, sind=4},
      {name='bomb'    , xoff=7, yoff=-9, enabled=true, func=@6, sind=5},

      {name='shield'  , xoff=-8, yoff=-3, enabled=true, func=@4, sind=6, flippable=true},
      {name='interact', xoff=0, yoff=-3, enabled=true, func=nf, sind=false},
      {name='bow'     , xoff=8, yoff=-3, enabled=true, func=@7, sind=7},

      {name='banjo'   , xoff=-7, yoff=4, enabled=true, func=@1, sind=1},
      {name='sword'   , xoff=0, yoff=6, enabled=true, func=@5, sind=2, flippable=true},
      {name='shovel'  , xoff=7, yoff=4, enabled=true, func=@3, sind=3}
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

   if g_pl.item and g_pl.item.lank_banjo then
      g_menu_open = false
   end

   if g_menu_open and not btn'5' then
      if not get_selected_item() then
         g_selected = G_INTERACT
      end
   end


   if g_menu_open then
      create_inventory_items()
      if g_pl.item then g_pl.item.being_held = false end
   else
      destroy_inventory_items()
   end
end

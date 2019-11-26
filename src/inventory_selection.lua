G_INTERACT = 5

g_att.item_selector = function()
   return create_actor([[
      id='item_selector', par={'rel'},
      att={
         rel_actor=@1, u=@2
      }
      ]], g_pl, function(a)
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
   local df = function(a)
      scr_rectfill(a.x-.125, a.y-.125, a.x, a.y, a.outline_color)
   end
   if item.enabled then df = scr_spr_and_out end
   return create_actor([[
      id='inventory_item', par={'rel','spr_obj', 'drawable'},
      att={
         rel_actor=@1, u=@6, rel_x=@2, rel_y=@3, sind=@4, visible=@4, xf=@5, draw_both=@7
      }
      ]],g_pl,x,y,item.sind,g_pl.xf and item.flippable, function(a)
         a.outline_color = a.selected and 2 or 1
      end, df
   )
end

function create_inventory_items()
   if not g_items_drawn then
      sfx'3'
      g_item_selector = g_att.item_selector()
      g_items_drawn = {}
      for ind=1,9 do
         local item = g_items[ind]
         item.enabled = zdget(item.mem_loc)
         g_items_drawn[ind] = g_att.inventory_item(item.xoff/8, item.yoff/8, item)
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

function enable_item(index)
   g_items[index].enabled = true
end

function inventory_init()
   -- global_items
   g_items = gun_vals([[
      {mem_loc=HAS_FORCE,     enabled=false, name='force'   , xoff=-7, yoff=-9, func=@8, sind=36, flippable=true},
      {mem_loc=HAS_BOOMERANG, enabled=false, name='brang'   , xoff=0, yoff=-10, func=@2, sind=4},
      {mem_loc=HAS_BOMB,      enabled=true, name='bomb'    , xoff=7, yoff=-9, func=@6, sind=5},

      {mem_loc=HAS_SHIELD,    enabled=false, name='shield'  , xoff=-8, yoff=-3, func=@4, sind=6, flippable=true},
      {mem_loc=ALWAYS_TRUE,   enabled=true, name='interact', interact=true, xoff=0, yoff=-3, func=nf, sind=false},
      {mem_loc=HAS_BOW,       enabled=false, name='bow'     , xoff=8, yoff=-3, func=@7, sind=7},

      {mem_loc=HAS_SHOVEL,    enabled=false, name='shovel'  , xoff=-7, yoff=4, func=@3, sind=3},
      {mem_loc=HAS_SWORD,     enabled=false, name='sword'   , xoff=0, yoff=6, func=@5, sind=2, flippable=true},
      {mem_loc=HAS_BANJO,     enabled=false, name='banjo'   , xoff=7, yoff=4, func=@1, sind=1}
   ]], create_banjo, create_brang, create_shovel, create_shield, create_sword, create_bomb, create_bow, create_force)
   zdset(ALWAYS_TRUE) -- interact should be true
   g_selected=G_INTERACT
end

function get_selected_item(ind)
   local item = g_items[ind or g_selected]
   return item.enabled and item or g_items[5]
end

function inventory_update()
   -- tbox logic
   local item = get_selected_item()

   if not is_game_paused'tbox' and not g_menu_open and btn'5' then
      g_selected = G_INTERACT
   end

   g_menu_open = not is_game_paused'tbox' and btn'5'

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

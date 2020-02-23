-- SECTION: INVENTORY SELECTION
create_actor([['item_selector', 1, {'rel'}]], [[
   rel_actor=@1, u=@2
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

create_actor([['inventory_item', 6, {'rel','spr_obj', 'drawable'}]], [[
   rel_actor=@1, rel_x=@2, rel_y=@3, enabled=@4, flippable=@5, sind=@6, visible=@6,
   i=@7, u=@8
]], function(a)
   a.draw_both = a.enabled and scr_spr_and_out or function(a)
      scr_rectfill(a.x+a.xx/8-.125, a.y+a.yy/8-.125, a.x+a.xx/8, a.y+a.yy/8, a.outline_color)
   end
end, function(a)
   a.outline_color = a.selected and 2 or 1
end
)

-- SECTION: MAP
create_actor([['transitioner', 4, {'act','unpausable'}]], [[
   new_room_index=@1, rx=@2, ry=@3, follow_actor=@4,
   {tl_name='intro',  i=@5, u=@6, tl_max_time=.5, e=@7},
   {tl_name='ending', i=@10, u=@8, tl_max_time=.5, e=@9}
]], -- init
function(a)
   pause'transitioning'
end, function(a)
   g_card_fade = a.intro.tl_tim/a.intro.tl_max_time*10
end, function(a)
   load_room(a.new_room_index, a.rx, a.ry, a.follow_actor)
   tbox_clear()
   g_game_paused = false
end, function(a)
   g_card_fade = (a.ending.tl_max_time-a.ending.tl_tim)/a.ending.tl_max_time*10
end, function()
   unpause()
   g_card_fade = 0
end, function()
   g_game_paused = true
end)

-- SECTION: TITLE
create_actor([['title_move', 0, {'mov'}]], [[
   x=0, y=0, dx=.1, dy=.1, ax=0, ay=0, ix=1, iy=1, ixx=0, iyy=0
]])

-- SECTION: VIEW
create_actor([['view_instance', 4, {'view'}]], [[
   tl_loop=true,
   w=@1, h=@2, follow_dim=@3, follow_act=@4,
   update_view=@5,
   center_view=@6,
   change_ma=@7,
   {},
   {tl_max_time=4},
   {follow_act=false}
]],
function(a)
   batch_call(update_view_helper, [[{@1,'x','w','ixx'},{@1,'y','h','iyy'}]],a)
end, function(a)
   if a.follow_act then
      a.x, a.y = a.follow_act.x, a.follow_act.y
   end
   a:update_view()
end, function(a, ma)
   a.follow_act = ma
   a.tl_next = a.timeoutable and 2 or 1
end)


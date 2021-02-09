function update_view_helper(view, xy, wh, ii)
   local follow_coord = view.follow_act and (view.follow_act[xy]+view.follow_act[ii]/8) or 0
   local view_coord = view[xy]
   local view_dim = view[wh]
   local room_dim = g_cur_room[wh]/2-view_dim/2
   local room_coord = g_cur_room[xy]+g_cur_room[wh]/2
   local follow_dim = round(view.follow_dim*8)/8

   -- Checking the actor we follow.
   if follow_coord < view_coord-follow_dim then view_coord = follow_coord+follow_dim end
   if follow_coord > view_coord+follow_dim then view_coord = follow_coord-follow_dim end

   -- Next, check the room bounds.
   if view_coord < room_coord-room_dim then view_coord = room_coord-room_dim end
   if view_coord > room_coord+room_dim then view_coord = room_coord+room_dim end

   -- Finally, center the view if the room is too small.
   if g_cur_room[wh] <= view[wh] then view_coord = room_coord end

   view[xy] = view_coord
end

-- some utility functions
function scr_pset(x, y, c)
   pset(x*8, y*8, c)
end

function scr_line(x1, y1, x2, y2, col)
   line(x1*8, y1*8, x2*8, y2*8, col)
end

-- DEBUG_BEGIN
function scr_rect(x1, y1, x2, y2, col)
   rect(x1*8, y1*8, x2*8-1, y2*8-1, col)
end
-- DEBUG_END

function scr_rectfill(x1, y1, x2, y2, col)
   rectfill(x1*8, y1*8, x2*8, y2*8, col)
end

function scr_map(cel_x, cel_y, sx, sy, ...)
   map(cel_x, cel_y, sx*8, sy*8, ...)
end

function scr_circfill(x, y, r, col)
   circfill(x*8, y*8, r*8, col)
end

function scr_circ(x, y, r, col)
   circ(x*8, y*8, r*8, col)
end

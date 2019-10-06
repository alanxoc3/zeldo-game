g_view = {}
function center_view(x, y)
   g_view.x, g_view.y = x - 8, y - 8
   update_view(x, y)
end

function update_view_helper(pc, gc, rc, rd)
   -- order matters here.
   -- this helper shaved over 30 tokens.
   if pc < gc + g_view.s1 then gc = pc - g_view.s1 end
   if pc > gc + g_view.s2 then gc = pc - g_view.s2 end
   if gc < rc        then gc = rc end
   if gc+16 > rc+rd  then gc = rc+rd-16 end
   if rd < 16        then gc = rd/2 - 8 + rc end
   return gc
end

-- example usage: update_view
function update_view(p_x, p_y)
   g_view.x, g_view.y = update_view_helper(p_x, g_view.x, g_cur_room.x-g_view.h1, g_cur_room.w+g_view.h1+g_view.h2), update_view_helper(p_y, g_view.y, g_cur_room.y-g_view.v1, g_cur_room.h+g_view.v1+g_view.v2)
end

-- some utility functions
function scr_x(x) return (x+g_view.off_x)*8-flr(g_view.x*8) end
function scr_y(y) return (y+g_view.off_y)*8-flr(g_view.y*8) end

function scr_rect(x1, y1, x2, y2, col)
   rect(scr_x(x1),scr_y(y1),scr_x(x2)-1,scr_y(y2)-1,col)
end

function scr_rectfill(x1, y1, x2, y2, col)
   rectfill(scr_x(x1),scr_y(y1),scr_x(x2),scr_y(y2),col)
end

function scr_print(txt, x, y, col)
   print(txt, scr_x(x),scr_y(y), col)
end

function scr_map(cel_x, cel_y, sx, sy, ...)
   map(cel_x, cel_y, scr_x(sx), scr_y(sy), ...)
end

function scr_clip(x1, y1, x2, y2)
   clip(scr_x(x1), scr_y(y1), (x2-x1)*8, (x2-x1)*8)
end

function scr_circfill(x, y, r, col)
   circfill(scr_x(x),scr_y(y), r*8, col)
end

function scr_circ(x, y, r, col)
   circ(scr_x(x),scr_y(y), r*8, col)
end

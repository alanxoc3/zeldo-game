function zspr(sind, x, y, sw, sh, ...)
   if not sw then sw = 1 end
   if not sh then sh = 1 end
   spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end

function scr_spr(a, spr_func, ...)
   if a and a.visible then
      (spr_func or zspr)(a.sind, scr_x(a.x)+a.ixx+a.xx, scr_y(a.y)+a.iyy+a.yy, a.sw, a.sh, a.xf, a.yf, ...)
   end
end

function scr_spr_out(a) scr_spr(a, spr_out, a.outline_color) end

function scr_spr_and_out(...)
   foreach({...}, scr_spr_out)
   foreach({...}, scr_spr)
end

function zrect(x1, y1, x2, y2)
   batch_call(rect, [[
      {plus{@1,-2}, plus{@2,-2}, plus{@3,2}, plus{@4,2}, 13},
      {plus{@1,-1}, plus{@2,-1}, plus{@3,1}, plus{@4,1}, 1}
   ]], x1, y1, x2, y2)

   batch_call(sspr, [[
      {0,0,4,4,plus{@1,-3},plus{@2,-3}},
      {0,4,4,4,plus{@1,-3},@4},
      {4,0,4,4,@3,plus{@2,-3}},
      {4,4,4,4,@3,@4}
   ]], x1, y1, x2, y2)
end

function outline_helper(flip, coord, dim)
   coord = coord-dim*4
   if flip then
      return dim*8-1+coord, 0xffff
   else
      return coord, 1
   end
end

function spr_out(sind, x, y, sw, sh, xf, yf, col)
   sw,sh=sw or 1,sh or 1
   local ox, x_mult = outline_helper(xf, x, sw)
   local oy, y_mult = outline_helper(yf, y, sh)

   foreach(g_out_cache[''..sind], function(r)
      rectfill(
         ox+x_mult*r[1],
         oy+y_mult*r[2],
         ox+x_mult*r[3],
         oy+y_mult*r[4],
      col)
   end)
end

function tprint(str, x, y, c1, c2)
   for i=-1,1 do
      for j=-1,1 do
         zprint(str, x+i, y+j, 0, BG_UI, BG_UI)
      end
   end
   zprint(str, x, y, 0, c1, c2)
end

function zprint(str, x, y, align, fg, bg)
   if align == 0    then x -= #str*2
   elseif align > 0 then x -= #str*4+1 end

   batch_call(print, [[
      {@1, @2, plus{@3,1}, @5},
      {@1, @2, @3,         @4}
   ]], str, x, y, fg, bg)
end

function zclip(x1, y1, x2, y2)
   clip(x1, y1, x2+1-flr(x1), y2+1-flr(y1))
end

function zcls(col)
   batch_call(rectfill, [[{0x8000, 0x8000, 0x7fff, 0x7fff, @1}]], col or 0)
end

-- fading
g_fadetable=gun_vals([[
 {0,0,0,0,0,0,0},
 {1,1,1,0,0,0,0},
 {2,2,2,1,0,0,0},
 {3,3,3,1,0,0,0},
 {4,2,2,2,1,0,0},
 {5,5,1,1,1,0,0},
 {6,13,13,5,5,1,0},
 {7,6,13,13,5,1,0},
 {8,8,2,2,2,0,0},
 {9,4,4,4,5,0,0},
 {10,9,4,4,5,5,0},
 {11,3,3,3,3,0,0},
 {12,12,3,1,1,1,0},
 {13,5,5,1,1,1,0},
 {14,13,4,2,2,1,0},
 {15,13,13,5,5,1,0}
]])

function fade(i)
   for c=0,15 do
      pal(c,g_fadetable[c+1][min(flr(i+1), 7)])
   end
end

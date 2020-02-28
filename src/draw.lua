function zspr(sind, x, y, sw, sh, ...)
   if not sw then sw = 1 end
   if not sh then sh = 1 end
   spr(sind, x-sw*4, y-sh*4, sw, sh, ...)
end

function scr_spr(a, spr_func, ...)
   if a.visible then
      local dir = flr(a.sind/256)
      local sind = a.sind % 256
      local xf, yf = a.xf, a.yf

      if dir != 0 then
         xf = dir == 2 or dir == 3
         yf = dir == 1 or dir == 2
      end

      (spr_func or zspr)(sind, scr_x(a.x)+a.ixx+a.xx, scr_y(a.y)+a.iyy+a.yy, a.sw, a.sh, xf, yf, ...)
   end
end

function scr_spr_out(a) scr_spr(a, spr_out, a.outline_color) end

function scr_spr_and_out(...)
   scr_spr_out(...)
   scr_spr(...)
end

function spr_and_out(...)
   spr_out(...)
   zspr(...)
end

function zrect(x1, y1, x2, y2, color_gun)
   local list = gun_vals(color_gun)
   for k=#list,1,-1 do
      local v = list[k]
      local xx1, yy1, xx2, yy2 = x1+k-1, y1+k-1, x2-k+1, y2-k+1
      rect(xx1, yy1, xx2, yy2, v)

      pset(xx1+1, yy1+1, v) pset(xx2-1, yy1+1, v)
      pset(xx1+1, yy2-1, v) pset(xx2-1, yy2-1, v)
   end
   pset(x1, y1, 0)
   pset(x2, y1, 0)
   pset(x2, y2, 0)
   pset(x1, y2, 0)
end

g_out_cache = {}
function create_outline(sind, sw, sh)
   sw*=8 sh*=8 sh-=1

   local bounds, is_bkgd = {}, function(x, y)
      return mid(0,x,sw-1) == x and sget(x+sind*8%128, y+flr(sind/16)*8) != 0
   end

   local calc_bound = function(x)
      local top, bot

      for i=0,sh do
         top, bot = top or is_bkgd(x,i) and i-1, bot or is_bkgd(x,sh-i) and sh+1-i
      end

      return gun_vals([[top=@1, bot=@2]], top or sh+1, bot or 0)
   end

   g_out_cache[sind] = {}
   for i=0xffff,sw do
      -- prev, cur, next
      local p, c, n = calc_bound(i-1), calc_bound(i), calc_bound(i+1)
      local top, bot = min(min(p.top, c.top), n.top), max(max(p.bot, c.bot), n.bot)

      if bot >= top then
         add(g_out_cache[sind], {x1=i,y1=top,x2=i,y2=bot})
      end
   end
end

function spr_out(sind, x, y, sw, sh, xf, yf, col)
   sw=sw or 1 sh=sh or 1
   x-=sw*4 y-=sh*4

   local ox, x_mult, oy, y_mult = x, 1, y, 1
   if xf then ox, x_mult = sw*8-1+x, 0xffff end
   if yf then oy, y_mult = sh*8-1+y, 0xffff end

   if not g_out_cache[sind] then
      create_outline(sind, sw, sh)
   end

   foreach(g_out_cache[sind], function(r)
      rectfill(
         ox+x_mult*r.x1,
         oy+y_mult*r.y1,
         ox+x_mult*r.x2,
         oy+y_mult*r.y2,
      col)
   end)
end

function align_text(str, x, right)
   return x - (right and (#str*4+1) or 0)
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
      {@1, @2, @4, @6},
      {@1, @2, @3, @5}
   ]], str, x, y, y+1, fg, bg)
end

function zclip(x1, y1, x2, y2)
   clip(x1, y1, x2+1-flr(x1), y2+1-flr(y1))
end

function zcls(col)
   batch_call(rectfill, [[{0x8000, 0x8000, 0x7fff, 0x7fff, @1}]], col or 0)
end

-- fading
fadetable=gun_vals([[
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
      if flr(i+1)>=8 then
         pal(c,0)
      else
         pal(c,fadetable[c+1][flr(i+1)])
      end
   end
end

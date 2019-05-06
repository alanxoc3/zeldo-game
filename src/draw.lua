function restore_pal()
   for i=1,15 do pal(i,g_pal[i]) end
end

function scr_spr(a, spr_func)
   (spr_func or spr)(a.sind, scr_x(a.x-a.sw*.5)+a.ixx+a.xx, scr_y(a.y-a.sh*.5)+a.iyy+a.yy, a.sw, a.sh, a.xf, a.yf, 1)
end

function scr_spr_out(a) scr_spr(a, spr_out) end

g_out_cache = {}
function create_outline(sind)
   local bounds, is_bkgd = {}, function(x, y)
      return mid(0,x,7) == x and sget(x+sind*8%128, y+flr(sind/16)*8) != 0
   end

   local calc_bound = function(x)
      local top, bot

      for i=0,7 do
         top, bot = top or is_bkgd(x,i) and i-1, bot or is_bkgd(x,7-i) and 8-i
      end

      return {top=top or 10, bot=bot or 0}
   end

   g_out_cache[sind] = {}
   for i=0xffff,8 do
      -- prev, cur, next
      local p, c, n = calc_bound(i-1), calc_bound(i), calc_bound(i+1)
      local top, bot = min(min(p.top, c.top), n.top), max(max(p.bot, c.bot), n.bot)

      if bot >= top then
         add(g_out_cache[sind], {x1=i,y1=top,x2=i,y2=bot})
      end
   end
end

function spr_out(sind, x, y, sw, sh, xf, yf, col)
   if not g_out_cache[sind] then
      create_outline(sind)
   end

   local ox, x_mult, oy, y_mult = x, 1, y, 1
   if xf then ox, x_mult = 7+x, 0xffff end
   if yf then oy, y_mult = 7+y, 0xffff end

   foreach(g_out_cache[sind], function(r)
      rectfill(
         ox+x_mult*r.x1,
         oy+y_mult*r.y1,
         ox+x_mult*r.x2,
         oy+y_mult*r.y2,
         col)
   end)

   spr(sind, x, y, sw, sh, xf, yf)
end

function zprint(str, x, y)
   print(str, x, y-1, 1)
   print(str, x, y, 7)
end

-- .2604 (bad outline)
-- .2537 (working on outline, should get to be smaller).
-- .2388 (no outline)
--

function restore_pal()
   for i=1,15 do pal(i,g_pal[i]) end
end

function scr_spr(a, spr_func)
   (spr_func or spr)(a.sind, scr_x(a.x-a.sw*.5)+a.ixx+a.xx, scr_y(a.y-a.sh*.5)+a.iyy+a.yy, a.sw, a.sh, a.xf, a.yf, 1)
end

function scr_spr_out(a) scr_spr(a, spr_out) end

g_out_cache = {}
function create_outline(sind, sw, sh)
   local sh_end = sh*8-1
   local bounds, is_bkgd = {}, function(x, y)
      return mid(0,x,sh_end) == x and sget(x+sind*8%128, y+flr(sind/16)*8) != 0
   end

   local calc_bound = function(x)
      local top, bot

      for i=0,sh_end do
         top, bot = top or is_bkgd(x,i) and i-1, bot or is_bkgd(x,sh_end-i) and sh*8-i
      end

      return {top=top or sh*8+2, bot=bot or 0}
   end

   g_out_cache[sind] = {}
   for i=0xffff,sw*8 do
      -- prev, cur, next
      local p, c, n = calc_bound(i-1), calc_bound(i), calc_bound(i+1)
      local top, bot = min(min(p.top, c.top), n.top), max(max(p.bot, c.bot), n.bot)

      if bot >= top then
         add(g_out_cache[sind], {x1=i,y1=top,x2=i,y2=bot})
      end
   end
end

function spr_out(sind, x, y, sw, sh, xf, yf, col)
   if not sw then sw = 1 end
   if not sh then sh = 1 end

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

   -- spr(sind, x, y, sw, sh, xf, yf)
end

function align_text(str, x, right)
   return x - (right and (#str*4+1) or 0)
end

function zprint(str, x, y, shadow_below)
   print(str, x, y + (shadow_below and 1 or -1), 1)
   print(str, x, y, 7)
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
 {6,6,13,13,5,1,0},
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

function tostring(any)
  if type(any)~="table" then return tostr(any) end
  local str = "{"
  for k,v in pairs(any) do
    if str~="{" then str=str.."," end
    str=str..tostring(k).."="..tostring(v)
  end
  return str.."}"
end

function printarr(arr)
   for i=1,#arr do
      printh(" "..tostring(arr[i])..((i == #arr) and "" or ","))
   end
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

      return {
         top=top or sh+1,
         bot=bot or 0
      }
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

-- manually putting in all the indexes.

for i=0,255 do
  if fget(i,5) then
    create_outline(i, 1, 1)
  elseif fget(i,4) then
    create_outline(i, 1, 2)
  elseif fget(i,3) then
    create_outline(i, 2, 2)
  end
end

printh("g_out_cache=gun_vals[[")
for k,v in pairs(g_out_cache) do
   printh(""..k.."={")
   printarr(v)
   printh("},")
end
printh("]]")

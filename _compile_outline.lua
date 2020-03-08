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
for i=1,7 do create_outline(i, 1, 1) end
for i=19,21 do create_outline(i, 1, 1) end
for i=32,34 do create_outline(i, 1, 1) end
create_outline(36, 1, 1)
create_outline(43, 1, 1)
create_outline(45, 1, 1)
create_outline(46, 2, 2)
for i=48,51   do create_outline(i, 1, 1) end
for i=64,71   do create_outline(i, 1, 1) end
for i=80,87   do create_outline(i, 1, 1) end
for i=96,103  do create_outline(i, 1, 1) end
for i=112,119 do create_outline(i, 1, 1) end
for i=128,135 do create_outline(i, 1, 1) end
for i=144,151 do create_outline(i, 1, 1) end

-- title
for i=224,228 do create_outline(i, 1, 2) end

printh("g_out_cache=gun_vals[[")
for k,v in pairs(g_out_cache) do
   printh(""..k.."={")
   printarr(v)
   printh("},")
end
printh("]]")

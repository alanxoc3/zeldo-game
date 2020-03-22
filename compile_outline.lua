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

function does_a_contain_b(a, b)
   return b.x1 >= a.x1 and b.x2 <= a.x2 and b.y1 >= a.y1 and b.y2 <= a.y2
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

   local outline = {}

   -- Phase 1. Generate verticals.
   for i=0xffff,sw do
      -- prev, cur, next
      local p, c, n = calc_bound(i-1), calc_bound(i), calc_bound(i+1)
      local top, bot = min(min(p.top, c.top), n.top), max(max(p.bot, c.bot), n.bot)

      if bot >= top then
         add(outline, {x1=i,y1=top,x2=i,y2=bot})
      end
   end

   -- Phase 2. Expand horizontally.
   for i=1,#outline do
      local head = outline[i]
      local new_x2

      for j=i,#outline do
         local tail = outline[j]
         if head.y1 >= tail.y1 and head.y2 <= tail.y2 then
            new_x2 = tail.x1
         else
            break
         end
      end

      head.x2 = new_x2
   end

   -- Phase 3. Remove contained rects.
   for i=#outline,1,-1 do
      local tail = outline[i]

      for j=i-1,1,-1 do
         local body = outline[j]
         if does_a_contain_b(body, tail) then
            del(outline, tail)
            break
         end
      end
   end

   g_out_cache[sind] = outline
end

-- manually putting in all the indexes.

for i=0,255 do
  if fget(i,5) and fget(i,4) then
    create_outline(i, 2, 2)
  elseif fget(i,5) then
    create_outline(i, 1, 1)
  elseif fget(i,4) then
    create_outline(i, 1, 2)
  end
end

printh("g_out_cache=gun_vals[[")
for k,v in pairs(g_out_cache) do
   printh(""..k.."={")
   printarr(v)
   printh("},")
end
printh("]]")

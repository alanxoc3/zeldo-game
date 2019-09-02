-- todo: convert this to table, with names? maybe.
g_patterns = gun_vals([[
   {pat=0x1040.1040, rot=4,  tim=15},
   {pat=0x1284.1284, rot=4,  tim=30},
   {pat=0x1248.1248, rot=12, tim=10},
   {pat=0x70e0.b0d0, rot=12, tim=1}
]])

g_tim=0
function patterns_update()
   g_tim += 1
   for i=1,#g_patterns do
      local pattern = g_patterns[i]
      if g_tim % pattern.tim == 0 then pattern.pat = rotl(pattern.pat, pattern.rot) end
   end
end

function patternize(col, pat)
   pat = g_patterns[pat].pat
   return 0x1000 + col + pat - flr(pat)
end

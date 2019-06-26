g_pat_2 = 0x1040.1040
g_pat_1 = 0x1284.1284
g_pat_3 = 0x1248.1248
g_tim=-2000
g_tim=0

function patterns_update()
   g_tim += 1
   if g_tim % 15 == 0 then g_pat_1 = rotl(g_pat_1, 4) end
   if g_tim % 30 == 0 then g_pat_2 = rotl(g_pat_2, 4) end
   if g_tim % 10 == 0 then g_pat_3 = rotl(g_pat_3, 12) end
end

-- amorg logo
-- 128 103 97 69 81 49 88 104 136 108 95 92 103

function draw_logo(logo, x, y)
   local lc1 = -sin(g_lct/2)*140
   local lc2 = lc1*4/7
   clip(x-lc1/2, y-lc2/2, lc1, lc2)

   if logo.tl_curr != 3 then
      camera(rnd(2)-1, rnd(2)-1)
   end

   spr(227, x-16, y-8, 4, 2)
   spr_out(54, 79, 64, 1, 1, false, false, 1)
   clip()
   camera()
end

-- the sound is assumed to be sfx 0!
g_logo = tl_init([[
      { d=@4, i=@1, tl_tim=.5 },
      { d=@4, i=@1, u=@2, tl_tim=.5 },
      { d=@4, tl_tim=1 },
      { d=@4, i=@3, u=@2, tl_tim=.5 },
      { d=@4, tl_tim=.5 }
   ]],
   -- 1
   function()
      g_lt = t()
      g_lct = 0
   end,
   -- 2 update logo
   function()
      g_lct = t()-g_lt
   end,
   -- 3
   function() g_lt += 1 end,
   -- 4
   draw_logo
)

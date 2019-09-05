-- amorg logo
-- 128 103 97 69 81 49 88 104 136 108 95 92 103

g_lct = 0
g_logo_shake = false
function draw_logo(logo, x, y)
   fade(8-g_lct)

   if g_logo_shake then
      camera(rnd(2)-1, rnd(2)-1)
   end

   spr(192, x-16, y-8, 4, 2)
   spr_out(56, x+15, y, 1, 1, false, false, 1)

   camera()
end

-- the sound is assumed to be sfx 0!
g_logo = tl_init([[
      { d=@2, tl_tim=.5 },
      { u=@1, d=@2, tl_tim=.5 },
      { u=@4, d=@2, tl_tim=.5 },
      { u=@3, d=@2}
   ]],
   -- 1 update logo
   function() g_logo_shake = true g_lct = min(8, g_lct+8/30) end,
   -- 2
   draw_logo,
   -- 3
   function() g_logo_shake = true g_lct = max(0, g_lct-8/30) end,
   -- 4
   function() g_logo_shake = false end
)
sfx(9)

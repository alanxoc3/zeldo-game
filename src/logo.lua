-- amorg logo
-- 128 103 97 69 81 49 88 104 136 108 95 92 103

g_logo_tim = 0
g_logo_shake = false
function draw_logo(logo)
   local x, y = 64, 64
   fade(8-g_logo_tim)

   if g_logo_shake then
      camera(rnd(2)-1, rnd(2)-1)
   end

   spr(192, x-16, y-8, 4, 2)

   fade(0)
   camera()
end

-- the sound is assumed to be sfx 0!
g_logo = gun_vals_new([[
      { d=@2, tl_tim=.5 },
      { u=@1, d=@2, tl_tim=.5 },
      { u=@4, d=@2, tl_tim=.5 },
      { u=@3, d=@2, tl_tim=1 }
   ]],
   -- 1 update logo
   function() g_logo_shake = true g_logo_tim = min(8, g_logo_tim+8/30) end,
   -- 2
   draw_logo,
   -- 3
   function() g_logo_shake = true g_logo_tim = max(0, g_logo_tim-8/30) end,
   -- 4
   function() g_logo_shake = false end
)

music(0,0,3)

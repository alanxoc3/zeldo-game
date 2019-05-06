-- amorg logo
-- 128 103 97 69 81 49 88 104 136 108 95 92 103

-- the sound is assumed to be sfx 0!
function init_logo()
   g_lct = 0
   local update_logo_time = function()
      g_lct = t()-g_lt
   end

	g_logo = tl_init([[
         { t=.5 },
         { i=@, u=@, t=.5 },
         { t=1 },
         { i=@, u=@, t=.5 },
         { t=.5 }
      ]], function()
         g_lt = t()
         g_lct = 0
      end,
      update_logo_time,
      function() g_lt += 1 end, 
      update_logo_time
   )
end

function draw_logo(x, y)
   local lc1 = -sin(g_lct/2)*140
   local lc2 = lc1*4/7
   clip(x-lc1/2, y-lc2/2, lc1, lc2)

   if g_logo.current != 3 then
      camera(rnd(2)-1, rnd(2)-1)
   end

   spr(227, x-16, y-8, 4, 2)
   spr_out(54, 79, 64, 1, 1, false, false, 1)
   clip()
   camera()
end

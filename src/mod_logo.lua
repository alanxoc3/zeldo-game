-- amorg logo
-- 128 103 97 69 81 49 88 104 136 108 95 92

-- the sound is assumed to be sfx 0!
function init_logo()
   local update_logo_time = function()
      g_lct = t()-g_lt
   end

	g_logo = tl_init([[
         { i=@, u=@, t=.5 },
         { t=1 },
         { i=@, u=@, t=.5 },
         { t=1 }
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
   local lc = -sin(g_lct/2)*35
   clip(x-lc/2, 0, lc, 127)

   if g_logo.current != 2 then
      camera(rnd(2)-1, rnd(2)-1)
   end
      spr(227, x-16, y-4, 4, 2)

   clip()
   camera()
end

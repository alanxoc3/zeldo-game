function draw_logo(logo)
   local x, y = 64, 64
   camera(-x, -y)

   -- (str, x, y, alignment, shadow_below)
   batch_call(zprint2, [[
      {@1, 0, -14, 10, 0, false}
   ]], "THE STORY OF"
   )

   if t() % 1 < .5 then
      batch_call(zprint2, [[
         {@1, 0, 9, 7, 0, true}
      ]], "PRESS Z TO START"
      )
   end

   spr(224, -28, -8, 7, 2)
   camera()
end

-- the sound is assumed to be sfx 0!
g_title = tl_init([[
      { d=@1 }
   ]], draw_logo
)
music(0,0,3)

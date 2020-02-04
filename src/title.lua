mx=8 my=8
function draw_logo(logo)
   fade(g_card_fade)

   g_card_shake_x = 0
   g_card_shake_y = 0
   local x, y = 8, 8
   if t() % 3 == .5 then
      mx = rnd(8)+4
      my = rnd(8)+4
   end

   map_draw(mx+g_card_shake_x, my+g_card_shake_y, {5,1,1})

   fade(0)
   camera(-x*8, -y*8)
   -- (str, x, y, alignment, shadow_below)
   batch_call(zprint2, [[
      {@1, 0, -14, 10, 0, false}
   ]], "THE STORY OF"
   )

   if t() % 1 < .5 then
      batch_call(zprint2, [[
         {@1, -1, 9, 7, 0, true}
      ]], "PRESS 🅾️ TO START"
      )
   end

   zspr(224, 0, 0, 7, 2)
   camera()
end

-- the sound is assumed to be sfx 0!
g_title = gun_vals([[
      { i=@3, u=@2, d=@1 }
   ]], draw_logo, function()
      room_update()

      if t() % 3 == 0 then
         g_title_trans = g_att.transitioner(flr_rnd(20)+1, 0, 0)
      end
      if g_title_trans then
         g_title_trans:update()
      end


      return btnp(4)
   end, function()
      load_room(SHOP, 3, 4)
   end
)

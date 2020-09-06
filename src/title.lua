function spr_and_out(...)
   spr_out(...)
   zspr(...)
end

function draw_logo(a)
   camera(-a.x*8, -a.y*8)
   -- (str, x, y, alignment, shadow_below)
   batch_call(tprint, [[
      {"that story about", 0, -17, 10, 4}
   ]]
   )
   for i=-2,2 do
      spr_and_out(226+i, i*10, sgn(cos(t()/2+i/4))/2+1, 1, 2, false, false, 1)
   end

   if ti(1,.5) then
      batch_call(tprint, [[
         {"🅾️ or ❎ to play  ", 0, 12, 7, 5}
      ]])
   end

   camera()
end

-- fade in. fade loop. fade out

-- the sound is assumed to be sfx 0!
g_title = gun_vals([[
   { x=8, y=8, i=@8, d=@5, u=@6 }, {
      tl_name='outer', tl_loop=true,
      { i=nf, e=@3, u=@2, d=@1, tl_max_time=5 }
   }, { i=@4, u=@6, e=nf },
   { i=@7, d=@9 }
]], function(a)
      fade(g_card_fade)
      map_draw(a.x, a.y, [[0,0,13,1]])
      fade'0'
      draw_logo(a)
   end, function(a)
      batch_call(acts_loop, [[
         {'act', 'update'},
         {'mov','move'},
         {'vec','vec_update'},
         {'act', 'clean'},
         {'view','update_view'}
      ]])

      if btnp'4' or btnp'5' then
         a.outer.tl_loop = false
         return true
      end
   end, function(a)
      transition(flr_rnd'20'+1, 0, 0, _g.title_move())
   end, function(a)
      batch_call(acts_loop, [[
         {'fader_in', 'delete'},
         {'fader_out', 'delete'}
      ]])

      _g.fader_out(
         function() pause'transitioning' end,
         function() a.tl_next = true end)
   end, function(a)
      fade(g_card_fade)
      map_draw(a.x, a.y, [[0,0,13,1]])
      draw_logo(a)
      fade'0'
   end, function(a)
      -- TODO: this is kind of like the basics for updating things.... I can probably
      -- extract it out...
      batch_call(acts_loop, [[
         {'act', 'update'},
         {'mov','move'},
         {'vec','vec_update'},
         {'act', 'clean'},
         {'view','update_view'}
      ]])
   end, function(a)
      g_card_fade = 0
      _g.fader_out(
         nf, function() a.tl_next = true end
      )
   end, function(a)
      g_card_fade=8
      -- TODO: duplicate logic here
      load_room(flr_rnd'20'+1, 0, 0, _g.title_move())
      _g.fader_in(
         function()
            pause'transitioning'
         end, function()
            a.tl_next = true
            unpause()
         end
      )
   end, function(a)
      fade(g_card_fade)
      draw_logo(a)
      fade'0'
   end
)

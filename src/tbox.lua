-- tbox

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len = {}, 0, 25
-- listen to 'g_tbox_active', to listen if tbox is active.

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact()
   if g_tbox_active then
      g_tbox_anim += .5

      g_tbox_writing = g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2
      if not g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      end

      if g_tbox_writing then
         sfx'0'
      end

      if btnp'4' and g_tbox_anim > .5 then
         sfx'2'
         if g_tbox_writing then
            g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
         else
            del(g_tbox_messages, g_tbox_active)
            g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
         end
      end
      if g_tbox_active then
         pause'tbox'
      else
         unpause()
         g_tbox_messages.trigger()
      end
   end
end

-- Example tbox:
-- tbox([[
--    "line 1 is cool",
--    "line 2 is better though",
--    "line 3 anyone?",
--    trigger=@1
-- ]], function reboot() end)
function tbox_with_obj(a)
   g_tbox_messages.trigger = a.trigger or nf
   for i=1,#a do
      if i % 2 == 1 then
         add(g_tbox_messages, {l1=a[i], l2=''})
      else
         g_tbox_messages[#g_tbox_messages].l2=a[i]
      end
   end

   g_tbox_active = g_tbox_messages[1]
end

function tbox(...)
   tbox_with_obj(gun_vals(...))
end

-- draw the text boxes (if any)
-- foreground color, background color, border width
function ttbox_draw(x, y)
   if is_game_paused'tbox' then -- only draw if there are messages
      camera(-x,-y)
      batch_call(rectfill, [[
         {0, 0, 106, 19, 5},
         {1, 1, 105, 18, 6},
         {2, 2, 104, 17, 0}
      ]])

      -- print the message
      batch_call(zprint, [[
         {@1, 4, 4, false},
         {@2, 4, 11, true}
      ]],
         sub(g_tbox_active.l1, 1, g_tbox_anim),
         sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0))
      )

      -- draw the arrow
      if not g_tbox_writing then
         spr(38, 100, ti(40)<20 and 13 or 14)
      end
      camera()
   end
end

function tbox_clear()
   g_tbox_messages, g_tbox_anim, g_tbox_active = {}, 0, false
end

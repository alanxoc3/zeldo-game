-- tbox

-- tbox api

-- "|" speaker, must go first!
-- "@" id,      must go in between!
-- ":" line,    must go last!

-- example usage:
-- tbox("speaker:line:line@id:line|newspeaker:line...")

-- vars:
g_tbox_messages, g_tbox_anim, g_tbox_max_len = {}, 0, 25
-- listen to 'g_tbox_active', to listen if tbox is active.

function str_to_word_lines(str, line_len)
   -- word, line, loop_string, lines
   local l, w, l_str, lines = "", "", str.." ", {}
   for i=1, #l_str do
      local c = sub(l_str, i, i)

      if #w > 0 and c == " " then
         -- str_words_to_lines
         if #(l..w) > line_len then
            add(lines, l)
            l = ""
         end

         l, w = l..w.." ", ""
         -- end str_words_to_lines
      else
         w = w..c
      end
   end
   add(lines, l)

   return lines
end

-- if you press the button while text is still being displayed, then the text
-- finishes its display.
function tbox_interact(sound)
   if g_tbox_active then
      g_tbox_anim += .5

      if g_tbox_anim > #g_tbox_active.l1+#g_tbox_active.l2 then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      end

      -- if g_tbox_anim < #g_tbox_active.l1+#g_tbox_active.l2 and sound then
         -- sfx(sound)
      -- end

      if btnp(4) and g_tbox_anim > .5 and g_tbox_active.continue then
         if g_tbox_anim >= #g_tbox_active.l1+#g_tbox_active.l2 then
            del(g_tbox_messages, g_tbox_active)
            g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
         else
            g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
         end
      end
   end
end

-- add a new text box, id is optional, it is the id of the event. you can check
-- if an event is done with a unique id.
function tbox(str)
   local acc, id, speaker, mode, l_str = "", "", "", "|", str.."|"
   local cont = true

   for i=1, #l_str do
      local x = sub(l_str, i, i)

      if x == "^" then
         cont = false
      elseif x == ":" or x == "|" or x == "@" or x == "%" then
         if mode == ":" then
            local lines = str_to_word_lines(acc, g_tbox_max_len)

            for i=1,#lines do
               local l = lines[i]
               if i % 2 == 1 then
                  add(g_tbox_messages, {speaker=speaker, id=id, continue=cont, l1=l, l2=""})
                  id = ""
               else
                  g_tbox_messages[#g_tbox_messages].l2 = l
               end
            end

         elseif mode == "|" then speaker, id = acc, ""
         elseif mode == "@" then id = acc end
         mode, acc = x, ""
      else
         acc=acc..x
      end
   end

   g_tbox_active = g_tbox_messages[1]
end

-- draw the text boxes (if any)
-- foreground color, background color, border width
function ttbox_draw(x, y)
   camera(-x,-y)
   if g_tbox_active then -- only draw if there are messages
      batch_call(rectfill, [[
         {0, 0, 106, 19, 5},
         {1, 1, 105, 18, 6},
         {2, 2, 104, 17, 0}
      ]])

      -- draw speaker
      if #g_tbox_active.speaker>0 then
         local x2 = #g_tbox_active.speaker*4+6
         batch_call(rectfill, [[
            {0, -7, @1, 0, 5},
            {1, -6, @2, 0, 6},
            {2, -5, @3, 1, 0}
         ]], x2, x2-1, x2-2)

         zprint(g_tbox_active.speaker, 4, -3)
      end

      -- print the message
      batch_call(zprint, [[
         {@1, 4, 4, false},
         {@2, 4, 11, true}
      ]],
         sub(g_tbox_active.l1, 1, g_tbox_anim),
         sub(g_tbox_active.l2, 0, max(g_tbox_anim - #g_tbox_active.l1, 0))
      )

      -- draw the arrow
      if g_tbox_active.continue then
         spr(71, 100, ti(40)<20 and 13 or 14)
      end
   end

   camera()
end

function tbox_clear()
   g_tbox_messages, g_tbox_anim, g_tbox_active = {}, 0, false
end

function tbox_stash_push()
   g_tbox_active_backup, g_tbox_messages_backup = g_tbox_active, g_tbox_messages
   tbox_clear()
end

function tbox_stash_pop()
   tbox_clear()
   g_tbox_messages, g_tbox_active = g_tbox_messages_backup, g_tbox_active_backup
end

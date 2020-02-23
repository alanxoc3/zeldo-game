-- We write save data to the general purpose buffer, until a save platform
-- is triggered.
cartdata(CART_NAME)
memcpy(TEMP_SAVE_LOCATION, REAL_SAVE_LOCATION, SAVE_LENGTH)

g_debug, g_debug_message = false, ''

function _init()
   g_money = zdget_value(MONEY)
   poke(0x5f34, 1) -- for pattern colors.

   map_init()

   g_game = gun_vals([[
      { i=@1, u=@2, d=@3 }
   ]], game_init, game_update, game_draw
   )

   g_tl = {
      g_game
   }

   inventory_init()
end

function _update60()
   -- if btnp'0'
      -- then poke(0x5f42,15) -- glitch sound
   -- end
   -- if btnp'1'
      -- then poke(0x5f42,0) -- glitch sound
   -- end

   if g_tbox_update then
      sfx'2'
      if g_tbox_writing then
         g_tbox_anim = #g_tbox_active.l1+#g_tbox_active.l2
      else
         del(g_tbox_messages, g_tbox_active)
         g_tbox_active, g_tbox_anim = g_tbox_messages[1], 0
      end

      if not g_tbox_active then
         unpause()
         g_tbox_messages.trigger()
      end

      g_tbox_update = false
   end

   if btnp'5' and btn'4' then
      g_debug = not g_debug
   end

   tl_node(g_tl,g_tl)
   tbox_interact()
end

function _draw()
   cls()
   if g_debug then rect(0,0,127,127,8) end
   call_not_nil(g_tl, 'd', g_tl)
   if g_debug then
      zprint(g_debug_message, 1, 102)
      zprint(stat(1), 52, 120, true)
   end
end

function game_update()
   patterns_update()
   room_update()

   if not is_game_paused() then
      inventory_update()
      batch_call(
         acts_loop, [[
            {'drawable','reset_off'},
            {'stunnable', 'stun_update'},
            {'act','update'},
            {'mov','move'},
            {'col','move_check',@1},
            {'col','move_check',@4},
            {'trig','trigger_update',@3},
            {'tcol','coll_tile',@2},
            {'rel','rel_update'},
            {'vec','vec_update'},
            {'bounded','check_bounds'},
            {'anim','anim_update'},
            {'timed','tick'},
            {'view','update_view'}
         ]],
         g_act_arrs['col'],
         function(x, y)
            return x >= g_cur_room.x and x < g_cur_room.x+g_cur_room.w and
                   y >= g_cur_room.y and y < g_cur_room.y+g_cur_room.h and
                   fget(mget(x, y), 1)
         end,
         g_pl,
         g_act_arrs['wall']
      )
      energy_update(.25)
      if is_game_paused() then
         g_pause_init = true
      end
   else
      if g_pause_init then
         g_pause_init = false
         batch_call(acts_loop, [[{'act', 'pause_init'}]])
         -- poke(0x5f43,1+2+4) -- softer sound
      end
      batch_call(acts_loop, [[
         {'unpausable', 'update'},
         {'act', 'pause_update'},
         {'rel','rel_update'},
         {'view','update_view'}
      ]])

      if not is_game_paused() then
         batch_call(acts_loop, [[{'act', 'pause_end'}]])
      end
   end

   batch_call(acts_loop, [[{'act', 'clean'}]])

   card_shake_update()
end

g_card_shake_x=0
g_card_shake_y=0
g_card_shake_time=0
function card_shake_update()
   if g_card_shake_time > 0 then
      g_card_shake_x = rnd_one()/8
      g_card_shake_y = rnd_one()/8
      g_card_shake_time -= 1
   else
      g_card_shake_x, g_card_shake_y = 0, 0
      --sfx(9,-2)
   end
end

function card_shake(fx)
   if g_card_shake_time == 0 then
      sfx(fx)
      g_card_shake_time = 15
   end
end

function map_draw(x, y, border_colors)
   if g_view then
      local rx = x - g_view.w/2
      local ry = y - g_view.h/2

      g_view.off_x = -(16-g_view.w)/2+rx
      g_view.off_y = -(16-g_view.h)/2+ry

      local x1, x2 = rx*8, (rx+g_view.w)*8-1
      local y1, y2 = ry*8, (ry+g_view.h)*8-1

      zclip(x1, y1, x2, y2)
      zcls(g_cur_room.c)
      scr_map(g_cur_room.x, g_cur_room.y, g_cur_room.x, g_cur_room.y, g_cur_room.w, g_cur_room.h)

      isorty(g_act_arrs.drawable)
      acts_loop('drawable', 'd')
      if g_debug then acts_loop('dim', 'debug_rect') end
      clip()

      zrect(x1, y1, x2, y2, border_colors)
   end
end

function map_and_act_draw(x, y, border_colors)
   map_draw(x, y, border_colors)
   acts_loop('item_show', 'd')
end

function game_draw()
   fade(g_card_fade)

   local x = 8+g_card_shake_x
   local y = 7+g_card_shake_y

   map_and_act_draw(x, y, [[0,0,13,1]])
   if g_menu_open then
      if g_selected == 5 then g_pl.outline_color = 2 end
      g_pl.d(g_pl)
      g_pl.outline_color = 1
   end
   acts_loop('inventory_item', 'draw_both')

   draw_status()
   local tbox_x = 2
   if is_game_paused'tbox' and not get_cur_ma() then
      tbox_x = 19
   end
   ttbox_draw(tbox_x,105)
   fade(0)
end

function draw_glitch_effect()
   o1 = flr_rnd'0x1f00' + 0x6040
   o2 = o1 + flr(rnd(0x4)-0x2)
   len = flr_rnd'0x40'
   memcpy(o1,o2,len)
end

function game_init()
   map_init()
   g_pl = g_att.pl(0, 0)
   -- load_room(LANK_HOUSE, 3, 4, g_pl)
   load_room(SHOP, 3, 4, g_pl)
end

function pause(reason)
   if reason == 'dancing' or reason == 'chest' then
      mute_music()
   end
   stop_music()

   g_pause_reason=reason g_game_paused=true
end
function unpause() resume_music() g_game_paused=false end

function is_game_paused(reason)
   return g_game_paused and (reason == g_pause_reason or not reason)
end

function zdget_value(ind)
   return peek(TEMP_SAVE_LOCATION+ind)
end

function zdget(ind)
   return zdget_value(ind) > 0
end

function zdset(ind, val)
   return poke(TEMP_SAVE_LOCATION+ind, val or 1)
end

function mute_music()
   sfx(63,0,0)
   sfx(62,1,1)
end

music_val=0
function stop_music(sound)
   poke(0x5f43,3)
   -- mute_music()
   if sound then
      sfx(sound)
   end
end

function resume_music(song)
   switch_song(song)
   poke(0x5f43,0)
   sfx(63,-1)
   sfx(62,-1)
   song = song or g_music_current
   g_music_current = song
end

-- switches the current song
function switch_song(song)
   if song and song != g_music_current then
      g_music_current = song
      music(song, 500, 3)
   end
end

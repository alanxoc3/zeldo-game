-- token: 7560 7575 7564 7580 7721 7731 7636 7637 7725 7662
-- compr: 2561 2569 2575 2682 2896 2906 2754 2759 2776 2774

-- older stats:
-- token: 6991 6928 6926 6907 7086 7707 7723 7768 7707 7741 7732 7718 7560
-- compr: 2748 2816 2782 2776 2994 2317 2471 2471 2471 2571 2593 2628 2561

-- idea: for compression, reuse words from text boxes. It might just be a good idea.

-- ma sprint:
-- TODO: Make ma work correctly for interactable things.
-- TODO: Make ma work for items.

-- pause sprint:
-- TODO: Pause game on tbox.
-- TODO: Pause game on room transition.
-- TODO: Disable inventory on room transition.
-- TODO: Pause game on banjo play.
-- TODO: Banjo play song.

-- throwing sprint:
-- TODO: Bomb throwing. Bomb should be similar to pickupable items.
-- TODO: Plant throwing.
-- TODO: Chicken throwing.
-- TODO: Held item persists through rooms.

-- shovel sprint:
-- TODO: Continue shovel mechanics.
-- TODO: work on shovel animation.

-- item sprint:
-- TODO: Fix the boomerang timeout problem.
-- TODO: Continue bomb mechanics.
-- TODO: Arrow bump bomb or arrow grab bomb.
-- TODO: Boomerang bump bomb or boomerang return bomb.
-- TODO: Sword, shield, and bow persist through rooms.

-- engine sprint:
-- TODO: Think about state name with tl. Add if needed.
-- TODO: Just make bombs better in general.
-- TODO: Fix tbox screen pause

-- tbox sprint:
-- TODO: Tbox triggers should work.
-- TODO: Tbox pop up and down, or think about transition.

-- enemy sprint:
-- TODO: Make the bat enemy do something
-- TODO: Refine the top enemy more.
-- TODO: Make the chicken enemy go crazy.
-- TODO: Interaction with Top enemy and write plans for other enemies.

-- player sprint:
-- TODO: Think about player arm movement (above head? ...).

-- story sprint
-- Finish the basic map transitions.
-- Work on house transitions again.
-- Finish house transitions.

----------------------- things that are done: --------------------
-- done: Inventory spacing left and right correct.
-- done: Fix inventory pixel off problem.
-- done: design menu actor area/transitions. this is done by fading now.
-- done: create title screen.
-- done: Create a more modular view.
-- done: fix tbox double press bugs.
-- done: More efficient trigger, only interact with player.
-- done: create zcls, that uses rectfill to fill the screen (within cropped area).
-- done: cell shading only for sub items.
-- done: Fix ma player 2 parts (for enemies). Fixed with modular view.
-- done: no screen shake when enemy hits enemy/house.
-- done: Think about text interaction more. Only Lank is to the left.
-- done: Separate tbox speaker.
-- done: Connect tbox with menu actors.
-- done: go through sprite file optimizations.
-- done: Make tbox use gun_vals.
-- done: give player money
-- done: Work on sword & shield walking.
-- done: ma don't move if pl not moving (look at dx/dy)
-- done: create power square item.
-- done: tbox only interact if in interact state.
-- done: create a chicken object.
-- done: make bombs work
-- done: make and tweak an after stun timer.
-- done: make item (boomerang) recoil timer.
-- done: copy logic for contains, between trigger and col (or remove it from col).
-- done: house needs to clean up after itself.
-- done: see if caden can fetch/merge.
-- done: delete old map room logic.
-- done: when running out of energy
-- done: create palace map.
-- done: gun vals number
-- done: optimize gun nums again
-- done: player banjo walk
-- done: player no run
-- done: player item in front.
-- done: try the 'just around player' status thing (caden idea.)
-- done: think about sub table gun_vals cache. don't want. problem was state.
-- done: fix enemy share state bug
-- done: tl update don't use t(), or fix pausing.
-- done: create stateful draw.
-- done: tl update return next.
-- done: tl takes no parameters? debate about this idea.
-- done: shield house collision.
-- done: room loading draw on load.
-- done: map rooms need separate init functions.
-- done: item selection sprites, based on pl's items.
-- done: enemy needs to collide with house correctly
-- done: enemy needs to be stunned correctly again.
-- done: enemy collide with screen edge.
-- done: field fix up. field and gravep connect better.
-- done: think about connecting map logic.
-- done: connect up grave dungeon.
-- done: connect up castle
-- done: change drawing functions to work with tl better. incorporate tl even more.
-- done: no double draw items
-- done: create boomerang.
-- done: screen shake when hitting player.
-- done: pl item shakes with pl.
-- done: create separate logic between doors and map.
-- done: tl and actor work together better.
-- done: add nf (nothing function) to the gun vals logic.
-- done: make tl optional.
-- done: fix string or value bug in gun nums.
-- done: make actor update more simple (use tl?).
-- done: do we need a begin init function? (no, embed tl can handle that).
-- done: fix tbox arrow sprite offset.
-- done: create actor/parent more simple? no. it is good.
-- done: create actor adds actor to g_attach.
-- done: rethink items again. 
-- done: create power square variable.
-- done: make enemy health bar.
-- done: make the top 'tired' bar work.
-- done: connect the map.
-- done: make the code size smaller in menu.
-- done: token cleanup on status bars
-- done: menu actor name and different backgrounds. opted with black background.
-- done: nice functions to integrate with menu actors. think i did this.
-- done: create card transitions.
-- done: change the top of the screen (new layout).
-- done: menu enemy support must be better.
-- done: make area information (if no enemy). opted no, i can have signs.
-- done: tl embedded tl. decided on no! Then I later implemented it!
-- done: tbox pause the game. should it? if so, do it. it is right now.
-- done: make a sign
-- done: create 2 parts of lank (feet and arms).

g_debug, g_debug_message = false, ''

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_pal_gray = gun_vals('5,5,13,13,5,6,6,6,6,6,6,6,13,6,6')
   g_pal_norm = gun_vals('1,2,3,4,5,6,7,8,9,10,11,12,13,14,15')
   g_pal = g_pal_norm

	init_particles({ g_snow, g_rain })

   g_game = gun_vals_new([[
      { i=@1, u=@2, d=@3 }
   ]], game_init, game_update, game_draw
   )

   g_tl = {
      g_logo, g_title,
      g_game
   }

   inventory_init()
end

function _update60()
   if btnp'5' and btn'4' then g_debug = not g_debug end
   tl_node(g_tl,g_tl)
   tbox_interact()
end

function _draw()
   cls()
   call_not_nil('d', g_tl)
   if g_debug then
      zprint(g_debug_message, 1, 102)
      zprint(stat(1), 104, 102)
   end
end

function game_update()
   patterns_update()
   inventory_update()
   room_update()

      batch_call(
         acts_loop, [[
            {'drawable','reset_off'},
            {'stunnable', 'stun_update'},
            {'act','update'},
            {'mov','move'},
            {'col','move_check',@1},
            {'col','move_check',@4},
            {'trig','is_in_trig',@3},
            {'tcol','coll_tile',@2},
            {'rel','rel_update',@3},
            {'vec','vec_update'},
            {'bounded','check_bounds'},
            {'act', 'clean'},
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
      update_timers()

	-- spawn_particles(1, 0, 0, 10, 10)
   -- spawn_particles(2, 0, 0, 10, 10)
	update_particles()

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
      sfx(9,-2)
   end
end

function card_shake(fx)
   if g_card_shake_time == 0 then
      sfx(fx)
      g_card_shake_time = 15
   end
end

function map_and_act_draw(x, y, border_colors)
   local rx = x - g_view.w/2
   local ry = y - g_view.h/2

   g_view.off_x = -(16-g_view.w)/2+rx
   g_view.off_y = -(16-g_view.h)/2+ry

   for k,v in pairs(border_colors) do
      rectfill(rx*8+k,ry*8+k, (rx+g_view.w)*8-k-1, (ry+g_view.h)*8-k-1, v)
   end

   zclip(rx*8+4, ry*8+4, (rx+g_view.w)*8-5, (ry+g_view.h)*8-5)
   zcls(g_cur_room.c)
   scr_map(g_cur_room.x, g_cur_room.y, g_cur_room.x, g_cur_room.y, g_cur_room.w, g_cur_room.h)

   isorty(g_act_arrs.drawable)
   acts_loop('drawable', 'd')
   draw_particles()

   if g_debug then acts_loop('dim', 'debug_rect') end

   clip()
end

function game_draw()
   fade(g_card_fade)

   local x = g_transition_x+8+g_card_shake_x
   local y = g_transition_y+8-6/8+g_card_shake_y

   map_and_act_draw(x, y, {5,1})
   if g_menu_open then
      if g_selected == 5 then g_pl.outline_color = 2 end
      g_pl.d(g_pl)
      g_pl.outline_color = 1
   end
   acts_loop('inventory_item', 'draw_both')

   draw_status()
   local tbox_x = 1
   if g_tbox_active and g_tbox_active.speaker == "Lank" then
      tbox_x = 20
   end
   ttbox_draw(tbox_x,107)
   fade(0)
end

function draw_glitch_effect()
   o1 = flr(rnd(0x1f00)) + 0x6040
   o2 = o1 + flr(rnd(0x4)-0x2)
   len = flr(rnd(0x40))
   memcpy(o1,o2,len)
end

function game_init()
   map_init()
   g_pl = gen_pl(0, 0)
   load_room('village', 12, 7)

   tbox([[
      speaker="Lank", "Are you ready to play the Story of Zeldo?", "Ok, let's play!"
   ]])
end

-- the story of zeldo
-- amorg games

-- todo: make and tweak an after stun timer.
-- todo: make item (boomerang) recoil timer.
-- todo: no screen shake when enemy hits enemy/house.
-- todo: fix string or value bug in gun nums.

-- todo: create actor/parent more simple? Very similar now.
-- todo: go through sprite file optimizations.
-- todo: tl embedded tl.
-- todo: think about text interaction more.

-- todo: create card transitions.
-- todo: create tbox movement/transition.
-- todo: fix tbox arrow sprite offset.
-- todo: tbox pause the game.

-- todo: menu enemy support must be better.
-- todo: design menu actor area/transitions.
-- todo: nice functions to integrate with menu actors.
-- todo: connect tbox with menu actors.
-- todo: menu actor name and different backgrounds.
-- todo: make enemy health bar.
-- todo: make area information (if no enemy).

-- todo: connect everything.
-- todo: create title screen.
-- todo: make a sign

-- todo: give player money
-- todo: make bombs work

-- things that are done:
-- done: house needs to clean up after itself.
-- done: delete old map room logic.
-- done: create palace map.
-- done: gun vals number
-- done: optimize gun nums again
-- done: player banjo walk
-- done: player no run
-- done: player item in front.
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
-- done: field fix up. Field and gravep connect better.
-- done: think about connecting map logic.
-- done: connect up grave dungeon.
-- done: connect up castle
-- done: change drawing functions to work with tl better. Incorporate tl even more.
-- done: no double draw items
-- done: create boomerang.
-- done: screen shake when hitting player.
-- done: pl item shakes with pl.
-- done: create separate logic between doors and map.
-- done: tl and actor work together better.
-- done: add nf (nothing function) to the gun vals logic.
-- done: make tl optional.

-- token:
-- 5180 5168 5166 5129 5258 5248 5244 5076 4983 5005 4994 4986 4985 4976 4965
-- 4971 4979

-- compress:
-- 16285 15360

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_pal_gray = gun_vals("5,5,13,13,5,6,6,6,6,6,6,6,13,6,6")
   g_pal_norm = gun_vals("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")
   g_pal = g_pal_norm

   g_tl = tl_init([[
         { i=@1, u=@2, d=@3 }
      ]],
      -- init_logo, update_logo, draw_logo,
      -- title_init, title_update, title_draw,
      game_init, game_update, game_draw
   )
      
      --{ init_logo,  2.5, update_logo,  draw_logo },
      --{ title_init, 1,   title_update, title_draw },
      --{ game_init,  nil, game_update,  game_draw }
   --)

   inventory_init()
end

function _update60()
   tl_update(g_tl)
   tbox_interact()
end

function _draw()
   cls()
   tl_func("d", g_tl)
   ttbox_draw(20,107)
   -- draw_ma()
   zprint(stat(1), 75, 4)
end

function game_update()
   patterns_update()
   inventory_update()
   room_update()

   batch_call(
      acts_loop, [[
         {$drawable$,$reset_off$},
         {$stunnable$, $stun_update$},
         {$act$,$update$},
         {$mov$,$move$},
         {$col$,$move_check$,@1},
         {$col$,$move_check$,@4},
         {$tcol$,$coll_tile$,@2},
         {$rel$,$rel_update$,@3},
         {$vec$,$vec_update$},
         {$bounded$,$check_bounds$},
         {$act$, $clean$},
         {$anim$,$anim_update$},
         {$timed$,$tick$}
      ]],
      g_act_arrs["col"],
      function(x, y)
         return x >= g_rx and x < g_rx+g_rw and
                y >= g_ry and y < g_ry+g_rh and
                fget(mget(x, y), 1)
      end,
      g_pl,
      g_act_arrs["wall"]
   )

   update_view(g_pl.x, g_pl.y)

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
   end
end

function card_shake(tim)
   g_card_shake_time = tim
end

function game_draw()
   rectfill(0,0,127,127,0)
   draw_cur_room(8+g_card_shake_x, 7 + 3/8+g_card_shake_y)

   if g_menu_open then
      inventory_draw(64,59)
   end

   -- acts_loop("dim", "debug_rect")
   draw_status_bars()
   print(g_rooms[g_cur_room].n or g_cur_room, 30, 110, 7)
   -- draw_glitch_effect()
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
   -- load_room("lank's path", 2, 18)
   -- load_room("sword sanctuary", 37, 59)
   -- load_room("field", 52, 30) -- debug tech
   load_room("villa", 21, 29)
   -- load_room("title", 101, 36)
   -- load_room("cas_1", 69, 30)
   --load_room("cem_2", 99, 29)
    
   --load_room("tom_1", 125, 27)
   tbox("lank:12341234561 1901234567890 234123456 8901234567890hh ")
end

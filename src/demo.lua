-- todo: room loading draw on load.

-- todo: enemy needs to collide with house correctly
-- todo: enemy needs to be stunned correctly again.
-- todo: enemy collide with screen edge.

-- todo: menu enemy support must be better.
-- todo: delete old map room logic.
--
-- todo: create palace map.
-- todo: go through sprite file optimizations.
-- todo: change drawing functions to work with tl better. Incorporate tl even more.
-- todo: create actor/parent more simple? Very similar now.

-- todo: tl embedded tl.
-- todo: pl item shakes with pl.

-- todo: no double draw items
-- todo: field fix up. Field and gravep connect better.

-- todo: think about connecting map logic.
-- todo: connect up grave dungeon.
-- todo: connect up castle

-- todo: think about text interaction more.

-- done: house needs to clean up after itself.
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
-- todo: map rooms need separate init functions.

-- readme todos:
-- todo: Connect everything.
-- todo: Create title screen.
-- todo: Create card transitions.
-- todo: Make area information (if no enemy).
-- todo: Make enemy health bar.
-- todo: Connect Tbox with menu actors.
-- todo: Menu actor name and different backgrounds.
-- todo: Nice functions to integrate with menu actors.
-- todo: Make a sign
-- todo: Create separate logic between doors and map.




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

   tbox("lank:...:...:...:1234123456 901234567890 234123456 8901234567890 ")
end

function _update60()
   tl_update(g_tl)
   tbox_interact()
end

function _draw()
   cls()
   tl_func("d", g_tl)
   ttbox_draw(7, 0)
   -- draw_ma()
   zprint(stat(1), 75, 4)
end

function game_update()
   menu_update()

   if not g_menu_open then
      batch_call(
         acts_loop, [[
            {$drawable$,$reset_off$},
            {$stunnable$, $stun_update$},
            {$act$,$update$},
            {$mov$,$move$},
            {$col$,$move_check$,@1},
            {$tcol$,$coll_tile$,@2},
            {$rel$,$rel_update$,@3},
            {$vec$,$vec_update$},
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
         g_pl
      )

      update_view(g_pl.x, g_pl.y)
      room_update()
   end
end

function game_draw()
   rectfill(0,0,127,127,0)
   draw_cur_room(8, 7 + 3/8)

   if g_menu_open then
      draw_menu(64,59)
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
   -- load_room("tech entrance", 120, 60) -- debug tech
   load_room("castle entrance", 90, 5 )
end

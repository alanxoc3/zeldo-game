--
-- todo: create palace map.
-- todo: go through sprite file optimizations.
-- todo: tl update return next.
-- todo: tl embedded tl.
-- todo: tl update don't use t(), or fix pausing.
-- todo: gun vals number
-- todo: no double draw items
-- todo: field fix up. Field and gravep connect better.
-- todo: connect up grave dungeon.
-- todo: connect up palace.
-- todo: think about text interaction more.
--
-- done: player banjo walk
-- done: player no run
-- done: player item in front.
-- done: think about sub table gun_vals cache. don't want. problem was state.
-- done: fix enemy share state bug
--
--
--
--


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
-- 5180 5168 5166 5129 5258 5248 5244 5076

-- compress:
-- 16285 15360

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_pal_gray = gun_vals("5,5,13,13,5,6,6,6,6,6,6,6,13,6,6")
   g_pal_norm = gun_vals("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")
   g_pal = g_pal_norm

   g_tl = tl_init(gun_vals([[
            { i=@, u=@, d=@ }
         ]],
         -- init_logo, update_logo, draw_logo,
         -- title_init, title_update, title_draw,
         game_init, game_update, game_draw
      )
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
   tl_func(g_tl, "d")
   ttbox_draw(7, 0)
   draw_ma()
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
            {$col$,$move_check$,@},
            {$tcol$,$coll_tile$,@},
            {$rel$,$rel_update$,@},
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

   for i=20,26 do
      gen_spawner(4, i, gen_top, 12)
   end

   load_room("village", 5, 5)
end

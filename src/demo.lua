-- token:
-- 5180 5168 5166

-- compress:
-- 16285

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_pal_gray = gun_vals("5,5,13,13,5,6,6,6,6,6,6,6,13,6,6")
   g_pal_sepi = gun_vals("2,2,4,4,2,4,4,4,4,4,4,4,4,4,4")
   g_pal_norm = gun_vals("1,2,3,4,5,6,7,8,9,10,11,12,13,14,15")
   g_pal = g_pal_norm

	g_tl = tl_init([[
         { i=@, u=@, d=@ }
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
   -- batch_call(rectfill, "{0,0,127,15,0}, {0,112,127,127,0}")
   -- draw_glitch_effect()
end

function draw_glitch_effect()
   o1 = flr(rnd(0x1f00)) + 0x6040
   o2 = o1 + flr(rnd(0x4)-0x2)
   len = flr(rnd(0x40))
   memcpy(o1,o2,len)
end

function game_init()
	-- palt(0, false)
   -- deku_spawner(3.5, 22.5, true)
   map_init()

   -- for i=0,10,2 do gen_spawner(12, 15+i, gen_deku, 12, true) end
   g_pl = gen_pl(0, 0)

   -- gen_spawner(71, 53, gen_top, 12)
   for i=20,26 do
      gen_spawner(4, i, gen_top, 12)
   end
   --gen_spawner(4, 20, gen_top, 12)
   --gen_spawner(6, 20, gen_top, 12)
   --gen_spawner(8, 20, gen_top, 12)
   --gen_spawner(10, 20, gen_top, 12)

   -- load_room("dun73", 4, 4)
   load_room("fairy grave entrance", 5, 5)
   -- load_room("cave", 30, 2)
   -- load_room("bossw", 5, 5)
end

-- todo: tbox and menu actor integration.
-- todo: allow actor and sprite index for menu actor.
-- todo: menu actor, different name and different backgrounds.
-- todo: nice functions to integrate with menu actor.
-- todo: room fades
-- todo: make a sign
-- todo: make enemy health bar / status
-- todo: make area information (if no enemy)
--
-- done: reconnect the map.
-- 2% compression here.
-- 3522 3529 3503 3510 3521 3523 3538 3526 3487 3428 3635 3660 3652 3545 3494
-- 3487 3743 3686 3675 3585 3591 3797 3802 3759 3755 3861 4663 4470 4457 4478
-- 4477 4488 4387 4353 4369 4404 4338 4330 4316 4308 4288 4280 4259 4257 4272
-- 4295 4275 4259 4223 4206 4205 4212 4200 4198 4187 4232 4232 4230 4227 4212
-- 4206 4198 4283 4219 4321 4312 4190 4104 4094 4087 4123 4121 4119 4141 4099
-- 4089 4075 4040 4015 4169 4180 4170 4145 4225 4665 5565 5549 5800 6043 4775
-- 4760 4755 4746 5143 5144 5140 5137 5096 5067 5055 4967 4946 4946 4945 4947
-- 4946 4941 5143 5144 5140 5137 5096 5067 5055 4967 4946 4946 4945 4947 4946
-- 4984 4982 4979 4970 4862 5250 5296 5284 5285 5282 5275 5264 5260 5157 5084
-- 5074 5048

-- .2093 (.1888)

-- 80% 95% 96% 104%

function _init()
   poke(0x5f34, 1) -- for pattern colors.
   g_pal_gray = gun_vals("5,5,13,13,5,6,6,6,6,6,6,6,13,6,6")
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

   init_out_cache(54,127)

   tbox("lank:...:...:...:1234123456 901234567890 234123456 8901234567890 ")
end

function _update60()
   tl_update(g_tl)
   tbox_interact()
end

function _draw()
	cls()
	tl_draw(g_tl)
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
   if g_menu_open then g_pal = g_pal_gray
   else g_pal = g_pal_norm end

   restore_pal()

   rectfill(0, 0, 127, 127, 0x1)

   draw_cur_room()

   if g_menu_open then
      draw_menu()
   end

   print(g_cur_room, 30, 100, 7)

   -- acts_loop("dim", "debug_rect")
   draw_status_bars()
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
   -- load_room("grave", 5, 5)
   load_room("villa", 4, 4)
end

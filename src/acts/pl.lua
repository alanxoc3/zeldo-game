-- SECTION: NPC
-- SECTION: PL
create_actor([['lank_top', 1, {'rel','spr_obj','danceable'}]], [[
      rel_actor=@1,
      sind=147, iyy=-2,
      u=@2, pause_update=@3
]], function(a)
   a.xf, a.alive = g_pl.xf, g_pl.alive

   if g_pl:get[['item','throwable']] then
      a.sind=g_pl.item.throwing and 150 or 148
   else
      a.sind=147
   end
end, function(a)
   if is_game_paused'dancing' then
      a.dance_update(a)
      a.sind = abs(a.dance_time) > .5 and 149 or 147
   elseif is_game_paused'chest' then
      a.sind=148
   end
end
)

create_actor([['grabbed_item', 4, {'rel','spr_obj'}]], [[
   rel_actor=@1, sind=@2, iyy=@3, create_func=@4,
   throwable=true,
   flippable=true,
   being_held=true,
   {i=@6, throwing=false, tl_max_time=.2}, { i=nf, u=@5 }, { throwing=true, visible=false, tl_max_time=.05 }
]], function(a)
   if btnp'4' or btn'5' then
      sfx'6'
      a.create_func(a.x, a.y+a.iyy/8, a.xf)
      return true
   end
end, function(a)
   sfx'5'
end)

create_actor([['fairy', 1, {'drawable', 'mov'}]], [[
   rel_actor=@1, sind=52, u=@2, off_x=1, off_y=0, d=@3,
   fg=12, bg=6,
   -- fg=1, bg=2,
    room_init=@4
]], function(a)
   local act = get_cur_ma() or a.rel_actor

   local dist = abs(a.x-act.x) + abs(a.y-act.y)
   amov_to_actor(a, act, dist*.025, a.off_x, a.off_y)
   a.off_x = cos(a.tl_tim*.5)
   a.off_y = sin(a.tl_tim*.5)-.25

   a.xf = a.dx < 0

   destroy_effect(a, 1, a.fg, a.bg)
   if flr(a.tl_tim / 10) % 2 == 0 then
      a.off_x = -a.off_x
   end
end, function(a)
   scr_circfill(a.x, a.y, .125, a.fg)
end, function(a)
   a.x = a.rel_actor.x
   a.y = a.rel_actor.y
end)

create_actor(
[['pl', 2, {'anim','col','mov','tcol','hurtable','knockable','stunnable','spr','danceable'}]], [[
   name="'lank'",
   x=@1,
   y=@2,
   sinds={144, 145, 146},
   sind=144,
   rx=.375,
   ry=.375,
   iyy=-2,
   spd=.02,
   anim_len=3,
   anim_spd=5,
   max_health=LANK_START_HEALTH,
   health=LANK_START_HEALTH,
   i=@3, u=@4, destroyed=@5, d=@6, room_init=@7, set_color=@8
]], function(a)
   a.ltop = g_att.lank_top(a)
end, function(a)
   -- movement logic
   if a.stun_countdown == 0 then
      if not btn'5' then
         if (xbtn() != 0) and not a:get[['item','item_slow']] then a.xf = btn'0' end
         a.ax, a.ay = xbtn()*a.spd, ybtn()*a.spd
         if g_debug then
            a.ax *= 3
            a.ay *= 3
            a.touchable=false
         else
            a.touchable=true
         end
      else
         a.ax = 0 a.ay = 0
      end
   end

   if a:get[['item','item_stop']] then
      a.ax, a.ay = 0, 0
   end

   -- item logic
   if not btn'5' and not a.item and btnp'4' then
      if not get_selected_item().interact then
         if g_energy_tired then
            sfx'7'
         else
            a.item = gen_pl_item(a)
            sfx'5'
         end
      end
   end

   local item = a.item

   if item then
      if not item.alive then
         a.item = nil
      end

      if not btn'4' and not btn'5' then
         item.being_held = false
      end

      a.ax *= .5 a.ay *= .5
   end

   -- walking animation logic
   a.anim_len = abs(a.dx) + abs(a.dy) > 0 and 3 or 1

   -- shaking logic
   if a.stun_countdown != 0 and a.item then
      a.item.xx = a.xx
   end
end, function(a)
   if a.item then a.item.alive = false end
-- draw
end, function(a)
   scr_spr_out(a) scr_spr_out(a.ltop)
   if a.item and not a.item.spr then
      scr_spr_out(a.item)
   end

   scr_spr(a) scr_spr(a.ltop)
   if a.item and not a.item.spr then
      scr_spr(a.item)
   end
end, function(a)
   a:i()
   a.lanks_fairy, a.room_init = g_att.fairy(a)
end, function(a, color) -- set color
   a.outline_color, a.ltop.outline_color = color, color
end)

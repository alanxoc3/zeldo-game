function create_lank_top()
   return create_actor([[
      id='lank_top', par={'rel','spr_obj'},
      att={
         rel_actor=@1,
         sind=147,
         iyy=-2,
         u=@2
      }
   ]], g_pl, function(a)
      a.xf = g_pl.xf
      a.alive = g_pl.alive
      a.outline_color = g_pl.outline_color

      if g_pl.item and g_pl.item.throwable then
         a.sind=148
      else
         a.sind=147
      end
   end)
end

function create_grabbed_item(sind, yoff, create_func)
   return create_actor([[
      id='grabbed_item', par={'rel','spr_obj'},
      att={
         rel_actor=@1,
         throwable=true,
         sind=@2,
         iyy=@3,
         being_held=true,
         tl_loop=false,
         { i=@5, tl_max_time=.25 }, { u=@4 }
      }
   ]], g_pl, sind, yoff, function(a)
      if not btn(4) or not a.being_held then
         create_func(g_pl)
         return true
      end
   end, function(a)
      a.xf = g_pl.xf
      g_debug_message = a.tl_tim
   end)
end

function gen_pl(x, y)
   return create_actor(
      [[ id='pl', par={'anim','col','mov','tcol','hurtable','knockable','stunnable','spr'},
         att={
            name="Lank",
            x=@1,
            y=@2,
            sinds={144, 145, 146},
            rx=.375,
            ry=.375,
            xb=.25,
            yb=.25,
            iyy=-2,
            spd=.02,
            anim_len=3,
            anim_spd=5,
            max_health=500,
            health=500,
            i=@3, u=@4, destroyed=@5, d=@6
         }
      ]], x, y, function(a)
         a.ltop = create_lank_top()
      end, function(a)
         -- movement logic
         if a.stun_countdown == 0 then
            if not btn'5' then
               if not a.item and (xbtn() != 0) then a.xf = btn'0' end
               a.ax = xbtn()*a.spd
               a.ay = ybtn()*a.spd
            else
               a.ax = 0 a.ay = 0
            end
         end

         if a.item and a.item.lank_banjo then
            a.ax = 0 a.ay = 0
         end

         -- item logic
         if not btn'5' and not a.item then
            if btnp'4' and g_energy_tired then
               if g_selected != G_INTERACT then
                  sfx'7'
               end
            elseif btnp'4' and not g_energy_tired then
               if get_selected_item().name == 'bomb' then
                  if remove_money(5) then
                     -- a.item = create_grabbed_item(5, -6, create_bomb)
                     a.item = create_grabbed_item(32, -7, function(a) g_att.chicken(a.x, a.y) end)
                     -- a.item = create_grabbed_item(49, -9, function(a) g_att.pot(a.x, a.y) end)
                     sfx'5'
                  else
                     sfx'7'
                  end
               elseif g_selected != G_INTERACT then
                  a.item = gen_pl_item(a, g_selected)
                  sfx'5'
               end
            end
         end

         local item = a.item

         -- todo: make this better. this is so ugly.
         if g_transitioning then
            a.ax = 0 a.ay = 0
         end

         if item then
            if not item.alive then
               a.item = nil
            end

            if (not btn'4' or btn'5') then
               item.being_held = false
            end

            a.ax *= .5
            a.ay *= .5
         end

         a.anim_sind = nil

         -- walking animation logic
         if flr((abs(a.dx) + abs(a.dy))*50) > 0 then
            a.anim_len = 3
         else
            a.anim_len = 1
         end

         -- shaking logic
         if a.stun_countdown != 0 then
            if a.item then
               a.item.xx = a.xx
            end
         end
      end, function(a)
         if a.item then a.item.alive = false end
      -- draw
      end, function(a)
         a.ltop.outline_color = a.outline_color
         scr_spr_out(a.ltop)
         scr_spr_out(a)
         -- if a.item and a.item.throwable then scr_spr_out(a.item) end

         if a.item and not a.item.spr then
            scr_spr_out(a.item)
         end

         scr_spr(a.ltop)
         scr_spr(a)
         -- if a.item and a.item.throwable then scr_spr(a.item) end

         if a.item and not a.item.spr then
            scr_spr(a.item)
         end
      end
   )
end

function gen_pl_item(pl, item_type)
   return get_selected_item() and get_selected_item().func(pl)
end

function create_lank_top()
   return create_actor([[
      id='lank_top',
      att={
         sind=147,
         iyy=-2,
         u=@1
      }, par={'rel','spr_obj'}
   ]], function(a)
      a.xf = g_pl.xf
      a.alive = g_pl.alive
      a.outline_color = g_pl.outline_color
   end)
end

function gen_pl(x, y)
   local ltop = create_lank_top()
   return create_actor(
      [[ id='pl',
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
            max_health=50,
            health=50,
            u=@3, destroyed=@4, d=@5
         },
         par={'anim','col','mov','tcol','hurtable','knockable','stunnable','spr'}
      ]], x, y, function(a)
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

         -- item logic
         if not btn'5' and not a.item then
            if btnp'4' and g_energy_tired then
               if g_selected != G_INTERACT then
                  sfx'7'
               end
            elseif btn'4' and not g_energy_tired then
               if get_selected_item().name != 'bomb' or remove_money(5) then
                  if g_selected != G_INTERACT then
                     a.item = gen_pl_item(a, g_selected)
                     sfx'5'
                  end
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
               item.holding = false
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
         ltop.outline_color = a.outline_color
         scr_spr_out(ltop)
         scr_spr_out(a)
         if a.item and not a.item.spr then
            scr_spr_out(a.item)
         end

         scr_spr(ltop)
         scr_spr(a)
         if a.item and not a.item.spr then
            scr_spr(a.item)
         end
      end
   )
end

function gen_pl_item(pl, item_type)
   return get_selected_item() and get_selected_item().func(pl)
end

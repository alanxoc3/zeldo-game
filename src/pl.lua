function gen_pl(x, y)
   return create_actor(
      [[ id=$pl$,
         att={
            x=@1,
            y=@2,
            sinds={56, 57, 58, 59},
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
            u=@4, d=@5, hit=@3
         },
         par={$anim$,$col$,$mov$,$tcol$,$hurtable$,$knockable$,$stunnable$,$spr$}
      ]], x, y,
      function(self, other, xdir, ydir)
      end, function(a)
         -- movement logic
         if a.stun_countdown == 0 then
            if not btn(5) and not (btn(0) and btn(1)) then
               if btn(0) then
                  if not a.item then a.xf = true end
                  a.ax = -a.spd
               elseif btn(1) then
                  if not a.item then a.xf = false end
                  a.ax =  a.spd
               else a.ax = 0 end
            else
               a.ax = 0
            end

            if not btn(5) and not (btn(2) and btn(3)) then
               if     btn(2) then a.ay = -a.spd
               elseif btn(3) then a.ay =  a.spd
               else a.ay = 0 end
            else
               a.ay = 0
            end
         end

         -- item logic
         if btn(4) and not btn(5) and not a.item and not g_energy_tired then
            a.item = gen_pl_item(a, g_selected)
         end

         local item = a.item

         if item then
            if not item.alive then
               a.item = nil
            end

            if g_energy_tired or (not btn(4) or btn(5)) then
               item.holding = false
            end

            a.ax /= 2 a.ay /= 2
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
      end, scr_spr_out
   )
end

function gen_pl_item(pl, item_type)
   return g_all_items[item_type] and g_all_items[item_type].func and g_all_items[item_type].func(pl)
end

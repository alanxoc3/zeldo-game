function btn_to_dir()
   return (btn(0) and 0b0001 or 0) +
          (btn(1) and 0b0010 or 0) +
          (btn(2) and 0b0100 or 0) +
          (btn(3) and 0b1000 or 0)
end

function act_poke(a, ix1, ix2)
   if a.poke > 0 then
      a.poke -= 1
      a.ixx = a.xf and ix1 or -ix1
   else
      a.ixx = a.xf and ix2 or -ix2
   end
end

function gen_pl(x, y)
   return create_actor(
      [[ id=$pl$,
         att={
            confined=false,
            x=@1,
            y=@2,
            sinds={56, 57, 58, 59},
            rx=.375,
            ry=.375,
            iyy=-2,
            spd=.02,
            anim_len=3,
            anim_spd=5,
            max_hearts=3,
            hearts=3,
            draw=@5
         },
         par={$anim$,$col$,$mov$,$tcol$,$hurtable$,$knockable$,$stunnable$,$spr$},
         tl={
            {u=@4, hit=@3}
         }
      ]], x, y,
      function(self, other, xdir, ydir)
      end, function(a)
         -- movement logic
         if a.stun_countdown == 0 then
            if not (btn(0) and btn(1)) then
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

            if btn(2) then a.ay = -a.spd end
            if btn(3) then a.ay =  a.spd end
            if not (btn(2) or btn(3)) or btn(2) and btn(3) then a.ay = 0 end
         end

         -- item logic
         if btn(4) and not a.item then
            a.item = gen_pl_item(a, g_selected)
         end

         local item = a.item
         if (not btn(4) or btn(5)) then
            if item then item.holding = false end
         end

         if item then
            if item then
               a.ax /= 2 a.ay /= 2
            else
               a.ax, a.ay = 0, 0
            end

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
      scr_spr_out(a)
      if a.item then
         scr_spr(a.item)
      end
   end)
end

function gen_pl_item(pl, item_type)
   return g_all_items[item_type] and g_all_items[item_type].func and g_all_items[item_type].func(pl)
end

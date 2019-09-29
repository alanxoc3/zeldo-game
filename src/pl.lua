function create_lank_top()
   return create_actor([[
      id="lank_top",
      att={
         sind=147,
         iyy=-2,
         u=@1
      }, par={"rel","ospr"}
   ]], function(a)
      a.xf = g_pl.xf
      a.alive = g_pl.alive
   end)
end

function gen_pl(x, y)
   create_lank_top()
   return create_actor(
      [[ id="pl",
         att={
            name="|lank",
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
            u=@3, destroyed=@4
         },
         par={"anim","col","mov","tcol","hurtable","knockable","stunnable","ospr"}
      ]], x, y, function(a)
         -- movement logic
         if a.stun_countdown == 0 then
            if not btn(5) then
               if not a.item and (xbtn() != 0) then a.xf = btn(0) end
               a.ax = xbtn()*a.spd
               a.ay = ybtn()*a.spd
            else
               a.ax = 0 a.ay = 0
            end
         end

         -- item logic
         if btn(4) and not btn(5) and not a.item and not g_energy_tired then
            if get_selected_item().name != "bomb" or remove_money(5) then
               a.item = gen_pl_item(a, g_selected)
            else
               -- todo: insert sfx here.
            end
         end

         local item = a.item

         -- todo: make this better. this is so ugly.
         if g_transitioning or g_tbox_active then
            a.ax = 0 a.ay = 0
         end

         if item then
            if not item.alive then
               a.item = nil
            end

            if g_energy_tired or (not btn(4) or btn(5)) then
               item.holding = false
            end

            if item.id == "lank_banjo" or item.id == "lank_brang" then
               a.ax = 0
               a.ay = 0
            elseif item.id != "lank_bomb" then
               a.ax /= 2 a.ay /= 2
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
         if a.item then a.item.alive = false end
      end
   )
end

function gen_pl_item(pl, item_type)
   return get_selected_item() and get_selected_item().func(pl)
end

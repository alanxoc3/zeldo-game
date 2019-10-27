G_INTERACT = 5

function act_poke(a, ix1, ix2)
   if a.poke > 0 then
      a.poke -= 1
      a.ixx = a.xf and ix1 or -ix1
   else
      a.ixx = a.xf and ix2 or -ix2
   end
end

g_att.item_selector = function()
   return create_actor([[
      id="item_selector",
      att={
         aaoeu=3,
         d=@1,
         u=@2
      },
      par={"rel","drawable"}
      ]],function(a)
         -- scr_circ(a.x-.125, a.y, .5, 8)
      end, function(a)
         -- from index to coordinate
         local x, y = (g_selected-1)%3, flr((g_selected-1)/3)

         x += xbtnp()
         y += ybtnp()

         -- only allow movement within bounds.
         x, y = max(0,min(x,2)), max(0,min(y,2))

         -- from coordinate to index
         local next_selected = y*3+x+1

         if g_selected != next_selected then
            g_items_drawn[g_selected].selected = false
            g_items_drawn[next_selected].selected = true

            -- tbox_clear()
         end

         g_selected = next_selected
      end
   )
end

g_att.inventory_item = function(x, y, item)
   g_debug_message = "hi "..x
   local selected_x = x*1.25
   local selected_y = y*1.25
   return create_actor([[
      id="inventory_item",
      att={
         d=@5, rel_x=@1, rel_y=@2, sind=@3, visible=@3, xf=@4
      },
      par={"rel","spr_obj","drawable"},
      tl={}
      ]],x,y,item.sind,g_pl.xf, function(a)
         if a.selected then
            local c1 = a.selected and 9 or 5
            local c2 = a.selected and 10 or 5
            local size = a.selected and .25 or 0
            scr_circfill(a.x+sin(t())/2, a.y+cos(t())/2, size+.125, 1)
            scr_circfill(a.x+sin(t()-.5)/2, a.y+cos(t()-.5)/2, size+.125, 1)
            scr_circfill(a.x+sin(t())/2, a.y+cos(t())/2, size, c1)
            scr_circfill(a.x+sin(t()-.5)/2, a.y+cos(t()-.5)/2, size, c2)
            -- scr_circfill(a.x+sin(t()-.5)/4, a.y+cos(t()-.5)/4, size, c2)
         end
      end
   )
end

function create_inventory_items()
   if not g_items_drawn then
      sfx"3"
      g_item_selector = g_att.item_selector()
      g_items_drawn = {}
      local item_order = {3,2,1,4,7,8,9,6,5}
      local item_spread_radius = 2
      for k, v in pairs(item_order) do
         local item = g_items[v]
         local item_x, item_y = cos(k/8)*item_spread_radius, sin(k/8)*item_spread_radius
         if v == 5 then item_x, item_y = 0, 0 end

         if item.enabled then
            g_items_drawn[v] = g_att.inventory_item(item_x, item_y, item)
         end
      end
      g_items_drawn[5].selected = true
   end
end

function destroy_inventory_items()
   foreach(g_items_drawn, function(a) a.alive = false end)
   if g_item_selector then
      sfx"4"
      g_item_selector.alive = false
   end
   g_item_selector = nil
   g_items_drawn = nil
end

function inventory_init()
   -- global_items
   g_items = gun_vals([[
      {name="banjo"   , enabled=true, func=@1, sind=1, desc="|^banjo:play a sick tune!"},
      {name="brang"   , enabled=true, func=@2, sind=4, desc="|^brang:stun baddies. get items."},
      {name="shovel"  , enabled=true, func=@3, sind=3, desc="|^shovel:dig things up. kill the grass."},
      {name="shield"  , enabled=true, func=@4, sind=6, desc="|^shield:be safe from enemy attacks."},
      {name="interact", enabled=true, func=nf, sind=false, desc="|^interact:talk to people, pick up things, read signs."},
      {name="sword"   , enabled=true, func=@5, sind=2, desc="|^sword:hurts bad guys."},
      {name="bomb"    , enabled=true, func=@6, sind=5, desc="|^bomb:only 5 power squares to blows things up!"},
      {name="bow"     , enabled=true, func=@7, sind=7, desc="|^bow:shoots enemies. needs 2 power squares."},
      {name="force"   , enabled=true, func=@8, sind=36, desc="|^sqr'force:don't let ivan take it from you!"}
   ]], create_banjo, create_brang, create_shovel, create_shield, create_sword, create_bomb, create_bow, create_force)

   g_selected=G_INTERACT
end

function get_selected_item(ind)
   local item = g_items[ind or g_selected]
   return item.enabled and item or nil
end

function inventory_update()
   -- tbox logic
   local item = get_selected_item()

   if not g_tbox_active and not g_menu_open and btn"5" then
      g_selected = G_INTERACT
   end
   g_menu_open = not g_tbox_active and btn"5"

   if g_menu_open and not btn"5" then
      if not get_selected_item() then
         g_selected = G_INTERACT
      end
   end


   if g_menu_open then
      create_inventory_items()
      if g_pl.item then g_pl.item.holding = false end
   else
      destroy_inventory_items()
   end
end

function create_bomb(pl)
   return create_actor([[
      id="lank_bomb",
      att={
         rx=.375,
         ry=.375,
         sind=5,
         touchable=true,
         tl_loop=false,
         xf=@1
      },
      par={"bounded","confined","item","col","mov","knockable","spr"},
      tl={
         {i=@2, u=@5, tl_tim=.25},
         {i=@3, tl_tim=1.25},
         {d=@7, draw_spr=nf,draw_out=nf,i=@4, rx=1, ry=1, hit=@6, tl_tim=.25}
      }
      ]],
      pl.xf,
      function(a)
         a.x, a.y = pl.x+(pl.xf and -1 or 1), pl.y
         use_energy(5)
      end,
      function(a)
         if a == g_pl.item then
            g_pl.item = nil
         end
      end,
      function(a)
         a.rx, a.ry = .75, .75
         card_shake"8"
      end, pause_energy,
      function(a, other)
         if other.lank_bomb and other.cur < 3 then
            tl_next(other, 3)
         end

         if other.evil then
            change_cur_enemy(other)
         end
         
         if other.knockable then
            local ang = atan2(other.x-a.x, other.y-a.y)
            other.knockback(other, .5, cos(ang), sin(ang))
         end

         call_not_nil("hurt", other, 15, 30)
      end, function(a)
         scr_circfill(a.x, a.y, sin(a.tim/.25), 8)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tim/.25)*rnd(.25)+.25, 1)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tim/.25)*rnd(.25)+.25, 2)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tim/.25)*rnd(.25)+.25, 9)
         scr_circfill(a.x+rnd(2)-1, a.y+rnd(2)-1, sin(a.tim/.25)*rnd(.25)+.25, 10)
      end
   )
end

function create_brang(pl)
   return create_actor([[
      id="lank_brang",
      att={
         holding=true,
         rx=.375,
         ry=.375,
         sinds={4,260,516,772},
         anim_len=4,
         anim_spd=3,
         xf=@1,
         ix=.8,
         iy=.8,
         touchable=false
      },
      par={"item","anim","col","mov"},
      tl={
         {hit=@2, i=@3, u=@4, tl_tim=.125},
         {hit=@2, i=nf, u=@6, tl_tim=.5},
         {hit=@2, i=nf, u=@5}
      }
      ]],
      pl.xf,
      -- hit
      function(a, other)
         if other.evil then
            change_cur_enemy(other)
         end
         if other.pl then
            if a.cur != 1 then
               a.alive = false
            end
         elseif other.touchable then
            if other.knockable then
               other.knockback(other, .05, a.xf and -1 or 1, 0)
            end

            card_shake(9)
            if a.cur < 3 then
               tl_next(a)
            end
         end
      end,
      -- init 1
      function(a)
         a.x, a.y = pl.x, pl.y
         a.ax = a.xf and -.1 or .1
         use_energy(10)
      end,
      -- update 1
      function(a)
         a.ay = ybtn()*.05
         pause_energy()
      end,
      -- update 2
      function(a)
         pause_energy()
         amov_to_actor(a, pl, .1)
      end, 
      -- update 3
      function(a)
         pause_energy()
         a.ax = xbtn()*.05
         a.ay = ybtn()*.05
         if not a.holding then
            return true
         end
         -- amov_to_actor(a, pl, .1)
      end
      )
end

function create_banjo(pl)
   return create_actor([[
      id="lank_banjo",
      att={
         holding=true,
         rx=.3,
         ry=.3,
         sind=1,
         xf=@1,
         touchable=false,
         i=@2, u=@3
      },
      par={"item","rel","col"}
      ]],
      pl.xf,
      -- init 1
      function(a) 
         -- a.rel_x=a.xf and 2/8 or -2/8
         a.rel_y=0
      end,
      -- update 1
      function(a)
         if not a.holding then
            a.alive, pl.item = false
         end
      end
   )
end

function create_shovel(pl)
   return create_actor([[
      id="lank_shovel",
      att={
         holding=true,
         rx=.3,
         ry=.3,
         sind=3,
         xf=@1,
         touchable=false,
         i=@2, u=@3
      },
      par={"item","rel"}
      ]],
      not pl.xf,
      -- init 1
      function(a) 
         a.rel_x=a.xf and 5/8 or -5/8
         a.rel_y=0
      end,
      -- update 1
      function(a)
         local val = mget(a.x,a.y)
         if val == 58 or val == 59 or val == 60 or val == 76 or val == 77 then
            mset(a.x, a.y, 73)
         end

         if not a.holding then
            a.alive, pl.item = false
         end
      end
   )
end

-- teleports to different places
function create_force(pl)
   return create_actor([[
      id="lank_force",
      att={
         holding=true,
         rx=.3,
         ry=.3,
         sind=36,
         xf=@1,
         destroyed=@2,
         u=@3,
         touchable=false
      },
      par={"item","rel"}
      ]], pl.xf, function(a)
         -- random room index
         local i = flr(rnd(5))+1
         transition_room(g_save_spots[i].room, g_save_spots[i].x, g_save_spots[i].y)
      end, function(a)
         if not a.holding then
            a.alive = false
         end
      end
   )
end

function create_bow(pl)
   return create_actor([[
      id="lank_bow",
      att={
         holding=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-1,
         sind=7,
         xf=@1,
         destroyed=@5,
         touchable=false
      },
      par={"item","rel"},
      tl={
         {i=@2, u=@3, tl_tim=.4},
         {i=nf, u=@4}
      }
      ]],
      pl.xf,
      -- init 1
      function(a)
         a.rel_dx = a.xf and -.125 or .125
         a.ixx = a.xf and -1 or 1
         a.poke = 20
         use_energy(5)
      end,
      -- update 1
      function(a)
         act_poke(a, -1, 0)
         local dist = 3/8
         if abs(a.rel_dx + a.rel_x) < dist then
            a.rel_x += a.rel_dx
         else
            local neg_one = -dist
            a.rel_dx, a.rel_x = 0, a.xf and neg_one or dist
         end
         pause_energy()
      end,
      -- update 2
      function(a)
         act_poke(a, -1, 0)
         if not a.holding then
            a.alive, pl.item = false
         end
         pause_energy()
      end, function(a)
         if remove_money(1) then
            sfx"6"
            g_att.arrow(a.x, a.y, a.xf)
         end
      end
   )
end

-- sword and shield
function sword_shield_hit(a, o)
   if o.evil then
      a.poke = a.poke_val
      if a.cur != 1 then
         use_energy(a.energy)
      end
      change_cur_enemy(o)


      call_not_nil("hurt", o, (a.cur == 1) and (a.o_hurt*2) or a.o_hurt, 30)
   end

   if o.knockable and not o.pl then
      o.knockback(o, (a.cur == 1) and (a.o_knock*2) or a.o_knock, a.xf and -1 or 1, 0)
      g_pl.knockback(g_pl, a.pl_knock, a.xf and 1 or -1, 0)
   end
end

function sword_shield_u1(a)
   act_poke(a, a.poke_beg, a.poke_end)
   if abs(a.rel_dx + a.rel_x) < a.dist then
      a.rel_x += a.rel_dx
   else
      a.rel_dx, a.rel_x = 0, a.xf and -a.dist or a.dist
   end
   pause_energy()
end

function sword_shield_i1(a, energy, number, xfspeed)
   a.rel_dx = a.xf and -xfspeed or xfspeed
   a.ixx = a.xf and -number or number
   use_energy(energy)
end

function sword_shield_u2(a)
   act_poke(a, a.poke_beg, a.poke_end)
   if not a.holding then
      a.alive, g_pl.item = false
   end
   pause_energy()
end

function create_sword(pl)
   return create_actor([[
      id="lank_sword",
      att={
         max_stun_val=20,
         min_stun_val=10,
         energy=10,
         poke_val=10,
         pl_knock=.3,
         o_knock=.1,
         o_hurt=5,
         poke_beg=-1,
         poke_end=0,
         dist=1,
         holding=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=2,
         poke=20,
         xf=@1,
         touchable=false
      },
      par={"item","rel","col"},
      tl={
         {hit=@2, i=@3, u=@4, tl_tim=.4},
         {hit=@2, i=nf, u=@5}
      }
      ]],
      pl.xf, sword_shield_hit,
      function(a)
         sword_shield_i1(a, 20, 1, .125)
      end, sword_shield_u1, sword_shield_u2
   )
end

function create_shield(pl)
   return create_actor([[
      id="lank_shield",
      att={
         max_stun_val=60,
         min_stun_val=0,
         energy=2,
         poke_val=10,
         pl_knock=.1,
         o_knock=.2,
         o_hurt=0,
         poke_beg=0,
         poke_end=1,
         dist=.625,
         block=true,
         holding=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         poke=20,
         sind=6,
         xf=@1,
         poke=20,
         touchable=false
      },
      par={"item","rel","col"},
      tl={
         {hit=@2, i=@3, u=@4, tl_tim=.4},
         {hit=@2, i=nf, u=@5}
      }
   ]],
      pl.xf, sword_shield_hit,
      function(a) 
         sword_shield_i1(a, 10, 3, .625/10)
      end, sword_shield_u1, sword_shield_u2
   )
end


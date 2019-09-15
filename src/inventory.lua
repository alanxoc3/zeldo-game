G_INTERACT = 5

function act_poke(a, ix1, ix2)
   if a.poke > 0 then
      a.poke -= 1
      a.ixx = a.xf and ix1 or -ix1
   else
      a.ixx = a.xf and ix2 or -ix2
   end
end

function inventory_init()
   -- global_items
   g_items = gun_vals([[
      {name="banjo"   , enabled=true, func=@1, sind=08, desc="|^banjo:play a sick tune!"},
      {name="brang"   , enabled=true, func=@2, sind=12, desc="|^brang:stun baddies. get items."},
      {name="shovel"  , enabled=true, func=@3, sind=11, desc="|^shovel:dig things up. kill the grass."},
      {name="shield"  , enabled=true, func=@4, sind=14, desc="|^shield:be safe from enemy attacks."},
      {name="interact", enabled=true, func=nf, sind=43, desc="|^interact:talk to people, pick up things, read signs."},
      {name="sword"   , enabled=true, func=@5, sind=09, desc="|^sword:hurts bad guys."},
      {name="bomb"    , enabled=true, func=@6, sind=13, desc="|^bomb:only 5 power squares to blows things up!"},
      {name="bow"     , enabled=true, func=@7, sind=15, desc="|^bow:shoots enemies. needs 2 power squares."},
      {name="force"   , enabled=true, func=@8, sind=10, desc="|^sqr'force:don't let ivan take it from you!"}
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

   if not g_menu_open and btn(5) then
      g_selected = G_INTERACT 
      tbox_stash_push()
      tbox(g_items[g_selected].desc)
   end

   if g_menu_open and not btn(5) then
      tbox_stash_pop()
   end

   g_menu_open  = btn(5)

   if g_menu_open then
      if g_pl.item then g_pl.item.holding = false end

      -- from index to coordinate
      local x, y = (g_selected-1)%3, flr((g_selected-1)/3)

      if btnp(0) then x -= 1 end
      if btnp(1) then x += 1 end
      if btnp(2) then y -= 1 end
      if btnp(3) then y += 1 end

      -- only allow movement within bounds.
      x, y = max(0,min(x,2)), max(0,min(y,2))

      -- from coordinate to index
      local next_selected = y*3+x+1

      if g_selected != next_selected then
         tbox_clear()

         if get_selected_item(next_selected) then
            tbox(get_selected_item(next_selected).desc)
         else
            tbox("|^nothing:no item selected")
         end
      end

      g_selected = next_selected
   end
end


function draw_inv_box(x, y, sind, inactive)
   camera(-x,-y)

   local pattern, color = patternize(0x9a, 1), 9
   if inactive then
      pattern, color = patternize(0xd6, 2), 13
   end

   batch_call(rectfill, [[
      {-7,-7,6,6,1},
      {-6,-6,5,5,@1},
      {-5,-5,4,4,@2}
   ]], color, pattern)
   fillp()

   if inactive then
      for i=1,15 do pal(i, g_pal_gray[i]) end
   end

   spr_out(sind, -4, -4, 1, 1, false, false, 1)
   spr(sind, -4, -4)
   pal()

   camera()
end

function inventory_draw(x, y)
   local select_x, select_y = 0, 0

   for ind=1,9 do 
      local item = get_selected_item(ind)
      local item_x, item_y = (ind-1)%3, flr((ind-1)/3)
      local lx, ly = (x - 16 + item_x * 16), (y - 16 + item_y * 16)

      if ind == g_selected then
         select_x = lx-4
         select_y = ly-4
      end

      if item then
         draw_inv_box(lx,ly,item.sind, ind != g_selected)
      else
         rectfill(lx-1,ly-1,lx,ly, 1)
      end
   end

   local spr_ind = (t()*60 % 60 > 40) and 38 or 39
   local rel_spr = function(x1, y1, ...) spr(spr_ind, select_x+x1, select_y+y1, ...) end
   batch_call(rel_spr, "{-5,-5,1,1,false,false}, {5,-5,1,1,true,false}, {5,5,1,1,true,true}, {-5,5,1,1,false,true}")
end

function create_bomb(pl)
   return create_actor([[
      id="lank_bomb",
      att={
         holding=true,
         rx=.375,
         ry=.375,
         sind=13,
         xf=@1
      },
      par={"item","col","mov"},
      tl={
         {i=@2, u=@3}
      }
      ]],
      pl.xf,
      -- init
      function(a)
         a.x, a.y = pl.x, pl.y
      end,
      -- update
      function(a)
         if btnp(1) then
            a.alive = false
         end
      end)
end

function create_brang(pl)
   return create_actor([[
      id="lank_brang",
      att={
         holding=true,
         rx=.375,
         ry=.375,
         sinds={12,68,69,70},
         anim_len=4,
         anim_spd=10,
         xf=@1,
         touchable=false
      },
      par={"item","anim","col","mov"},
      tl={
         {hit=@2, i=@3, u=@4, tl_tim=.25},
         {hit=@2, i=@5, u=@6}
      }
      ]],
      pl.xf,
      -- hit
      function(a, other)
         if other.evil then
            if other.knockable then
               other.knockback(other, .05, a.xf and -1 or 1, 0)
            end

            if other.stunnable then
               other.stun(other, 60)
            end
            if a.cur == 1 then
               tl_next(a, 2)
            end
         elseif other.pl then
            if a.cur == 2 then
               a.alive = false
               pl.item = false
            end
         end
      end,
      -- init 1
      function(a)
         a.x, a.y = pl.x, pl.y
         a.ax = a.xf and -.07 or .07
         use_energy(10)
      end,
      -- update 1
      function(a)
         pause_energy()
         if g_energy_tired or not a.holding then
            return true
         end
      end,
      -- init 2
      function(a)
      end,
      -- update 2
      function(a)
         pause_energy()
         amov_to_actor(a, pl, .07)
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
         sind=8,
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
         sind=11,
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
         if val >= 16 and val <= 20 then
            mset(a.x, a.y, 25)
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
         sind=10,
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
         sind=15,
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
            g_att.arrow(a.x, a.y, a.xf)
         end
      end
   )
end

-- sword and shield
function sword_shield_hit(a, o, a_knock, o_knock, o_stun, o_hurt, poke, energy)
   if o.evil then
      a.poke = poke
      if a.cur != 1 then
         use_energy(energy)
      end
      change_cur_enemy(o)

      if o.knockable then
         o.knockback(o, o_knock, a.xf and -1 or 1, 0)
         g_pl.knockback(g_pl, a_knock, a.xf and 1 or -1, 0)
      end

      call_not_nil("stun", o, o_stun)
      call_not_nil("hurt", o, o_hurt)
   end
end

function create_sword(pl)
   return create_actor([[
      id="lank_sword",
      att={
         holding=true,
         rx=.5,
         ry=.375,
         rel_y=0,
         iyy=-2,
         sind=9,
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
      pl.xf,
      -- hit
      function(a, other)
         sword_shield_hit(a,other,.3, (a.cur == 1) and .3 or .1, 30, (a.cur == 1) and 10 or 5, 10, 10)
      end,
      -- init 1
      function(a)
         a.rel_dx = a.xf and -.125 or .125
         a.ixx = a.xf and -1 or 1
         use_energy(20)
      end,
      -- update 1
      function(a)
         act_poke(a, -1, 0)
         if abs(a.rel_dx + a.rel_x) < 1 then
            a.rel_x += a.rel_dx
         else
            local neg_one = -1
            a.rel_dx, a.rel_x = 0, a.xf and neg_one or 1
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
      end
   )
end

function create_shield(pl)
   local dist = .625
   return create_actor([[
      id="lank_shield",
      att={
         block=true,
         holding=true,
         rx=.25,
         ry=.5,
         iyy=-1,
         poke=20,
         sind=14,
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
      pl.xf,
      -- hit
      function(a, other)
         sword_shield_hit(a,other,.1, (a.cur == 1) and .4 or .2, a.cur == 1 and other.stunnable and 60 or 0, 0, 10, 5)
      end,
      -- init 1
      function(a) 
         a.rel_dx = a.xf and -dist/10 or dist/10
         a.ixx = a.xf and -3 or 3
         use_energy(10)
      end,
      -- update 1
      function(a)
         act_poke(a,  0, 1)
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
         act_poke(a,  0, 1)
         if not a.holding then
            a.alive, pl.item = false
         end
         pause_energy()
      end
   )
end


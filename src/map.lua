-- 5181
g_off_x, g_off_y = 0, 0
g_card_fade = 0
function draw_cur_room(x, y)
   fade(g_card_fade)
   local cur_room = g_rooms[g_cur_room]
   local rw = min(16, cur_room.w)
   local rh = min(12, cur_room.h)
   local rx = x - rw/2
   local ry = y - rh/2

   g_off_x = -(16-rw)/2+rx
   g_off_y = -(16-rh)/2+ry

   for k,v in pairs({5, 1, 1}) do
      rect(rx*8+k,ry*8+k, (rx+rw)*8-k-1, (ry+rh)*8-k-1, v)
   end

   clip(rx*8+4, ry*8+4, rw*8-8, rh*8-8)
   rectfill(0,0,127,127,cur_room.c)
   scr_map(cur_room.x, cur_room.y, cur_room.x, cur_room.y, cur_room.w, cur_room.h)
   isorty(g_act_arrs["ospr"])
   isorty(g_act_arrs["spr"])
   isorty(g_act_arrs["drawable"])
   acts_loop("ospr", "draw_out")
   acts_loop("spr", "draw_spr")
   -- acts_loop("drawable", "d")
   clip()
   fade(0)
end

function isorty(t)
    for n=2,#t do
        local i=n
        while i>1 and t[i].y<t[i-1].y do
            t[i],t[i-1]=t[i-1],t[i]
            i=i-1
        end
    end
end

function load_room(new_room, rx, ry)
   -- reload the map (remove shovel things).
   reload(0x1000, 0x1000, 0x2000)

   g_cur_room = new_room
   cur_room = g_rooms[g_cur_room]

   -- take care of actors.
   acts_loop("confined", "delete")
   if cur_room.i then cur_room.i() end

   local x, y, w, h = cur_room.x, cur_room.y, cur_room.w, cur_room.h

   g_pl.x = rx
   g_pl.y = ry

   load_view(x, y, w, h, 5, 11, 2, 2)
   center_view(g_pl.x, g_pl.y)
end

g_transition_x = 0
g_transition_y = 0
g_transitioning = false
function transition_room(new_room, rx, ry, dir)
   if not g_transitioning then
      g_transitioning = true
      g_transition_routine = cocreate(function()
         for i=0,20 do
            g_card_fade = i/20*10
            if dir == 'u' then
               g_transition_y = sin(i/80+.5)*10
            elseif dir == 'd' then
               g_transition_y = sin(i/80)*10
            elseif dir == 'l' then
               g_transition_x = sin(i/80+.5)*10
            elseif dir == 'r' then
               g_transition_x = sin(i/80)*10
            end
            yield()
         end
         load_room(new_room, rx, ry)
         yield()
         for i=20,0,-1 do
            g_card_fade = i/20*10
            if dir == 'u' then
               g_transition_y = sin(i/80)*10
            elseif dir == 'd' then
               g_transition_y = sin(i/80+.5)*10
            elseif dir == 'l' then
               g_transition_x = sin(i/80)*10
            elseif dir == 'r' then
               g_transition_x = sin(i/80+.5)*10
            end
            yield()
         end
         g_transitioning = false
      end)
   end
end

function room_update()
   local cur_room = g_rooms[g_cur_room]

   -- plus .5 and minus .375 is because there is a screen border.
   if g_transitioning then
      coresume(g_transition_routine)
   elseif cur_room then
      local dir = nil
      if g_pl.y > g_ry+g_rh-.375     then dir = 'd'
      elseif g_pl.y < g_ry + .5      then dir = 'u'
      elseif g_pl.x > g_rx+g_rw-.375 then dir = 'r'
      elseif g_pl.x < g_rx +.5       then dir = 'l'
      end

      if dir != nil and cur_room[dir] then
         transition_room(cur_room[dir][1], cur_room[dir][2], cur_room[dir][3], dir)
      end
   end
end

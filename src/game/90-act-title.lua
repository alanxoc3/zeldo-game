function spr_and_out(...)
   spr_out(...)
   zspr(...)
end

function title_draw(yoff)
   camera(-8*8, -7*8)
   -- (str, x, y, alignment, shadow_below)
   batch_call_new(tprint, [[@1, 0, !plus/-17/@2, 10, 4]], "that story about", yoff)

   for i=-2,2 do
      spr_and_out(226+i, i*10, cos(t()/2+i/4)/2+1+yoff, 1, 2, false, false, 1)
   end

   if ti(1,.5) and yoff == 0 then
      batch_call_new(tprint, [[@1, 0, 12, 7, 5]], "🅾️ or ❎ to play  ")
   end

   camera()
end

create_actor([[title;0;above_map_drawable,pos|
   d:@2;
   u=@1,;
]], function(a)
   if btnp'4' or btnp'5' then
      a.tl_next = true
      g_pl = _g.pl(a.x, a.y)
      g_left_ma_view = _g.view(2.75, 3, 0, g_pl) -- TODO: Deduplicate
      _g.title_move()
   end
end, function()
   title_draw(0)
end)

create_actor([[title_move;0;above_map_drawable,mov|
   d:@2;
   u=@1,tl_max_time=.5;
]], function(a)
   a.ay -= .1;
end, function(a)
   title_draw(a.y)
end)

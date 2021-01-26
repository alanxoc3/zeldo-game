function spr_and_out(...)
   spr_out(...)
   zspr(...)
end

create_actor([[title;0;loopable,above_map_drawable,pos|
   d:@2;
   tl_max_time=.5,;
   u=@1,;
]], function(a)
   if btnp'4' or btnp'5' then
      a:kill()
      g_pl = _g.pl(a.x, a.y)
      g_left_ma_view = _g.view(2.75, 3, 0, g_pl) -- TODO: Deduplicate
   end
end, function()
   camera(-8*8, -7*8)
   -- (str, x, y, alignment, shadow_below)
   batch_call_new(tprint, [[@1, 0, -17, 10, 4]], "that story about")

   for i=-2,2 do
      spr_and_out(226+i, i*10, sgn(cos(t()/2+i/4))/2+1, 1, 2, false, false, 1)
   end

   if ti(1,.5) then
      batch_call_new(tprint, [[@1, 0, 12, 7, 5]], "🅾️ or ❎ to play  ")
   end

   camera()
end)

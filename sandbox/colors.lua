function fade(i)
 for c=0,15 do
  if flr(i+1)>=8 then
   pal(c,0)
  else
   pal(c,fadetable[c+1][flr(i+1)])
  end
 end
end

function _init()
fadetable=gun_vals([[
 {0,0,0,0,0,0,0},
 {1,1,1,0,0,0,0},
 {2,2,2,1,0,0,0},
 {3,3,3,1,0,0,0},
 {4,2,2,2,1,0,0},
 {5,5,1,1,1,0,0},
 {6,13,13,5,5,1,0},
 {6,6,13,13,5,1,0},
 {8,8,2,2,2,0,0},
 {9,4,4,4,5,0,0},
 {10,9,4,4,5,5,0},
 {11,3,3,3,3,0,0},
 {12,12,3,1,1,1,0},
 {13,5,5,1,1,1,0},
 {14,13,4,2,2,1,0},
 {15,13,13,5,5,1,0}
]])
end

function _update60()
end

function _draw()
   cls()
   fade(t()*8)

   for i=0,15 do
      local x,y=i%4*32, flr(i/4)*32
      rectfill(x, y, x+31, y+31, i)
   end
   print("hello", 0, 0, 7)
end

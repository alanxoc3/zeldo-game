g_room_template = ztable[[
0:x=0 , y=0 , w=12, h=10 ; -- 0
    x=12, y=0 , w=12, h=10 ; -- 1
    x=0 , y=10, w=12, h=10 ; -- 2
    x=12, y=10, w=12, h=10 ; -- 3
    x=0 , y=20, w=12, h=12 ; -- 4
    x=12, y=20, w=12, h=12 ; -- 5
    x=24, y=0 , w=8 , h=8  ; -- 6
    x=24, y=8 , w=8 , h=8  ; -- 7
    x=24, y=16, w=8 , h=8  ; -- 8
    x=24, y=24, w=8 , h=8  ; -- 9
]]

function map_init()
   for k, v in pairs(g_rooms) do
      local qx, qy = flr(k/10 % 4), flr(k/40)
      local template = g_room_template[k%10]

      v.x,v.y = template.x+qx*32, template.y+qy*32
      v.w, v.h = v.w or template.w, v.h or template.h

      v.i=function()
         batch_call_table(function(att_name, x, y, ...)
            _g[att_name](v.x+x+.5, v.y+y+.5, ...)
         end, v)

         acts_loop('act', 'room_init')
      end
   end
end

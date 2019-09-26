function map_init()
   g_rooms = gun_vals([[
      "village"={ c=3, qx=0, qy=0,
         x =0,   y =10,
         w =24,  h =10,
         l={"lank_front_yard",11,5},
         r={"field",.5,9},
         {"sign",5.5,14.5,"|sign:testing sign"}
      },
      "lank_front_yard"={ c=3, qx=0, qy=0,
         x =12,  y =0,
         w =12,  h =10,
         r={"village",.5,7}
      },
      "field"={ c=3, qx=1, qy=1,
         x =0,   y =20,
         w =24,  h =12,
         l={"village",23,7}
      }
   ]])

   for k, v in pairs(g_rooms) do
      v.i=function()
         batch_call_table(function(att_name, ...) g_att[att_name](...) end, v)
      end
      v.x,v.y = v.x+v.qx*32, v.y+v.qy*32
   end
end

function map_init()
   g_room_template = gun_vals[[
      0#{ x=0 , y=0 , w=12, h=10 }, -- 0
      { x=12, y=0 , w=12, h=10 }, -- 1
      { x=0 , y=10, w=12, h=10 }, -- 2
      { x=12, y=10, w=12, h=10 }, -- 3
      { x=0 , y=20, w=12, h=12 }, -- 4
      { x=12, y=20, w=12, h=12 }, -- 5
      { x=24, y=0 , w=8 , h=8  }, -- 6
      { x=24, y=8 , w=8 , h=8  }, -- 7
      { x=24, y=16, w=8 , h=8  }, -- 8
      { x=24, y=24, w=8 , h=8  }  -- 9
   ]]

   g_rooms = gun_vals([[
      R_00#{ m=2, c=3, template=0,
         l={R_10,11.5,5},
         r={R_01,.5,5},
         d={R_17,4,.5},

         {'sign',5.5,2,{
            "⬅️ spike's forest",
            "➡️ hiroll village"
         },43},
         {'spikes',2,2,.5},
         {'spikes',2,7,.5},

         {'spikes',2,4,0}, {'spikes',2,5,0},
         {'spikes',3,4,0}, {'spikes',3,5,0}
      },
      R_01#{ m=14, c=3, template=1,
         l={R_00,11.5,5},
         r={R_02,.5,7},
         {'sign',9,2,{"lank's house"},43},
         {'navy_blocking',1,4.5},
         {'house',7.5,2,R_58,4,7.5,46}
      },
      R_02#{ m=14, c=3, template=2, w = 24,
         l={R_01,11.5,5},
         r={R_19,.5,5},
         {'sign',5,4,{"lime and navy's house"},43},
         {'sign',13,2,{"mayor lark's house"},43},
         {'sign',17,3,{"teach's studio"},43},
         {'sign',9,3,{"bob and jane's house"},43},
         {'sign',21,4,{"hi-roll shop"},43},
         {'house',3.5,4,R_09,4,7.5,46},
         {'house',15.5,3,R_06,4,7.5,46},
         {'house',11.5,2,R_57,4,7.5,46},
         {'house',7.5,3,R_08,4,7.5,46},
         {'house',19.5,4,R_07,4,7.5,46}
      },
      R_06#{ m=18, c=4, template=6,
         d={R_02,16,4},

         {'sign',1,1,{"press 🅾️ to use yer item."},43},
         {'sign',6,1,{"hold down ❎ to select","yer item."},43},
         {'teach',3.5,3.5}
      },
      R_07#{ m=18, c=4, template=7,
         d={R_02,20,5},

         {'shop_brang',2,3},
         {'shop_shield',5,3},

         {'keep',3.5,3}
      },
      R_08#{ m=18, c=4, template=8,
         d={R_02,8,4},
         {'jane',5,2}
      },
      R_09#{ m=18, c=4, template=9,
         d={R_02,4,5}
      },

      R_10#{ m=2, c=3, template=0,
         {'spikes',9,2,.5},
         {'spikes',2,7,0},

         {'spikes',5,3,0}, {'spikes',6,3,0},
         {'spikes',5,4,0}, {'spikes',6,4,0},
         {'spikes',5,5,.5}, {'spikes',6,5,.5},
         {'spikes',5,6,.5}, {'spikes',6,6,.5},

         r={R_00,.5,5},
         l={R_17,4,4},
         u={R_17,4,4},
         d={R_11,6,.5},
      },
      R_11#{ m=2, c=3, template=1,
         {'spikes',3,1,.5}, {'spikes',3,2,.5},
         {'spikes',4,1,.75}, {'spikes',4,2,.75},
         {'spikes',7,1,.5}, {'spikes',7,2,.5},
         {'spikes',8,1,.75}, {'spikes',8,2,.75},

         {'spikes',9,3,0}, {'spikes',10,3,0},
         {'spikes',9,6,0}, {'spikes',10,6,0},

         {'spikes',3,4,0}, {'spikes',3,5,0},
         {'spikes',4,4,0}, {'spikes',4,5,0},
         {'spikes',7,4,0}, {'spikes',7,5,0},
         {'spikes',8,4,0}, {'spikes',8,5,0},

         {'spikes',3,7,.75}, {'spikes',3,8,.75},
         {'spikes',4,7,.5}, {'spikes',4,8,.5},
         {'spikes',7,7,.75}, {'spikes',7,8,.75},
         {'spikes',8,7,.5}, {'spikes',8,8,.5},

         u={R_10,6,9.5},
         r={R_17,4,4},
         d={R_18,4,.5},
         l={R_12,11.5,5}
      },
      R_12#{ m=2, c=3, template=2,
         {'spikes',2,4,0}, {'spikes',3,4,0},
         {'spikes',2,5,0}, {'spikes',3,5,0},

         {'spikes',8,4,0}, {'spikes',9,4,0},
         {'spikes',8,5,0}, {'spikes',9,5,0},

         {'spikes',5,4,.5}, {'spikes',6,4,.5},
         {'spikes',5,5,.5}, {'spikes',6,5,.5},

         {'spikes',4,2,.25}, {'spikes',7,2,.5},

         {'spikes',4,7,.5}, {'spikes',7,7,.25},

         r={R_11,.5,5},
         l={R_17,4,4},
         d={R_17,4,4},
         u={R_13,6,9.5}
      },
      R_13#{ m=2, c=3, template=3,
         {'spikes',2,4,0}, {'spikes',3,4,0},
         {'spikes',2,5,0}, {'spikes',3,5,0},

         {'spikes',8,4,0}, {'spikes',9,4,0},
         {'spikes',8,5,0}, {'spikes',9,5,0},

         {'spikes',1,1,.5}, {'spikes',10,1,.5},
         {'spikes',1,8,.5}, {'spikes',10,8,.5},

         d={R_12,6,.5},
         u={R_14,6,11.5},
         l={R_17,4,4},
         r={R_17,4,4}
      },
      R_14#{ m=2, c=3, template=4,
         r={R_16,.5,4},
         d={R_13,6,.5}
      },
      R_16#{ m=2, c=3, template=6,
         l={R_14,11.5,6}
      },
      R_17#{ m=2, c=3, template=7,
         u={R_00,6,9.5},
         r={R_01,.5,5},

         {'sign',51,21,{"don't get lost!"},43}
      },
      R_18#{ m=2, c=3, template=8,
         u={R_11, 6, 9.5}
      },
      R_19#{ m=14, c=3, template=9,
         l={R_02,23.5,7},
         u={R_24,3,11.5},
         {'sign',1.5,1.5,{
            "⬆️ hiroll field",
            "⬅️ hiroll village"
         },43},
         {'bob_build',4.5,1.5}
      },

      R_21#{ m=2, c=6, template=1,
         d={R_26,4,.5}
      },
      R_22#{ m=2, c=4, template=2, w = 24,
         l={R_31,11.5,7},
         u={R_26,4,15.5}
      },
      R_24#{ m=2, c=3, template=4, w = 24,
         d={R_19,5,.5},
         r={R_33,.5,3}
      },
      R_26#{ m=2, c=4, template=6, h = 16,
         d={R_22,18,.5},
         u={R_21,6,9.5}
      },

      R_30#{ m=2, c=13, template=0,
         l={R_33,11.5,7},
         r={R_31,.5,7}
      },
      R_31#{ m=2, c=13, template=1,
         l={R_30,11.5,17},
         r={R_22,.5,7}
      },
      R_33#{ m=2, c=13, template=3,
         l={R_24,23.5,3},
         r={R_30,.5,17}
      },

      R_58#{ m=18, c=4, template=8,
         d={R_01,8,3}
         -- {'pot',57,49,POT_00},
         -- {'pot',62,49,POT_01},
         -- {'pot',57,54,POT_02},
         -- {'chest',62,54,true,HAS_BANJO},
         -- {'save_spot',59.5,51.5}
      },
      R_57#{ m=18, c=4, template=7,
         d={R_02,12,3},

         {'lark',3.5,3.5}
      }
   ]])

   for k, v in pairs(g_rooms) do
      local qx, qy = flr(k/10 % 4), flr(k/40)
      local template = g_room_template[k%10]

      v.x,v.y = template.x+qx*32, template.y+qy*32
      v.w, v.h = v.w or template.w, v.h or template.h

      v.i=function()
         batch_call_table(function(att_name, x, y, ...)
            g_att[att_name](v.x+x+.5, v.y+y+.5, ...)
         end, v)

         acts_loop('act', 'room_init')
      end
   end
end

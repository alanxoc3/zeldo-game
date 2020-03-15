function map_init()
   g_rooms = gun_vals([[
      -- VILLAGE_PATH
      { m=14, c=3, qx=1, qy=0,
         x = 24,  y = 24,
         w = 8,   h = 8,
         l={VILLAGE,23.5,7},
         u={FIELD,3,11.5},
         {'sign',57.5, 25.5,{
            "⬆️ hiroll field",
            "⬅️ hiroll village"
         },43},
         {'bob_build',60.5,25.5}
      },
      -- LANK_HOUSE
      { m=18, c=4, qx=1, qy=1,
         x = 24,  y = 16,
         w = 8,   h = 8,
         d={LANK_FRONT_YARD,8,3},
         {'pot',57,49,POT_00},
         {'pot',62,49,POT_01},
         {'pot',57,54,POT_02},
         {'chest',62,54,true,HAS_BANJO},
         {'save_spot',59.5,51.5}
      },
      -- MAYOR_HOUSE
      { m=18, c=4, qx=1, qy=1,
         x = 24,   y = 8,
         w = 8,  h = 8,
         d={VILLAGE,12,3},
         {'pot',57,46,POT_03},
         {'pot',57,45,POT_04},
         {'pot',58,46,POT_05},

         {'pot',62,46,POT_08},
         {'pot',62,45,POT_06},
         {'pot',61,46,POT_07},

         {'pot',58,41,POT_29},
         {'pot',59,41,POT_09},
         {'pot',60,41,POT_10},
         {'pot',61,41,POT_13},

         {'pot',57,43,POT_11},
         {'pot',62,43,POT_12},
         {'lark',59.5,43.5}
      },
      -- TEACH_STUDIO
      { m=18, c=4, qx=0, qy=0,
         x = 24,  y = 0,
         w = 8,   h = 8,
         d={VILLAGE,16,4},
         {'pot',25,6,POT_14},
         {'pot',30,6,POT_15},
         {'sign',25,1,{"press 🅾️ to use yer item."},43},
         {'sign',30,1,{"hold down ❎ to select","yer item."},43},
         {'teach',26,3.5}
      },
      -- SHOP
      { m=18, c=4, qx=0, qy=0,
         x = 24,  y = 8,
         w = 8,   h = 8,
         d={VILLAGE,20,5},
         {'box',26,13},
         {'box',25,14},
         {'box',25,12},
         {'box',25,10},

         {'box',29,13},
         {'box',30,14},
         {'box',30,12},
         {'box',30,10},

         {'box',28,10},
         {'box',29,11},

         {'pot',25,13,POT_16},
         {'pot',29,14,POT_17},

         {'shop_brang',26,11},
         {'shop_shield',28,11},
         {'chest',26,9,true,HAS_BOW},
         {'chest',29,9,false,HAS_BOW},
         {'keep',27,10}
      },
      -- JANEBOB
      { m=18, c=4, qx=0, qy=0,
         x = 24,  y = 16,
         w = 8,   h = 8,
         d={VILLAGE,8,4},
         {'jane',29,18.5},
         {'pot',25,22,POT_18},
         {'pot',30,22,POT_19},
         {'pot',26,17,POT_20}
      },
      -- LIMENAVY
      { m=18, c=4, qx=0, qy=0,
         x = 24,  y = 24,
         w = 8,   h = 8,
         d={VILLAGE,4,5},
         {'pot',25,25,POT_21},
         {'pot',30,25,POT_22},
         {'pot',25,29,POT_23},
         {'pot',25,30,POT_24},
         {'pot',26,30,POT_25},
         {'pot',30,29,POT_26},
         {'pot',30,30,POT_27},
         {'pot',29,30,POT_28}
      },
      -- VILLAGE
      { m=14, c=3, qx=0, qy=0,
         x = 0,   y = 10,
         w = 24,  h = 10,
         l={LANK_FRONT_YARD,11.5,5},
         r={VILLAGE_PATH,.5,5},
         {'sign',5,14,{"lime and navy's house"},43},
         {'sign',13,12,{"mayor lark's house"},43},
         {'sign',17,13,{"teach's studio"},43},
         {'sign',9,13,{"bob and jane's house"},43},
         {'sign',21,14,{"hi-roll shop"},43},
         {'house',3.5,14,LIMENAVY,4,7.5,46},
         {'house',15.5,13,TEACH_STUDIO,4,7.5,46},
         {'house',11.5,12,MAYOR_HOUSE,4,7.5,46},
         {'house',7.5,13,JANEBOB,4,7.5,46},
         {'house',19.5,14,SHOP,4,7.5,46}
      },
      -- LANK_FRONT_YARD
      { m=14, c=3, qx=0, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         l={FOREST_ENTRANCE,11.5,5},
         r={VILLAGE,.5,7},
         {'sign',21,2,{"lank's house"},43},
         {'navy_blocking',13,4.5},
         {'house',19.5,2,LANK_HOUSE,4,7.5,46}
      },
      -- FIELD
      { m=2, c=3, qx=2, qy=0,
         x = 0,   y = 20,
         w = 24,  h = 12,
         d={VILLAGE_PATH,5,.5},
         r={GRAVEYARD_ENTRANCE,.5,3}
      },
      -- GRAVEYARD_ENTRANCE
      { m=2, c=13, qx=3, qy=0,
         x = 12,  y = 10,
         w = 12,  h = 10,
         l={FIELD,23.5,3},
         r={GRAVEYARD,.5,17}
      },
      -- GRAVEYARD
      { m=2, c=13, qx=3, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 20,
         l={GRAVEYARD_ENTRANCE,11.5,7},
         r={GRAVEYARD_END,.5,7}
      },
      -- GRAVEYARD_END
      { m=2, c=13, qx=3, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         l={GRAVEYARD,11.5,17},
         r={CANYON_START,.5,7}
      },
      -- CANYON_START
      { m=2, c=4, qx=2, qy=0,
         x = 0,   y = 10,
         w = 24,  h = 10,
         l={GRAVEYARD_END,11.5,7},
         u={CANYON_PATH,4,15.5}
      },
      -- CANYON_PATH
      { m=2, c=4, qx=2, qy=0,
         x = 24,   y = 0,
         w = 8,    h = 16,
         d={CANYON_START,18,.5},
         u={CANYON_END,6,9.5}
      },
      -- CANYON_END
      { m=2, c=6, qx=2, qy=0,
         x = 12,   y = 0,
         w = 12,   h = 10,
         d={CANYON_PATH,4,.5}
      },
      -- FOREST_ENTRANCE
      { m=2, c=3, qx=0, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 10,
         l={FOREST_1,11.5,5},
         r={LANK_FRONT_YARD,.5,5},
         d={FOREST_LOST,4,.5},

         {'sign',5.5,2,{
            "⬅️ spike's forest",
            "➡️ hiroll village"
         },43},
         {'spikes',2,2,.5},
         {'spikes',2,7,.5},

         {'spikes',2,4,0}, {'spikes',2,5,0},
         {'spikes',3,4,0}, {'spikes',3,5,0}
      },
      -- FOREST_LOST
      { m=2, c=3, qx=1, qy=0,
         x = 24,  y = 8,
         w = 8,  h = 8,
         u={FOREST_ENTRANCE,6,9.5},
         r={LANK_FRONT_YARD,.5,5},

         {'sign',51,21,{"don't get lost!"},43}
      },
      -- FOREST_1
      { m=2, c=3, qx=1, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 10,

         {'spikes',41,2,.5},
         {'spikes',34,7,0},

         {'spikes',37,3,0}, {'spikes',38,3,0},
         {'spikes',37,4,0}, {'spikes',38,4,0},
         {'spikes',37,5,.5}, {'spikes',38,5,.5},
         {'spikes',37,6,.5}, {'spikes',38,6,.5},

         r={FOREST_ENTRANCE,.5,5},
         l={FOREST_LOST,4,4},
         u={FOREST_LOST,4,4},
         d={FOREST_2,6,.5},
      },
      -- FOREST_2
      { m=2, c=3, qx=1, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,

         {'spikes',47,1,.5}, {'spikes',47,2,.5},
         {'spikes',48,1,.75}, {'spikes',48,2,.75},
         {'spikes',51,1,.5}, {'spikes',51,2,.5},
         {'spikes',52,1,.75}, {'spikes',52,2,.75},

         {'spikes',53,3,0}, {'spikes',54,3,0},
         {'spikes',53,6,0}, {'spikes',54,6,0},

         {'spikes',47,4,0}, {'spikes',47,5,0},
         {'spikes',48,4,0}, {'spikes',48,5,0},
         {'spikes',51,4,0}, {'spikes',51,5,0},
         {'spikes',52,4,0}, {'spikes',52,5,0},

         {'spikes',47,7,.75}, {'spikes',47,8,.75},
         {'spikes',48,7,.5}, {'spikes',48,8,.5},
         {'spikes',51,7,.75}, {'spikes',51,8,.75},
         {'spikes',52,7,.5}, {'spikes',52,8,.5},

         u={FOREST_1,6,9.5},
         r={FOREST_LOST,4,4},
         d={FOREST_SECRET,4,.5},
         l={FOREST_3,11.5,5}
      },

      -- FOREST_3
      { m=2, c=3, qx=1, qy=0,
         x = 0,   y = 10,
         w = 12,  h = 10,

         {'spikes',34,14,0}, {'spikes',35,14,0},
         {'spikes',34,15,0}, {'spikes',35,15,0},

         {'spikes',40,14,0}, {'spikes',41,14,0},
         {'spikes',40,15,0}, {'spikes',41,15,0},

         {'spikes',37,14,.5}, {'spikes',38,14,.5},
         {'spikes',37,15,.5}, {'spikes',38,15,.5},

         {'spikes',36,12,.25}, {'spikes',39,12,.5},

         {'spikes',36,17,.5}, {'spikes',39,17,.25},

         r={FOREST_2,.5,5},
         l={FOREST_LOST,4,4},
         d={FOREST_LOST,4,4},
         u={FOREST_4,6,9.5}
      },
      -- FOREST_4
      { m=2, c=3, qx=1, qy=0,
         x = 12,  y = 10,
         w = 12,  h = 10,

         {'spikes',46,14,0}, {'spikes',47,14,0},
         {'spikes',46,15,0}, {'spikes',47,15,0},

         {'spikes',52,14,0}, {'spikes',53,14,0},
         {'spikes',52,15,0}, {'spikes',53,15,0},

         {'spikes',45,11,.5}, {'spikes',54,11,.5},
         {'spikes',45,18,.5}, {'spikes',54,18,.5},

         d={FOREST_3,6,.5},
         u={FOREST_BOSS,6,11.5},
         l={FOREST_LOST,4,4},
         r={FOREST_LOST,4,4}
      },
      -- FOREST_BOSS
      { m=2, c=3, qx=1, qy=0,
         x = 0,   y = 20,
         w = 12,  h = 12,
         r={FOREST_TREASURE,.5,4},
         d={FOREST_4,6,.5}
      },
      -- FOREST_TREASURE
      { m=2, c=3, qx=1, qy=0,
         x = 24,  y = 0,
         w = 8,  h = 8,
         l={FOREST_BOSS,11.5,6}
      },
      -- FOREST_SECRET
      { m=2, c=3, qx=1, qy=0,
         x = 24,  y = 16,
         w = 8,  h = 8,
         u={FOREST_2, 6, 9.5}
      }
   ]])

   for k, v in pairs(g_rooms) do
      v.i=function()
         batch_call_table(function(att_name, x, y, ...)
               g_att[att_name](x+.5,y+.5,...)
         end, v)

         acts_loop('act', 'room_init')
      end
      v.x,v.y = v.x+v.qx*32, v.y+v.qy*32
   end
end

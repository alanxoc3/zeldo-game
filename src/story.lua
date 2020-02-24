function map_init()
   g_rooms = gun_vals([[
      -- VILLAGE_PATH
      { m=0, c=3, qx=1, qy=0,
         x = 24,  y = 24,
         w = 8,   h = 8,
         l={VILLAGE,23.5,7},
         u={FIELD,3,11.5},
         {'sign',58, 26,{
            "'⬆️ hiroll field'",
            "'⬅️ hiroll village'"
         },43},
         {'bob_build',61,26}
      },
      -- LANK_HOUSE
      { m=0, c=4, qx=1, qy=1,
         x = 24,  y = 16,
         w = 8,   h = 8,
         d={LANK_FRONT_YARD,8,3},
         {'chest',61.5,52,true,HAS_BANJO},
         {'pot',57.5,49.5,49},
         {'pot',62.5,49.5,49},
         {'pot',57.5,54.5,49},
         {'pot',62.5,54.5,49},
         {'save_platform',59,52,0}
      },
      -- MAYOR_HOUSE
      { m=0, c=4, qx=2, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 10,
         d={VILLAGE,12,3},
         {'pot',65.5,6.5,49},
         {'pot',65.5,7.5,49}, {'pot',66.5,7.5,49},
         {'pot',66.5,8.5,49}, {'pot',67.5,8.5,49},
         {'pot',65.5,8.5,49},

         {'pot',74.5,6.5,49},
         {'pot',74.5,7.5,49}, {'pot',73.5,7.5,49},
         {'pot',73.5,8.5,49}, {'pot',72.5,8.5,49},
         {'pot',74.5,8.5,49},
         {'lark',70,2}
      },
      -- TEACH_STUDIO
      { m=0, c=4, qx=0, qy=0,
         x = 24,  y = 0,
         w = 8,   h = 8,
         d={VILLAGE,16,4},
         {'pot',25.5,6.5,49},
         {'pot',30.5,6.5,49},
         {'sign',25.5,1.5,{"'press 🅾️ to use yer item.'"},43},
         {'sign',30.5,1.5,{"'hold down ❎ to select'","'yer item.'"},43},
         {'teach',26.5,4}
      },
      -- SHOP
      { m=0, c=4, qx=0, qy=0,
         x = 24,  y = 8,
         w = 8,   h = 8,
         d={VILLAGE,20,5},
         {'pot',25.5,14.5,49},
         {'pot',30.5,14.5,49},
         {'shop_brang',26.5,11.5},
         {'shop_shield',29.5,11.5},
         {'keep',28,10.5}
      },
      -- JANEBOB
      { m=0, c=4, qx=0, qy=0,
         x = 24,  y = 16,
         w = 8,   h = 8,
         d={VILLAGE,8,4},
         {'jane',29.5,19},
         {'pot',25.5,22.5,49},
         {'pot',30.5,22.5,49},
         {'pot',26.5,17.5,48}
      },
      -- LIMENAVY
      { m=0, c=4, qx=0, qy=0,
         x = 24,  y = 24,
         w = 8,   h = 8,
         d={VILLAGE,4,5},
         {'pot',25.5,25.5,49},
         {'pot',30.5,25.5,49},
         {'pot',25.5,29.5,49}, {'pot',25.5,30.5,49}, {'pot',26.5,30.5,49},
         {'pot',30.5,29.5,49}, {'pot',30.5,30.5,49}, {'pot',29.5,30.5,49}
      },
      -- VILLAGE
      { m=0, c=3, qx=0, qy=0,
         x = 0,   y = 10,
         w = 24,  h = 10,
         l={LANK_FRONT_YARD,11.5,5},
         r={VILLAGE_PATH,.5,5},
         {'sign',5.5,14.5,{"'lime and navy's house'"},43},
         {'sign',13.5,12.5,{"'mayor lark's house'"},43},
         {'sign',17.5,13.5,{"'teach's studio'"},43},
         {'sign',9.5,13.5,{"'bob and jane's house'"},43},
         {'sign',21.5,14.5,{"'hi-roll shop'"},43},
         {'house',4,14.5,LIMENAVY,4,7.5,46},
         {'house',16,13.5,TEACH_STUDIO,4,7.5,46},
         {'house',12,12.5,MAYOR_HOUSE,6,9.5,46},
         {'house',8,13.5,JANEBOB,4,7.5,46},
         {'house',20,14.5,SHOP,4,7.5,46},
         {'top',20,16.5}
      },
      -- LANK_FRONT_YARD
      { m=0, c=3, qx=0, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         l={FOREST_ENTRANCE,11.5,5},
         r={VILLAGE,.5,7},
         {'sign',21.5,2.5,{"'lank's house'"},43},
         {'navy_blocking',13.5,5},
         {'house',20,2.5,LANK_HOUSE,4,7.5,46}
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
         r={GRAVEYARD,.5,17},
         {'sign',105.5,4.5,{"'here lies an old person (probably).'"},45}
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
         d={FOREST_LOST,6,.5}
      },
      -- FOREST_LOST
      { m=2, c=3, qx=1, qy=0,
         x = 12,  y = 20,
         w = 12,  h = 12,
         u={FOREST_ENTRANCE,6,9.5},
         r={LANK_FRONT_YARD,.5,5},

         {'sign',51.5,21.5,{"'don't get lost!'"},43}
      },
      -- FOREST_1
      { m=2, c=3, qx=1, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 10,
         r={FOREST_ENTRANCE,.5,5},
         l={FOREST_LOST,6,6},
         u={FOREST_LOST,6,6},
         d={FOREST_2,6,.5}
      },
      -- FOREST_2
      { m=2, c=3, qx=1, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         u={FOREST_1,6,9.5},
         r={FOREST_LOST,6,6},
         d={FOREST_LOST,6,6},
         l={FOREST_3,11.5,5}
      },
      -- FOREST_3
      { m=2, c=3, qx=1, qy=0,
         x = 0,   y = 10,
         w = 12,  h = 10,
         r={FOREST_2,.5,5},
         l={FOREST_LOST,6,6},
         d={FOREST_LOST,6,6},
         u={FOREST_4,6,9.5}
      },
      -- FOREST_4
      { m=2, c=3, qx=1, qy=0,
         x = 12,  y = 10,
         w = 12,  h = 10,
         d={FOREST_3,6,.5},
         u={FOREST_BOSS,6,11.5},
         l={FOREST_LOST,6,6},
         r={FOREST_LOST,6,6}
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
      -- TITLE_SCREEN
      { m=2, c=3, qx=0, qy=0,
         x = 0,  y = 20,
         w = 12, h = 12
      }
   ]])

   for k, v in pairs(g_rooms) do
      v.i=function()
         batch_call_table(function(att_name, ...)
               g_att[att_name](...)
         end, v)
      end
      v.x,v.y = v.x+v.qx*32, v.y+v.qy*32
   end
end

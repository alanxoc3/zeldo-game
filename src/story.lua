function map_init()
   g_rooms = gun_vals([[
      'village_path'={ c=3, qx=1, qy=0,
         x = 24,  y = 24,
         w = 8,   h = 8,
         l={'village',23.5,7},
         u={'field',3,11.5},
         {'sign',58.5, 26.5,{
            "⬆️ Hiroll Field",
            "⬅️ Hiroll Village"
         },52},
         {'npc',61,25.5,"Bob",{
            "Hey Lank, I'm hungry.",
            "",
            "I mean...",
            "",
            "I'm fixing the road."
         },80}
      },
      'lank_house'={ c=4, qx=1, qy=1,
         x = 24,  y = 16,
         w = 8,   h = 8,
         d={'lank_front_yard',8,3},
         {'pot',57.5,49.5,49},
         {'pot',62.5,49.5,49},
         {'pot',57.5,54.5,49},
         {'pot',62.5,54.5,49}
      },
      'mayor_house'={ c=4, qx=2, qy=0,
         x = 0,  y = 0,
         w = 12,   h = 10,
         d={'village',12,3},
         {'pot',65.5,6.5,49},
         {'pot',65.5,7.5,49}, {'pot',66.5,7.5,49},
         {'pot',66.5,8.5,49}, {'pot',67.5,8.5,49},
         {'pot',74.5,6.5,49},
         {'pot',74.5,7.5,49}, {'pot',73.5,7.5,49},
         {'pot',73.5,8.5,49}, {'pot',72.5,8.5,49},
         {'chest',74.5,8.5},
         {'npc',70,2,"Mayor Lark",{
            "Hey there Lank, I'm your",
            "biggest fan!"
         },99}
      },
      'teach_studio'={ c=4, qx=0, qy=0,
         x = 24,  y = 0,
         w = 8,   h = 8,
         d={'village',8,4},
         {'pot',25.5,6.5,49},
         {'pot',30.5,6.5,49},
         {'sign',25.5,1.5,{"Press 🅾️ to use yer item."},52},
         {'sign',30.5,1.5,{"Hold down ❎ to select","yer item."},52},
         {'npc',26.5,4,"Teach",{
            "Hi Lank, have you been",
            "practicing the banjo?"
         },96}
      },
      'shop'={ c=4, qx=0, qy=0,
         x = 24,  y = 8,
         w = 8,   h = 8,
         d={'village',20,5},
         {'pot',25.5,14.5,49},
         {'pot',30.5,14.5,49},
         {'npc',28,10.5,"Keep",{
            "Buy something will ya?"
         },83}
      },
      'janebob'={ c=4, qx=0, qy=0,
         x = 24,  y = 16,
         w = 8,   h = 8,
         d={'village',16,4},
         {'npc',29.5,19,"Navy",{
            "My husband always works",
            "so hard.",
            "What should I make him",
            "for dinner?"
         },81},
         {'pot',25.5,22.5,49},
         {'pot',30.5,22.5,49},
         {'pot',26.5,17.5,48}
      },
      'limenavy'={ c=4, qx=0, qy=0,
         x = 24,  y = 24,
         w = 8,   h = 8,
         d={'village',4,5},
         {'npc',29.5,26.5,"Navy",{
            "Have you seen Lime?",
            "",
            "I last saw her in the","forest."
         },97},
         {'pot',25.5,29.5,49}, {'pot',25.5,30.5,49}, {'pot',26.5,30.5,49},
         {'pot',30.5,29.5,49}, {'pot',30.5,30.5,49}, {'pot',29.5,30.5,49}
      },
      'village'={ c=3, qx=0, qy=0,
         x = 0,   y = 10,
         w = 24,  h = 10,
         l={'lank_front_yard',11.5,5},
         r={'village_path',.5,5},
         {'sign',5.5,14.5,{"Lime And Navy's House"},43},
         {'sign',13.5,12.5,{"Mayor Lark's House"},43},
         {'sign',9.5,13.5,{"Teach's Studio"},43},
         {'sign',17.5,13.5,{"Bob And Jane's House"},43},
         {'sign',21.5,14.5,{"Hiroll Shop"},43},
         {'house',4,14.5,'limenavy',4,7.5},
         {'house',8,13.5,'teach_studio',4,7.5},
         {'house',12,12.5,'mayor_house',6,9.5},
         {'house',16,13.5,'janebob',4,7.5},
         {'house',20,14.5,'shop',4,7.5}
      },
      'lank_front_yard'={ c=3, qx=0, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         l={'forest_entrance',11.5,5},
         r={'village',.5,7},
         {'sign',21.5,2.5,{"Lank's House"},43},
         {'npc',13,5,"Teach",{
            "It's dangerous to go",
            "alone!",
            "Find something to protect",
            "yourself with."
         },96},
         {'house',20,2.5,'lank_house',4,7.5}
      },
      'field'={ c=3, qx=2, qy=0,
         x = 0,   y = 20,
         w = 24,  h = 12,
         d={'village_path',5,.5},
         r={'graveyard_entrance',.5,3}
      },
      'graveyard_entrance'={ c=13, qx=3, qy=0,
         x = 12,  y = 10,
         w = 12,  h = 10,
         l={'field',23.5,3},
         r={'graveyard',.5,17},
         {'sign',105.5,4.5,{"Here lies an old person (probably)."},45}
      },
      'graveyard'={ c=13, qx=3, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 20,
         l={'graveyard_entrance',11.5,7},
         r={'graveyard_end',.5,7}
      },
      'graveyard_end'={ c=13, qx=3, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         l={'graveyard',11.5,17},
         r={'canyon_start',.5,7}
      },
      'canyon_start'={ c=4, qx=2, qy=0,
         x = 0,   y = 10,
         w = 24,  h = 10,
         l={'graveyard_end',11.5,7},
         u={'canyon_path',4,15.5}
      },
      'canyon_path'={ c=4, qx=2, qy=0,
         x = 24,   y = 0,
         w = 8,    h = 16,
         d={'canyon_start',18,.5},
         u={'canyon_end',6,9.5}
      },
      'canyon_end'={ c=6, qx=2, qy=0,
         x = 12,   y = 0,
         w = 12,   h = 10,
         d={'canyon_path',4,.5}
      },
      'forest_entrance'={ c=3, qx=0, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 10,
         l={'forest_1',11.5,5},
         r={'lank_front_yard',.5,5},
         d={'forest_lost',6,.5}
      },
      'forest_lost'={ c=3, qx=1, qy=0,
         x = 12,  y = 20,
         w = 12,  h = 12,
         u={'forest_entrance',6,9.5},
         r={'lank_front_yard',.5,5}
      },
      'forest_1'={ c=3, qx=1, qy=0,
         x = 0,   y = 0,
         w = 12,  h = 10,
         r={'forest_entrance',.5,5},
         l={'forest_lost',6,6},
         u={'forest_lost',6,6},
         d={'forest_2',6,.5}
      },
      'forest_2'={ c=3, qx=1, qy=0,
         x = 12,  y = 0,
         w = 12,  h = 10,
         u={'forest_1',6,9.5},
         r={'forest_lost',6,6},
         d={'forest_lost',6,6},
         l={'forest_3',11.5,5}
      },
      'forest_3'={ c=3, qx=1, qy=0,
         x = 0,   y = 10,
         w = 12,  h = 10,
         r={'forest_2',.5,5},
         l={'forest_lost',6,6},
         d={'forest_lost',6,6},
         u={'forest_4',6,9.5}
      },
      'forest_4'={ c=3, qx=1, qy=0,
         x = 12,  y = 10,
         w = 12,  h = 10,
         d={'forest_3',6,.5},
         u={'forest_boss',6,11.5},
         l={'forest_lost',6,6},
         r={'forest_lost',6,6}
      },
      'forest_boss'={ c=3, qx=1, qy=0,
         x = 0,   y = 20,
         w = 12,  h = 12,
         r={'forest_treasure',.5,4},
         d={'forest_4',6,.5}
      },
      'forest_treasure'={ c=3, qx=1, qy=0,
         x = 24,  y = 0,
         w = 8,  h = 8,
         l={'forest_boss',11.5,6}
      }
   ]])

   for k, v in pairs(g_rooms) do
      v.i=function()
         batch_call_table(function(att_name, ...) g_att[att_name](...) end, v)
      end
      v.x,v.y = v.x+v.qx*32, v.y+v.qy*32
   end
end

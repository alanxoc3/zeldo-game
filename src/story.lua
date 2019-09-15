function map_init()
   g_rooms = gun_vals([[
      "debug"={      n="debug",    c=03,t=10,x=000,y=00,w=128,h=64 },
      "vilfd"={      n="hiroll",   c=03,t=10,x=000,y=16,w=64,h=16,l={"for_1",063,36}},
                                             
      "villa"={n="hiroll",   c=03,t=17,x=000,y=16,w=32,h=16,l={"for_1",063,38},r={"field",033,29},
         {"house",16,18.5,"h_lan",28,15},
         {"house",20,24.5,"h_bob",12,15},
         {"house",12,24.5,"h_sho",12,07},
         {"house",06,22.5,"h_ban",04,15},
         {"house",26,22.5,"h_inf",20,15},

         {"sign",14.5,19.5,"|sign:mayor lank's home"},
         {"sign",18.5,24.5,"|sign:bob and bobett's home"},
         {"sign",13.5,24.5,"|sign:hiroll shop"},
         {"sign",04.5,22.5,"|sign:ole banjo's house"},
         {"sign",27.5,22.5,"|sign:hiroll tutorial"},
         {"lark",14,28}
      },

      "field"={n="hiroll",   c=03,t=17,x=032,y=16,w=32,h=16,l={"villa",031,29},r={"cem_1",033,02}},
                                             
      "for_1"={n="forest",   c=03,t=10,x=048,y=32,w=16,h=08,r={"villa",001,29},l={"for_2",063,44},u={"for_0",040,62},d={"for_0",040,54},
         {"house",60,34.5,"h_lar",28,15},
         {"sign",58.5,34.5,"|sign:lark's house"}
      },

      "for_2"={n="forest",   c=03,t=10,x=048,y=40,w=16,h=08,r={"for_1",049,36},l={"for_0",046,58},u={"for_0",040,62},d={"for_3",060,49}},
      "for_3"={n="forest",   c=03,t=10,x=048,y=48,w=16,h=08,r={"for_0",034,58},l={"for_4",063,60},u={"for_2",060,47},d={"for_0",040,54}},

      "for_4"={n="forest",   c=03,t=10,x=048,y=56,w=16,h=08,r={"for_3",049,52},l={"for_0",046,58},u={"for_5",040,51},d={"for_0",040,54},
         {"house",56,58.5,"h_nav", 20, 07},
         {"top",56,60}
      },

      "for_5"={n="forest",   c=03,t=10,x=032,y=40,w=16,h=12,u={"for_6",040,39},d={"for_4",052,57}},
      "for_6"={n="forest",   c=03,t=10,x=032,y=32,w=16,h=08,d={"for_5",040,41}},
      "for_0"={n="forest",   c=03,t=10,x=032,y=52,w=16,h=12 },
                                             
      "cem_1"={n="cemetary", c=13,t=10,x=032,y=00,w=16,h=08,l={"field",063,29},r={"cem_2",097,29}},

      "cem_2"={n="cemetary", c=13,t=10,x=096,y=00,w=16,h=32,l={"cem_1",047,06},r={"cem_3",033,12},
         {"house",100,27.5,"h_gra", 04, 07}
      },

      "cem_3"={n="cemetary", c=13,t=10,x=032,y=08,w=16,h=08,l={"cem_2",111,29},r={"mnt_1",049,12}},
                                             
      "mnt_1"={n="canyon",   c=04,t=10,x=048,y=00,w=16,h=16,l={"cem_3",047,12},r={"mnt_2",085,30}},
      "mnt_2"={n="canyon",   c=04,t=10,x=084,y=12,w=12,h=20,l={"mnt_1",063,04},u={"mnt_3",088,11}},

      "mnt_3"={n="canyon",   c=04,t=10,x=080,y=00,w=16,h=12,d={"mnt_2",090,13},
         {"house",088,01.5,"cas_1",69,31,102}
      },
                                             
      "tom_1"={n="tomb",     c=13,t=10,x=112,y=24,w=16,h=08,d={"cem_2",104,04},u={"tom_2",120,23}},
      "tom_2"={n="tomb",     c=13,t=10,x=112,y=12,w=16,h=12,d={"tom_1",120,25},u={"tom_3",120,11}},
      "tom_3"={n="tomb",     c=13,t=10,x=112,y=00,w=16,h=12,d={"tom_2",120,13}},
                                       
      "cas_1"={n="castle",   c=13,t=10,x=064,y=22,w=10,h=10,d={"mnt_3",088,02},r={"cas_2",075,27}},
      "cas_2"={n="castle",   c=13,t=10,x=074,y=22,w=10,h=10,l={"cas_1",073,27},u={"cas_3",079,21}},
      "cas_3"={n="castle",   c=13,t=10,x=064,y=12,w=20,h=10,d={"cas_2",079,23},u={"cas_4",072,11}},
      "cas_4"={n="castle",   c=13,t=10,x=064,y=00,w=16,h=12,d={"cas_3",072,13}},
                                       
      "tec_1"={n="tech",     c=13,t=10,x=112,y=56,w=16,h=08,l={"tec_2",111,60},u={"tec_3",120,55}},
      "tec_2"={n="tech",     c=13,t=10,x=096,y=44,w=16,h=20,r={"tec_1",113,60}},
      "tec_3"={n="tech",     c=13,t=10,x=112,y=44,w=16,h=12,d={"tec_1",120,57},u={"tec_4",120,43}},
      "tec_4"={n="tech",     c=13,t=10,x=112,y=32,w=16,h=12,d={"tec_3",120,45}},
                                       
      "h_gra"={n="house",    c=04,t=10,x=000,y=00,w=08,h=08,d={"cem_2",100,28}},
      "h_sho"={n="house",    c=04,t=10,x=008,y=00,w=08,h=08,d={"villa",012,25}},
      "h_nav"={n="house",    c=03,t=10,x=016,y=00,w=08,h=08,d={"for_4",056,59}},
      "b_lan"={n="house",    c=04,t=10,x=024,y=00,w=08,h=08,d={"h_lan",028,09}},
      "b_lar"={n="house",    c=04,t=10,x=024,y=00,w=08,h=08,d={"h_lar",028,09},
         {"pot",25.5,1.5},
         {"pot",25.5,6.5},
         {"pot",30.5,1.5},
         {"pot",30.5,6.5}
      },
                                       
      "h_ban"={n="house",    c=04,t=10,x=000,y=08,w=08,h=08,d={"villa",006,23}},
      "h_bob"={n="house",    c=04,t=10,x=008,y=08,w=08,h=08,d={"villa",020,25}},
      "h_inf"={n="house",    c=04,t=10,x=016,y=08,w=08,h=08,d={"villa",026,23}},
      "h_lan"={n="house",    c=04,t=10,x=024,y=08,w=08,h=08,d={"villa",016,19},u={"b_lan",028,07}},
      "h_lar"={n="house",    c=04,t=10,x=024,y=08,w=08,h=08,d={"for_1",060,35},u={"b_lar",028,07},
         {"pot",26.5,11.5},
         {"pot",30.5,13.5},
         {"lark",28,12.5}
      },

      "title"={n="title",  c=03, x=96,  y=32, w=11, h=10 },
      "endle"={n="endless",c=13, x=96,  y=32, w=16, h=12 }
   ]])

   for k, v in pairs(g_rooms) do
      v.i=function()
         batch_call_table(function(att_name, ...) g_att[att_name](...) end, v)
      end
   end
end

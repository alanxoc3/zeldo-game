pico-8 cartridge // http://www.pico-8.com
version 23
__lua__
-- that story about zeldo
-- amorg
g_gunvals_raw=[[
1={
{1,1,3,3},
{2,1,3,4},
{3,1,3,6},
{4,2,4,6},
{5,3,6,6}
},
2={
{1,2,3,6},
{4,3,6,5}
},
3={
{1,1,3,3},
{2,1,3,4},
{3,1,3,6},
{4,2,4,6},
{5,3,6,6}
},
4={
{1,1,3,5},
{4,1,5,3}
},
5={
{1,1,3,3},
{2,1,3,5},
{4,2,5,5}
},
6={
{2,1,5,6}
},
7={
{2,1,5,6},
{6,2,6,5}
},
67={
{-1,3,8,5},
{1,-1,6,8}
},
71={
{-1,1,8,7},
{0,0,6,7},
{1,-1,3,7},
{3,-1,3,8},
{4,0,5,8}
},
20={
{2,4,6,6},
{4,2,6,6}
},
87={
{-1,3,8,5},
{0,0,8,6},
{1,-1,6,8},
{7,-1,7,7},
{8,0,8,7}
},
228={
{-1,1,8,15},
{0,0,7,16}
},
32={
{0,3,6,5},
{1,1,6,6},
{2,1,4,7},
{3,0,4,7},
{5,0,6,6},
{7,1,7,4}
},
36={
{2,2,5,5}
},
227={
{-1,-1,7,15},
{8,0,8,14}
},
226={
{-1,0,3,16},
{4,10,8,16}
},
48={
{0,1,6,6},
{1,0,6,7},
{7,4,7,6}
},
52={
{-1,3,7,5},
{0,1,6,5},
{1,1,5,7},
{2,-1,4,7},
{3,-1,4,8},
{5,0,5,8},
{6,0,6,6},
{7,2,7,6},
{8,2,8,4}
},
119={
{0,2,6,7},
{1,1,6,8},
{7,3,7,7}
},
225={
{-1,-1,8,15}
},
64={
{-1,2,8,5},
{0,0,7,7},
{1,-1,6,7},
{2,-1,5,8}
},
68={
{-1,4,8,7},
{0,0,7,8},
{1,-1,6,8}
},
224={
{-1,0,8,16}
},
150={
{-1,0,6,3},
{0,-1,6,4},
{1,-1,6,5},
{7,1,7,4},
{8,1,8,3}
},
80={
{-1,4,8,6},
{0,-1,7,7},
{1,-1,7,8}
},
84={
{-1,3,6,7},
{0,0,5,8},
{1,-1,5,8},
{6,-1,6,7},
{7,0,7,6},
{8,3,8,5}
},
149={
{-1,0,7,5},
{0,-1,6,5}
},
148={
{-1,0,7,3},
{0,-1,6,4},
{1,-1,6,5},
{7,0,7,4}
},
33={
{0,1,7,6}
},
100={
{-1,4,8,7},
{0,0,7,8},
{1,-1,7,8},
{8,0,8,7}
},
147={
{-1,0,7,5},
{0,-1,6,5},
{8,3,8,5}
},
45={
{0,1,7,7},
{1,0,6,7}
},
49={
{1,2,6,5},
{2,1,5,6}
},
116={
{-1,2,7,7},
{0,1,6,8},
{1,0,5,8},
{7,2,7,8},
{8,3,8,7}
},
146={
{1,3,3,8},
{4,3,6,7}
},
145={
{1,3,6,7},
{4,3,6,8}
},
65={
{-1,0,8,6},
{0,-1,5,8},
{6,-1,7,7},
{8,0,8,7}
},
69={
{-1,3,8,6},
{0,0,7,8},
{1,-1,6,8}
},
144={
{1,3,6,8}
},
83={
{0,0,6,8},
{1,-1,6,8},
{7,-1,7,7},
{8,0,8,4}
},
81={
{-1,1,7,6},
{0,-1,7,7},
{1,-1,7,8},
{8,4,8,6}
},
85={
{-1,3,6,7},
{0,0,5,8},
{1,-1,5,8},
{6,-1,6,7},
{7,0,7,6},
{8,3,8,5}
},
26={
{0,9,7,12},
{1,3,5,13},
{2,0,4,15},
{5,2,5,15},
{6,4,6,13},
{7,8,7,12}
},
114={
{-1,0,8,6},
{1,0,3,7},
{6,0,8,7}
},
34={
{0,3,2,7},
{3,2,3,6},
{4,0,4,5},
{5,0,5,4},
{6,0,7,3}
},
101={
{-1,2,8,5},
{0,-1,6,6},
{1,-1,6,8},
{7,0,7,6},
{8,1,8,5}
},
115={
{-1,1,3,7},
{2,0,3,7},
{4,0,6,6},
{6,0,6,8},
{7,1,8,8}
},
46={
{0,-1,5,14},
{1,-1,5,15},
{2,-1,4,16},
{6,0,6,15},
{7,0,10,14},
{9,0,10,15},
{11,1,13,16},
{14,1,14,15},
{15,1,15,14}
},
50={
{1,1,6,6}
},
117={
{-1,3,7,8},
{0,2,6,8},
{1,1,5,8},
{8,4,8,8}
},
113={
{-1,2,8,5},
{0,2,7,7},
{1,0,7,7},
{2,-1,5,8},
{6,-1,7,7},
{8,0,8,5}
},
112={
{-1,2,8,5},
{0,0,7,7},
{1,-1,6,7},
{2,-1,5,8}
},
66={
{-1,3,8,5},
{1,-1,6,8}
},
70={
{-1,3,8,5},
{0,-1,6,8},
{7,0,7,6},
{8,1,8,5}
},
96={
{-1,3,8,5},
{0,0,6,8},
{1,-1,6,8},
{7,3,8,8}
},
99={
{-1,0,7,5},
{0,-1,6,6},
{1,-1,6,8},
{7,0,7,6},
{8,3,8,5}
},
19={
{2,1,6,3},
{4,1,6,5}
},
23={
{1,1,5,3}
},
98={
{-1,3,8,5},
{0,-1,6,6},
{1,-1,6,8},
{7,0,7,6}
},
97={
{-1,3,8,5},
{0,0,6,6},
{1,-1,6,8},
{7,3,7,6}
},
35={
{1,-1,6,6}
},
102={
{0,-1,2,2},
{1,-1,2,4},
{2,-1,2,5},
{3,0,6,5}
},
43={
{0,0,7,6},
{2,0,5,7}
},
86={
{-1,3,6,7},
{0,0,5,8},
{1,-1,5,8},
{6,-1,6,7},
{7,0,7,6},
{8,3,8,5}
},
51={
{-1,-1,3,4},
{1,-1,3,6},
{4,1,6,6}
},
118={
{0,3,6,7},
{1,2,6,8},
{7,4,7,7}
},
21={
{1,2,3,6},
{4,4,5,6}
},
82={
{-1,3,8,5},
{1,-1,6,8},
{7,0,7,5}
},
|
{@1,@2,@5},
{@3,@2,@5},
{@3,@4,@5},
{@1,@4,@5}
|
{@1,@2,@4,@6},
{@1,@2,@3,@5}
|{0x8000,0x8000,0x7fff,0x7fff,@1}|
{0,0,0,0,0,0,0},
{1,1,1,0,0,0,0},
{2,2,2,1,0,0,0},
{3,3,3,1,0,0,0},
{4,2,2,2,1,0,0},
{5,5,1,1,1,0,0},
{6,13,13,5,5,1,0},
{7,6,13,13,5,1,0},
{8,8,2,2,2,0,0},
{9,4,4,4,5,0,0},
{10,9,4,4,5,5,0},
{11,3,3,3,3,0,0},
{12,12,3,1,1,1,0},
{13,5,5,1,1,1,0},
{14,13,4,2,2,1,0},
{15,13,13,5,5,1,0}
|
{mem_loc=5,enabled=false,name="force",xoff=-7,yoff=-9,sind=36},
{mem_loc=6,enabled=false,name="brang",xoff=0,yoff=-10,sind=4},
{mem_loc=7,enabled=true,name="bomb",xoff=7,yoff=-9,sind=5},
{mem_loc=8,enabled=false,name="shield",xoff=-8,yoff=-3,sind=6},
{mem_loc=9,enabled=true,name="interact",interact=true,xoff=0,yoff=-3,sind=false},
{mem_loc=10,enabled=false,name="bow",xoff=8,yoff=-3,sind=7},
{mem_loc=11,enabled=false,name="shovel",xoff=-7,yoff=4,sind=3},
{mem_loc=12,enabled=false,name="sword",xoff=0,yoff=6,sind=2},
{mem_loc=13,enabled=false,name="banjo",xoff=7,yoff=4,sind=1}
|0,0,13,1|
{@1,@2,@1,@4,13},
{@3,@2,@3,@4,13},
{@5,@2,@6,@4,@7},
{@5,@4,@6,@4,@8}
|
{13,115,-1,@1},
{117,115,1,@2}
|
{x=02,y=12,room="h_ban"},
{x=52,y=60,room="for_4"},
{x=69,y=17,room="cas_3"},
{x=123,y=14,room="tom_2"},
{x=123,y=60,room="tec_1"}
|
{tl_name="logo",x=64,y=64,u=nf,d=@1,tl_max_time=2.5}
|13,1|
{@1,3,3,-1,7,5},
{@2,3,11,-1,7,5}
|
{"that story about",0,-17,10,4}
|
{"🅾️ or ❎ to play  ",0,12,7,5}
|
{x=8,y=8,i=@8,d=@5,u=@6},{
tl_name="outer",tl_loop=true,
{i=nf,e=@3,u=@2,d=@1,tl_max_time=5}
},{i=@4,u=@6,e=nf},
{i=@7,d=@9}
|
{"act","update"},
{"mov","move"},
{"vec","vec_update"},
{"act","clean"},
{"view","update_view"}
|
{"fader_in","delete"},
{"fader_out","delete"}
|
0#{
template=0,m=14,c=3,
l={10,11.5,5},
r={1,0.5,5},
d={17,4,0.5},
{"sign",5.5,2,{"⬅️ spike's forest","➡️ hiroll village"},43},
{"spikes",2,2,0.5},
{"spikes",2,7,0.5},
{"spikes",2,4,0},
{"spikes",2,5,0},
{"spikes",3,4,0},
{"spikes",3,5,0},
{"tall_tree",4,3},
{"tall_tree",5.5,6.5},
{"chest",4,5.5,false,13},
{"chest",8,6,true,13},
},
1#{
template=1,m=14,c=3,
l={0,11.5,5},
r={2,0.5,7},
{"sign",9,2,{"lank's house"},43},
{"house",7.5,2,58,4,7.5,46},
{"slimy",3.5,6.5},
{"navy_blocking",0.5,4.5},
},
2#{
template=2,m=14,c=3,w=24,
l={1,11.5,5},
r={19,0.5,5},
{"sign",5,4,{"lime and navy's house"},43},
{"sign",13,2,{"lark's house"},43},
{"sign",17,3,{"teach's studio"},43},
{"sign",9,3,{"bob and jane's house"},43},
{"sign",21,4,{"hi-roll shop"},43},
{"house",3.5,4,9,4,7.5,46},
{"house",15.5,3,6,4,7.5,46},
{"house",11.5,2,57,4,7.5,46},
{"house",7.5,3,8,4,7.5,46},
{"house",19.5,4,7,4,7.5,46},
{"kluck",8,6.5},
{"topy",6,7},
},
6#{
template=6,m=18,c=4,
d={2,16,4},
{"sign",1,1,{"press 🅾️ to use yer item."},43},
{"sign",6,1,{"hold down ❎ to select","yer item."},43},
{"teach",3.5,3.5},
{"box",6,6},
{"box",1,6},
{"pot",1,5},
{"pot",2,6},
{"pot",5,6},
{"pot",6,5},
},
7#{
template=7,m=18,c=4,
d={2,20,5},
{"shop_brang",2,3},
{"shop_shield",5,3},
{"keep",3.5,3},
{"pot",6,6},
{"pot",1,6},
{"box",6,1},
{"box",1,1},
{"chest",2,1,true,13},
{"chest",5,1,false,13},
},
8#{
template=8,m=18,c=4,
d={2,8,4},
{"jane",5,2},
{"pot",6,6},
{"pot",2,6},
{"box",1,6},
},
9#{
template=9,m=18,c=4,
d={2,4,5},
{"box",6,6},
{"box",1,6},
{"pot",5,6},
{"pot",2,6},
},
10#{
template=0,m=14,c=3,
l={17,4,4},
r={0,0.5,5},
u={17,4,4},
d={11,6,0.5},
{"spikes",9,2,0.5},
{"spikes",2,7,0},
{"spikes",5,3,0},
{"spikes",6,3,0},
{"spikes",5,4,0},
{"spikes",6,4,0},
{"spikes",5,5,0.5},
{"spikes",6,5,0.5},
{"spikes",5,6,0.5},
{"spikes",6,6,0.5},
{"slimy",2,2},
{"slimy",9,7},
},
11#{
template=1,m=14,c=3,
l={12,11.5,5},
r={17,4,4},
u={10,6,9.5},
d={18,4,0.5},
{"spikes",3,1,0.5},
{"spikes",3,2,0.5},
{"spikes",4,1,0.75},
{"spikes",4,2,0.75},
{"spikes",7,1,0.5},
{"spikes",7,2,0.5},
{"spikes",8,1,0.75},
{"spikes",8,2,0.75},
{"spikes",9,3,0},
{"spikes",10,3,0},
{"spikes",9,6,0},
{"spikes",10,6,0},
{"spikes",3,4,0},
{"spikes",3,5,0},
{"spikes",4,4,0},
{"spikes",4,5,0},
{"spikes",7,4,0},
{"spikes",7,5,0},
{"spikes",8,4,0},
{"spikes",8,5,0},
{"spikes",3,7,0.75},
{"spikes",3,8,0.75},
{"spikes",4,7,0.5},
{"spikes",4,8,0.5},
{"spikes",7,7,0.75},
{"spikes",7,8,0.75},
{"spikes",8,7,0.5},
{"spikes",8,8,0.5},
{"slimy",1,2},
{"slimy",1,7},
},
12#{
template=2,m=14,c=3,
l={17,4,4},
r={11,0.5,5},
u={13,6,9.5},
d={17,4,4},
{"spikes",2,4,0},
{"spikes",3,4,0},
{"spikes",2,5,0},
{"spikes",3,5,0},
{"spikes",8,4,0},
{"spikes",9,4,0},
{"spikes",8,5,0},
{"spikes",9,5,0},
{"spikes",5,4,0.5},
{"spikes",6,4,0.5},
{"spikes",5,5,0.5},
{"spikes",6,5,0.5},
{"spikes",4,2,0.25},
{"spikes",7,2,0.5},
{"spikes",4,7,0.5},
{"spikes",7,7,0.25},
{"slimy",2,7},
{"slimy",2,2},
{"slimy",9,2},
{"slimy",9,7},
},
13#{
template=3,m=14,c=3,
l={17,4,4},
r={17,4,4},
u={14,6,11.5},
d={12,6,0.5},
{"spikes",2,4,0},
{"spikes",3,4,0},
{"spikes",2,5,0},
{"spikes",3,5,0},
{"spikes",8,4,0},
{"spikes",9,4,0},
{"spikes",8,5,0},
{"spikes",9,5,0},
{"spikes",1,1,0.5},
{"spikes",10,1,0.5},
{"spikes",1,8,0.5},
{"spikes",10,8,0.5},
},
14#{
template=4,m=20,c=3,
r={16,0.5,4},
d={13,6,0.5},
{"spikes",10,7,0.25},
{"spikes",9,7,0.25},
{"spikes",9,8,0.25},
{"spikes",10,8,0.25},
{"spikes",6,6,0.25},
{"spikes",6,5,0.25},
{"spikes",5,5,0.25},
{"spikes",5,6,0.25},
{"spikes",2,4,0.25},
{"spikes",2,3,0.25},
{"spikes",1,3,0.25},
{"spikes",1,4,0.25},
{"spikes",8,2,0.5},
{"spikes",8,1,0.5},
{"spikes",7,1,0.5},
{"spikes",7,2,0.5},
{"spikes",8,9,0.5},
{"spikes",7,9,0.5},
{"spikes",7,10,0.5},
{"spikes",8,10,0.5},
{"spikes",4,9,0.5},
{"spikes",3,9,0.5},
{"spikes",3,10,0.5},
{"spikes",4,10,0.5},
{"spikes",2,7,0.75},
{"spikes",1,7,0.75},
{"spikes",1,8,0.75},
{"spikes",2,8,0.75},
{"spikes",3,2,0.75},
{"spikes",3,1,0.75},
{"spikes",4,1,0.75},
{"spikes",4,2,0.75},
{"spikes",9,3,0.75},
{"spikes",10,3,0.75},
{"spikes",10,4,0.75},
{"spikes",9,4,0.75},
},
16#{
template=6,m=14,c=3,
l={14,11.5,6},
},
17#{
template=7,m=14,c=3,
r={1,0.5,5},
u={0,6,9.5},
{"slimy",3.5,6},
{"sign",51,21,{"don't get lost!"},43},
{"spikes",1,1,0.25},
{"spikes",6,1,0.25},
{"spikes",6,6,0.25},
{"spikes",1,6,0.25},
},
18#{
template=8,m=14,c=3,
u={11,6,9.5},
{"spikes",1,3,0.25},
{"spikes",2,4,0.25},
{"spikes",3,3,0.25},
{"spikes",4,4,0.25},
{"spikes",5,3,0.25},
{"spikes",6,4,0.25},
{"spikes",6,3,0.5},
{"spikes",5,4,0.5},
{"spikes",4,3,0.5},
{"spikes",3,4,0.5},
{"spikes",2,3,0.5},
{"spikes",1,4,0.5},
},
19#{
template=9,m=14,c=3,
l={2,23.5,7},
u={24,3,11.5},
{"sign",1.5,1.5,{"⬆️ hiroll field","⬅️ hiroll village"},43},
{"bob_build",4.5,1.5},
},
21#{
template=1,m=14,c=6,
d={26,4,0.5},
},
22#{
template=2,m=14,c=4,w=24,
l={31,11.5,7},
u={26,4,15.5},
},
24#{
template=4,m=14,c=3,w=24,
r={33,0.5,3},
d={19,5,0.5},
{"topy",21,2.5},
},
26#{
template=6,m=14,c=4,h=16,
u={21,6,9.5},
d={22,18,0.5},
},
30#{
template=0,m=14,c=13,h=20,
l={33,11.5,7},
r={31,0.5,7},
},
31#{
template=1,m=14,c=13,
l={30,11.5,17},
r={22,0.5,7},
},
33#{
template=3,m=14,c=13,
l={24,23.5,3},
r={30,0.5,17},
},
57#{
template=7,m=18,c=4,
d={2,12,3},
{"lark",3.5,3.5},
{"box",6,6},
{"box",1,6},
{"pot",6,5},
{"pot",1,5},
},
58#{
template=8,m=18,c=4,
d={1,8,3},
{"pot",6,6},
{"pot",5,6},
{"pot",2,6},
{"pot",1,6},
{"pot",1,5},
{"pot",6,4},
{"chest",6,5,true,13},
}|
0#{x=0,y=0,w=12,h=10},
{x=12,y=0,w=12,h=10},
{x=0,y=10,w=12,h=10},
{x=12,y=10,w=12,h=10},
{x=0,y=20,w=12,h=12},
{x=12,y=20,w=12,h=12},
{x=24,y=0,w=8,h=8},
{x=24,y=8,w=8,h=8},
{x=24,y=16,w=8,h=8},
{x=24,y=24,w=8,h=8}
|"act",{},{"room_init","pause_init","pause_update","pause_end","clean","delete"},{
alive=true,
stun_countdown=0,
i=nf,u=nf,
update=@1,
clean=@2,
kill=@3,
delete=@4,
room_init=nf,
pause_init=nf,
pause_update=nf,
pause_end=nf,
destroyed=nf,
get=@5
}
|
"confined",{"act"},{},{}
|
"loopable",{"act"},{},
{tl_loop=true}
|
"bounded",{"act"},{},
{check_bounds=@1}
|"timed",{"act"},{},
{
t=0,
tick=@1
}
|"pos",{"act"},{},
{
x=0,
y=0
}
|"vec",{"pos"},{},
{
dx=0,
dy=0,
vec_update=@1
}
|"mov",{"vec"},{},
{
ix=.85,
iy=.85,
ax=0,
ay=0,
move=@1,
stop=@2
}
|"move_pause",{"act"},{"update","move","vec_update","tick"},{}|"dim",{"pos"},{"debug_rect"},
{
rx=.375,
ry=.375,
debug_rect=@1
}
|"rel",{"act"},{"rel_update"},
{
rel_actor=nil,
rel_x=0,
rel_y=0,
rel_dx=0,
rel_dy=0,
flippable=false,
rel_update=@1
}
|"drawable_obj",{"act"},{"reset_off"},
{
ixx=0,
iyy=0,
xx=0,
yy=0,
visible=true,
reset_off=@1
}
|"drawable",{"drawable_obj"},{"d"},{d=nf}|"pre_drawable",{"drawable_obj"},{"d"},{d=nf}|"post_drawable",{"drawable_obj"},{"d"},{d=nf}|"spr_obj",{"vec","drawable_obj"},{},
{
sind=0,
outline_color=1,
sw=1,
sh=1,
xf=false,
yf=false,
draw_spr=@1,
draw_out=@2,
draw_both=@3
}
|"spr",{"vec","spr_obj"},{},
{
d=@1
}
|"knockable",{"mov"},{},
{
knockback=@1
}
|"stunnable",{"mov","drawable_obj"},{},
{
stun_update=@1
}
|"hurtable",{"act"},{},
{
health=-1,
max_health=-1,
hurt_func=nf,
hurt=@1
}
|"anim",{"spr","timed"},{},
{
sinds={},
anim_loc=1,
anim_off=0,
anim_len=1,
anim_spd=0,
anim_sind=nil,
anim_update=@1
}
|"wall",{"vec","dim"},{},
{
block=true,static=true,touchable=true,hit=nf
}
|"trig",{"vec","dim"},{},
{
contains=nf,
intersects=nf,
not_contains_or_intersects=nf,
contains_or_intersects=@1,
trigger_update=@1
}
|"col",{"vec","dim"},{},
{
static=false,
touchable=true,
hit=nf,
move_check=@1
}
|dx=0,dy=0|
{"x","dx",@1,@2,@3,@4},
{"y","dy",@1,@2,@5,@6}
|"tcol",{"vec","dim"},{},
{
tile_solid=true,
tile_hit=nf,
coll_tile=@1
}
|"danceable",{"act"},{},
{
initial_time=0,
dance_update=@1,
pause_update=@1,
pause_init=@2
}
|"interactable",{"spr","wall","confined"},{},
{
interactable_trigger=nf,
trig_x=0,
trig_y=0,
trig_rx=.75,
trig_ry=.75,
trig=nil,
i=@1,interactable_init=@1
}
|"nnpc",{"drawable","danceable","interactable"},{},
{
rx=.5,ry=.5,iyy=-2,
u=@1
}
|"bashable",{"rel","knockable","col"},{},
{
bash_dx=1,
rel_bash_dx=1,
hit=@1,bash=@1
}
|"item",{"drawable","rel","confined","spr_obj"},{},
{being_held=true,destroyed=@1}
|"pokeable",{"rel","drawable_obj","item"},{},
{
i=@1,
u=@2,
e=@3,
poke_init=@1,
poke_update=@2,
poke_end=@3,
poke=20,
poke_dist=20,
poke_energy=0
}
|"shop_item",{"drawable","interactable"},{"update"},
{
costable=true,
interactable_trigger=@1,
rx=.5,ry=.5,
iyy=-3,
trig_x=0,trig_y=.125,
trig_rx=.5,trig_ry=.625,
mem_loc=255,cost=99
}
|"mem_dep",{"act"},{},
{
room_init=@1,
mem_loc=255,
mem_loc_expect=true
}
|"brang",1,{"confined","anim","col","mov","tcol"}|
did_brang_hit=false,
tile_solid=false,
rel_actor=@1,
being_held=true,
rx=.375,
ry=.375,
sinds={4,19,20,21},
anim_len=4,
anim_spd=3,
ix=.8,iy=.8,
touchable=false,
tile_hit=@10,
item_slow=true,
{i=@2,hit=@3,u=@4,tl_max_time=.1},
{i=nf,hit=@5,u=@6,tl_max_time=.75},
{ax=0,ay=0,dx=0,dy=0,i=@9,hit=nf,u=@4,tl_max_time=.15},
{i=nf,hit=@7,u=@8,tl_max_time=3}
|"banjo",1,{"item","danceable"},{"update"}|
rel_actor=@1,
rx=.3,
ry=.3,
sind=1,
touchable=false,
item_stop=true,
e=@3,
{tl_name="loop",i=@2,tl_max_time=4.25}
|"sword",1,{"item","col","bashable","pokeable"}|
item_slow=true,
rel_actor=@1,
rel_bash_dx=.4,
max_stun_val=20,
min_stun_val=10,
energy=10,
poke_val=10,
poke_dist=1,
rx=.5,
ry=.375,
rel_y=0,
iyy=-2,
sind=2,
touchable=false,
poke_energy=15,
poke_ixx=2,
{hurt_amount=5,bash_dx=.3,hit=@2,tl_max_time=.1},
{i=nf,u=@3,e=nf,hurt_amount=2,bash_dx=.1,hit=@2}
|"shield",1,{"item","bashable","pokeable"}|
item_slow=true,
rel_actor=@1,
rel_bash_dx=.1,
max_stun_val=60,
min_stun_val=0,
energy=2,
poke_val=10,
o_hurt=0,
poke_dist=.625,
block=true,
rx=.25,
ry=.5,
iyy=-1,
sind=6,
touchable=false,
poke_energy=10,
poke_ixx=0,
{hit=@2,bash_dx=.4,tl_max_time=.1},
{u=@3,tl_max_time=.1},
{hit=@2,i=nf,u=@3,e=nf,bash_dx=.2}
|"item_selector",1,{"rel"}|
rel_actor=@1,u=@2
|"inventory_item",6,{"rel","spr_obj","drawable"},{"draw_both"}|
rel_actor=@1,rel_x=@2,rel_y=@3,enabled=@4,flippable=@5,sind=@6,visible=@6,
i=@7,u=@8
|"fader_out",2,{"act"},{"update"}|
i=@1,e=@2,u=@3,
{tl_name="timeline",tl_max_time=.5}
|"fader_in",2,{"act"},{"update"}|"title_move",0,{"mov"}|
x=0,y=0,dx=.1,dy=.1,ax=0,ay=0,ix=1,iy=1,ixx=0,iyy=0
|"view",4,
{"act","confined"},
{"center_view","update_view"}
|
x=0,y=0,room_crop=2,
tl_loop=true,
w=@1,h=@2,follow_dim=@3,follow_act=@4,
update_view=@5,
center_view=@6,
change_ma=@7,
{},
{tl_max_time=4},
{follow_act=false}
|{@1,"x","w","ixx"},{@1,"y","h","iyy"}|"slimy",2,{"drawable","bounded","danceable","confined","stunnable","mov","col","tcol","hurtable","knockable","spr_obj","spr"}|
x=@1,y=@2,
max_health=3,health=3,
name="slimy",evil=true,tl_loop=true,
rx=.25,ry=.25,
iyy=-2,
sind=118,
anim_len=1,
touchable=true,
hurt_func=@9,
{i=@5,hit=nf,u=@8,tl_max_time=3},
{i=nf,hit=nf,u=@3,e=@6,tl_max_time=.25},
{i=nf,hit=@7,u=@4,e=@6,tl_max_time=.25},
|"topy",2,{"drawable","bounded","danceable","confined","stunnable","mov","col","tcol","hurtable","knockable","anim","spr"}|
max_health=10,health=10,
name="topy",
evil=true,
x=@1,y=@2,
rx=.375,ry=.375,
tl_loop=true,
iyy=-2,
sinds={112,113},
anim_len=1,
touchable=true,
destroyed=@8,
hurt_func=@9,
{i=@4,hit=nf,u=nf,tl_max_time=.5},
{i=@7,hit=nf,u=@5,tl_max_time=.5},
{i=@6,hit=@3,u=nf,tl_max_time=1}
|"kluck",2,{"drawable","loopable","bounded","confined","stunnable","mov","col","tcol","hurtable","knockable","spr","danceable"}|
name="kluck",
evil=true,
x=@1,y=@2,
rx=.375,ry=.375,
sind=32,
destroyed=@4,
{i=@3,tl_max_time=.5}
|"save_spot",2,{"confined","trig","drawable_obj"}|
name="save spot",
rx=.625,ry=.625,
x=@1,y=@2,
intersects=@3,contains=@3,
pause_end=@4,not_contains_or_intersects=@5
|"the game has been saved!"|
"the game won't save for",
"bad banjo players."
|"sign",3,{"drawable","interactable"}|
name="sign",sind=43,
rx=.5,ry=.5,
trig_x=0,trig_y=.125,
trig_rx=.75,trig_ry=.625,
x=@1,y=@2,text_obj=@3,interactable_trigger=@4
|"grave",3,{"drawable","interactable"}|
name="grave",sind=45,
rx=.5,ry=.5,
trig_x=0,trig_y=.125,
trig_rx=.75,trig_ry=.625,
x=@1,y=@2,text_obj=@3,interactable_trigger=@4
|"shop_brang",2,{"shop_item"}|
name="brang",sind=4,
x=@1,y=@2,mem_loc=6
|"shop_shield",2,{"shop_item"}|
name="shield",sind=6,
x=@1,y=@2,mem_loc=8
|"item_show",3,{"post_drawable","confined","spr","rel"},{"update"}|
rel_actor=@1,sind=@2,mem_loc=@3,
rel_y=-1.125,
{tl_max_time=2,e=@4}
|"chest",4,{"drawable","interactable"},{"update"}|
name="chest",
sind=50,rx=.375,ry=.375,
x=@1,y=@2,xf=@3,mem_loc=@4,
trig_y=0,
trig_rx=.5,trig_ry=.375,
interactable_trigger=@6,
{i=@5},{i=nf,interactable_trigger=nf,sind=51}
|"gen_trigger_block",7,{"rel","confined","trig"}|
rel_actor=@1,rel_x=@2,rel_y=@3,rx=@4,ry=@5,contains=@6,intersects=@7,
not_contains_or_intersects=@8
|"house",6,{"drawable","confined","spr"}|
x=@1,y=@2,room=@3,room_x=@4,room_y=@5,sind=@6,
i=@7,destroyed=@8,
iyy=-4,sw=2,sh=2
|"money",4,{"drawable","bounded","confined","tcol","spr","col","mov"}|
sind=36,rx=.125,ry=.125,
x=@1,y=@2,dx=@3,dy=@4,
touchable=false,
hit=@5,
destroyed=@7,
{tl_max_time=5},
{i=@6}
|"static_block",4,{"confined","wall"}|
x=@1,y=@2,rx=@3,ry=@4,
static=true,
touchable=true
|"thing_destroyed",3,{"confined","mov","drawable","bounded"},{"update"}|
parent=@1,c=@2,d=@5,
{i=@4,tl_max_time=@3}
|"pot_projectile",3,{"drawable","col","confined","mov","spr","bounded","tcol"}|
tile_solid=true,
sind=49,
x=@1,y=@2,xf=@3,
touchable=false,
i=@4,
destroyed=@6,
hit=@7,
tile_hit=@8,
{u=@5,tl_max_time=.3}
|"pot",2,{"drawable","bounded","confined","tcol","spr","col","mov"}|
static=true,
rx=.375,ry=.375,
x=@1,y=@2,sind=49,
touchable=true,
i=@3
|"box",2,{"drawable","confined","wall","spr","col"}|
static=true,
rx=.375,ry=.375,sind=35,x=@1,y=@2
|"tall_tree",2,{"drawable","confined","wall","spr","col"}|
static=true,
sw=1,sh=2,iyy=-4,
rx=.5,ry=.5,sind=26,x=@1,y=@2
|"spikes",3,{"trig","pre_drawable","confined","spr"}|
static=true,touchable=false,
rx=.375,ry=.375,sind=54,x=@1,y=@2,offset=@3,u=@4,
intersects=@5,contains=@5,i=@6
|"navy_blocking",2,{"nnpc","mem_dep"}|
name="navy",
sind=97,mem_loc=37,
x=@1,y=@2,interactable_trigger=@3,pause_end=!npc_dance_logic{{"umm..."},{
"nice playing lank!","",
"if i had money, i would",
"give it to you!",
trigger=!memloc_money{13,0}
}}
|
trigger=!get_npc_reload_room{37},
"a boomerang?","",
"isn't that a toy?","",
"i hope you can save my",
"sister with that thing."
|
trigger=!get_npc_reload_room{37},
"a shield! good choice!","",
"you can use that protect",
"my sister from monsters!"
|
"my sister has been in the",
"forest all day.",
"find something to protect",
"yourself with, then bring",
"her home."
|"teach",2,{"nnpc"}|
name="teach",
sind=96,
x=@1,y=@2,interactable_trigger=@3,
pause_end=@4
|
"try playing yer banjo on",
"a save spot!"
|
"hi lank, have you been",
"practicing the banjo?"
|
"oh, your banjo is out of",
"tune!",
"let me fix that for you.",
trigger=!get_npc_reload_room{36}
|
"now that's my student!"
|"lark",2,{"nnpc"}|
name="lark",
sind=99,
x=@1,y=@2,interactable_trigger=!tbox_closure{{"i'm your biggest fan!"}},
pause_end=!npc_dance_logic{{
"hey, that was bad!"
},{
"hey, that was good!",trigger=!memloc_money{14,60}
}}
|"jane",2,{"nnpc"}|
name="jane",sind=81,
x=@1,y=@2,interactable_trigger=!tbox_closure{{
"my husband always works",
"so hard.",
"what should i make him",
"for dinner?"
}},pause_end=!npc_dance_logic{{
"that hurt my ears."
},{
"i love that song!",trigger=!memloc_money{17,24}
}}
|"bob_build",2,{"nnpc","mem_dep"}|
name="bob",
sind=80,
mem_loc=35,
x=@1,y=@2,interactable_trigger=@3,
pause_end=!npc_dance_logic{{
"i can't work with that",
"terrible music!"
},{
"if only music could",
"quench my hunger.",trigger=!memloc_money{18,14}
}}
|
"is that letter for me?",
"",
"oh..",
"",
"it's dinner time!!!",
trigger=!get_npc_reload_room{35}
|
"hey lank, i'm hungry.",
"",
"i mean...",
"",
"i'm fixing the road."
|"keep",2,{"nnpc"}|
name="keep",
sind=83,
x=@1,y=@2,interactable_trigger=!tbox_closure{{"buy somethin' will ya?"}},
pause_end=!npc_dance_logic{{
"that song sucked."
},{
"that song was okay.",trigger=!memloc_money{16,1}
}}
|"lank_top",1,{"rel","spr_obj","danceable"}|
rel_actor=@1,sind=147,iyy=-2,u=@2,pause_update=@3
|"item","throwable"|"grabbed_item",4,{"rel","spr_obj"}|
rel_actor=@1,sind=@2,iyy=@3,create_func=@4,
throwable=true,
flippable=true,
being_held=true,
{i=@6,throwing=false,tl_max_time=.2},{i=nf,u=@5},{throwing=true,visible=false,tl_max_time=.05}
|"fairy",1,{"drawable","mov","move_pause"},{"u"}|
rel_actor=@1,sind=52,u=@2,off_x=1,off_y=0,d=@3,
fg=12,bg=6,
room_init=@4
|"pl",2,
{"drawable","anim","col","mov","tcol","hurtable","knockable","stunnable","spr","danceable"}|
name="lank",x=@1,
y=@2,
sinds={144,145,146},
sind=144,
rx=.375,
ry=.375,
iyy=-2,
spd=.02,
anim_len=3,
anim_spd=5,
max_health=10,
health=10,
i=@3,u=@4,destroyed=@5,d=@6,room_init=@7,set_color=@8
|"item","item_slow"|"item","item_stop"|
{i=@1,u=@2,d=@3}
|
{"drawable_obj","reset_off"},
{"stunnable","stun_update"},
{"act","update"},
{"act","pause_update"},
{"mov","move"},
{"col","move_check",@1},
{"col","move_check",@4},
{"trig","trigger_update",@3},
{"tcol","coll_tile",@2},
{"rel","rel_update"},
{"vec","vec_update"},
{"bounded","check_bounds"},
{"anim","anim_update"},
{"timed","tick"},
{"view","update_view"}
|{"act","pause_init"}|
{"act","update"},
{"act","pause_update"},
{"rel","rel_update"},
{"fairy","move"},
{"fairy","vec_update"},
{"view","update_view"}
|{"act","pause_end"}|{"act","clean"}|
{"pre_drawable","d"},
{"drawable","d"},
{"post_drawable","d"}
|]]
_g={}
function nf()end
function btn_helper(f,a,b)
return f(a)and f(b)and 0 or f(a)and 0xffff or f(b)and 1 or 0
end
function bool_to_num(condition)return condition and 0xffff or 1 end
function xbtn()return btn_helper(btn,0,1)end
function ybtn()return btn_helper(btn,2,3)end
function xbtnp()return btn_helper(btnp,0,1)end
function ybtnp()return btn_helper(btnp,2,3)end
function zsgn(num)return num==0 and 0 or sgn(num)end
function round(num)return flr(num+.5)end
function rnd_one(val)return(flr_rnd"3"-1)*(val or 1)end
function ti(period,length)
return t()%period<length
end
function flr_rnd(x)
return flr(rnd(x))
end
function rnd_item(...)
local list={...}
return list[flr_rnd(#list)+1]
end
function tabcpy(src,dest)
dest=dest or{}
for k,v in pairs(src or{})do
if type(v)=="table"and not v.is_tabcpy_disabled then
dest[k]=tabcpy(v)
else
dest[k]=v
end
end
return dest
end
function call_not_nil(table,key,...)
if table and table[key]then
return table[key](...)
end
end
function munpack(t)return t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8],t[9],t[10]end
function batch_call_table(func,table)
foreach(table,function(t)func(munpack(t))end)
end
function batch_call(func,...)
batch_call_table(func,gun_vals(...))
end
function split_string(str,delimiter)
local str_list,cur_str={},""
for i=1,#str do
local char=sub(str,i,i)
if char==delimiter and #cur_str>0 then
add(str_list,cur_str)
cur_str=""
else
cur_str=cur_str..char
end
end
return str_list
end
function gun_vals_helper(val_str,i,new_params)
local val_list,val,val_ind,isnum,val_key,str_mode={},"",1,true
local macro_mode=nil
while i<=#val_str do
local x=sub(val_str,i,i)
if x=="\""then str_mode,isnum=not str_mode
elseif str_mode then val=val..x
elseif x=="}"or x==","then
if type(val)=="table"or not isnum then
elseif macro_mode then val=_g[val]
elseif sub(val,1,1)=="@"then
local sec=tonum(sub(val,2,#val))
assert(sec!=nil)
if not new_params[sec]then new_params[sec]={}end
add(new_params[sec],{val_list,val_key or val_ind})
elseif val=="nf"then val=nf
elseif val=="true"or val=="false"then val=val=="true"
elseif val=="nil"or val==""then val=nil
elseif isnum then val=tonum(val)
end
val_list[val_key or val_ind],isnum,val,val_ind,val_key=val,true,"",val_key and val_ind or val_ind+1
macro_mode=nil
if x=="}"then
return val_list,i
end
elseif x=="{"then
local ret_val=nil
ret_val,i,isnum=gun_vals_helper(val_str,i+1,new_params)
if macro_mode then
val=_g[val](munpack(ret_val))
else
val=ret_val
end
elseif x=="="then isnum,val_key,val=true,val,""
elseif x=="#"then isnum,val_key,val=true,tonum(val),""
elseif x=="!"then macro_mode=true
elseif x!=" " and x!="\n"then val=val..x end
i+=1
end
return val_list,i,new_params
end
param_cache={}
function gun_vals(val_str,...)
val_str=g_gunvals[0+val_str]
if not param_cache[val_str]then
param_cache[val_str]={gun_vals_helper(val_str..",",1,{})}
end
local params,lookup={...},param_cache[val_str]
for k,v in pairs(lookup[3])do
foreach(lookup[3][k],function(x)
x[1][x[2]]=params[k]
if type(params[k])=="table"then
params[k].is_tabcpy_disabled=true
end
end)
end
return tabcpy(lookup[1])
end
function tl_node(root,node,...)
if node==nil then return true end
local return_value
if not node.tl_tim then node.tl_tim=0 end
if node.tl_name then
root[node.tl_name]=node
end
if #node>0 then
node.tl_cur=node.tl_cur or 1
return_value=tl_node(root,node[node.tl_cur],...)
if return_value==0 then
node.tl_cur=nil
return_value=true
elseif return_value then
root.tl_old_state=nil
if type(return_value)=="NUMBER" then
node.tl_cur=return_value
else
node.tl_cur=(node.tl_cur%#node)+1
end
return_value=node.tl_cur==1 and not node.tl_loop
end
else
if not root.tl_old_state then
tabcpy(node,root)
node.tl_tim=0
root.tl_old_state=true
call_not_nil(root,"i",root,...)
end
return_value=call_not_nil(root,"u",root,...)
if root.tl_next then
return_value,root.tl_next=root.tl_next
end
end
if node!=root or #node==0 then
node.tl_tim+=1/60
root.tl_tim=node.tl_tim
return_value=return_value or node.tl_max_time and node.tl_tim>=node.tl_max_time
end
if return_value then
node.tl_tim=0
if #node==0 then
call_not_nil(root,"e",root,...)
end
end
return return_value
end
g_gunvals=split_string(g_gunvals_raw,"|")
g_act_arrs,g_att,g_par={},{},{}
function create_parent(...)
local id,par,pause_funcs,att=munpack(gun_vals(...))
g_par[id]=function(a)
a=a or{}
return a[id]and a or attach_actor(id,par,pause_funcs,att,a)
end
end
function create_actor(meta,template_str,...)
local template_params,id,provided,parents,pause_funcs={...},munpack(gun_vals(meta))
g_att[id]=function(...)
local func_params,params={...},{}
for i=1,provided do
add(params,func_params[i]or false)
end
foreach(template_params,function(x)
add(params,x)
end)
return attach_actor(id,parents,pause_funcs or{},gun_vals(template_str,munpack(params)),{})
end
end
function attach_actor(id,parents,pause_funcs,template,a)
foreach(parents,function(par_id)a=g_par[par_id](a)end)
tabcpy(template,a)
if not a[id]then
g_act_arrs[id]=g_act_arrs[id]or{}
add(g_act_arrs[id],a)
end
a.pause=a.pause or{}
foreach(pause_funcs,function(f)
a.pause[f]=true
end)
a.id,a[id]=id,true
return a
end
function acts_loop(id,func_name,...)
for a in all(g_act_arrs[id])do
if not is_game_paused()or is_game_paused()and a.pause[func_name]then
call_not_nil(a,func_name,a,...)
end
end
end
function del_act(a)
for k,v in pairs(g_act_arrs)do
if a[k]then del(v,a)end
end
end
function look_at_pl(a)
if g_pl then
a.xf=a.x-g_pl.x>0
end
end
function npc_able_to_interact(a,other)
return(a.x>other.x-.5 and not other.xf or a.x<other.x+.5 and other.xf)
end
function able_to_interact()
return not g_menu_open
and get_selected_item().interact
and not is_game_paused()
and btnp"4"
end
function _g.memloc_money(mem_loc,money)
return function()
if not zdget(mem_loc)then
add_money(money)
zdset(mem_loc)
end
end
end
function _g.npc_dance_logic(bad_text,good_text)
return function(a)
if g_pause_reason=="dancing"then
change_cur_ma(a)
tbox_with_obj(zdget"36"and good_text or bad_text)
end
end
end
function _g.get_npc_reload_room(mem_loc)
return function()
zdset(mem_loc)
transition(g_cur_room_index,g_pl.x-g_cur_room.x,g_pl.y-g_cur_room.y,g_pl)
end
end
g_out_cache=gun_vals[[1]]
function zspr(sind,x,y,sw,sh,...)
if not sw then sw=1 end
if not sh then sh=1 end
spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end
function scr_spr(a,spr_func,...)
if a and a.visible then
(spr_func or zspr)(a.sind,scr_x(a.x)+a.ixx+a.xx,scr_y(a.y)+a.iyy+a.yy,a.sw,a.sh,a.xf,a.yf,...)
end
end
function scr_spr_out(a)scr_spr(a,spr_out,a.outline_color)end
function scr_spr_and_out(...)
foreach({...},scr_spr_out)
foreach({...},scr_spr)
end
function zrect(x1,y1,x2,y2,color_gun)
local list=gun_vals(color_gun)
for k=#list,1,-1 do
rect(x1+k-1,y1+k-1,x2-k+1,y2-k+1,list[k])
batch_call(pset,[[2]],x1+k,y1+k,x2-k,y2-k,list[k])
end
batch_call(pset,[[2]],x1,y1,x2,y2,list[k])
end
function outline_helper(flip,coord,dim)
coord=coord-dim*4
if flip then
return dim*8-1+coord,0xffff
else
return coord,1
end
end
function spr_out(sind,x,y,sw,sh,xf,yf,col)
sw,sh=sw or 1,sh or 1
local ox,x_mult=outline_helper(xf,x,sw)
local oy,y_mult=outline_helper(yf,y,sh)
foreach(g_out_cache[""..sind],function(r)
rectfill(
ox+x_mult*r[1],
oy+y_mult*r[2],
ox+x_mult*r[3],
oy+y_mult*r[4],
col)
end)
end
function tprint(str,x,y,c1,c2)
for i=-1,1 do
for j=-1,1 do
zprint(str,x+i,y+j,0,1,1)
end
end
zprint(str,x,y,0,c1,c2)
end
function zprint(str,x,y,align,fg,bg)
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
batch_call(print,[[3]],str,x,y,y+1,fg,bg)
end
function zclip(x1,y1,x2,y2)
clip(x1,y1,x2+1-flr(x1),y2+1-flr(y1))
end
function zcls(col)
batch_call(rectfill,[[4]],col or 0)
end
g_fadetable=gun_vals([[5]])
function fade(i)
for c=0,15 do
pal(c,g_fadetable[c+1][min(flr(i+1),7)])
end
end
function item_check_being_held(a)
if not a.being_held then a.alive=false end
pause_energy()
end
function sword_hit(a,o)
if o!=a.rel_actor then
a.poke=a.poke_val
if a.tl_cur!=1 then use_energy(a.energy)end
change_cur_ma(o)
call_not_nil(o,"hurt",o,a.hurt_amount,30)
end
a:bash(o)
end
function sword_shield_u2(a)
item_check_being_held(a)
end
G_INTERACT=5
function create_inventory_items()
if not g_items_drawn then
sfx"3"
g_item_selector=g_att.item_selector(g_pl)
g_items_drawn={}
for ind=1,9 do
local item=g_items[ind]
item.enabled=zdget(item.mem_loc)
g_items_drawn[ind]=g_att.inventory_item(g_pl,item.xoff/8,item.yoff/8,
item.enabled,item.flippable,item.sind)
end
end
end
function destroy_inventory_items()
foreach(g_items_drawn,function(a)a.alive=false end)
if g_item_selector then
sfx"4"
g_item_selector.alive=false
end
g_item_selector=nil
g_items_drawn=nil
g_pl.outline_color=1
end
function enable_item(index)
g_items[index].enabled=true
end
function inventory_init()
g_items=gun_vals[[6]]
zdset(9)
g_selected=G_INTERACT
end
function gen_pl_item(pl)
return get_selected_item()and call_not_nil(g_att,get_selected_item().name,pl)
end
function get_selected_item(ind)
local item=g_items[ind or g_selected]
return item.enabled and item or g_items[5]
end
function inventory_update()
local item=get_selected_item()
if not is_game_paused"tbox"and not g_menu_open and btn"5"then
g_selected=G_INTERACT
end
g_menu_open=not is_game_paused"tbox"and btn"5"
if g_pl.item and g_pl.item.banjo then
g_menu_open=false
end
if g_menu_open and not btn"5"then
if not get_selected_item()then
g_selected=G_INTERACT
end
end
if g_menu_open then
create_inventory_items()
if g_pl.item then g_pl.item.being_held=false end
else
destroy_inventory_items()
end
end
g_card_fade=0
function isorty(t)
if t then
for n=2,#t do
local i=n
while i>1 and t[i].y<t[i-1].y do
t[i],t[i-1]=t[i-1],t[i]
i=i-1
end
end
end
end
function load_room(new_room_index,rx,ry,follow_actor)
reload(0x1000,0x1000,0x2000)
g_cur_room_index=new_room_index
g_cur_room=g_rooms[new_room_index]
switch_song(g_cur_room.m)
acts_loop("confined","delete")
if follow_actor then
follow_actor.x=rx+g_cur_room.x
follow_actor.y=ry+g_cur_room.y
end
if g_cur_room.i then g_cur_room.i()end
g_view=g_att.view(min(14,g_cur_room.w),min(12,g_cur_room.h),2,follow_actor)
g_left_ma_view=g_att.view(2.75,3,0,follow_actor)
g_right_ma_view=g_att.view(2.75,3,0,nil)
acts_loop("view","center_view")
end
function room_update()
if not is_game_paused()and g_cur_room then
local dir=nil
if g_pl.y>g_cur_room.y+g_cur_room.h-.375 then dir="d"
elseif g_pl.y<g_cur_room.y+.5 then dir="u"
elseif g_pl.x>g_cur_room.x+g_cur_room.w-.375 then dir="r"
elseif g_pl.x<g_cur_room.x+.5 then dir="l"
end
if dir!=nil and g_cur_room[dir]then
transition(g_cur_room[dir][1],g_cur_room[dir][2],g_cur_room[dir][3],g_pl)
end
end
end
function change_cur_ma(a)
g_right_ma_view:change_ma(a)
end
function get_cur_ma()
return g_right_ma_view.follow_act
end
function draw_ma(view,x,y,a)
local old_view=g_view
g_view=view
map_and_act_draw(x/8-1/8,y/8,[[7]])
g_view=old_view
end
function draw_bar(x1,y1,x2,y2,num,dem,align,fg,bg)
if x1>x2 then x1-=3 x2-=3 end
local bar_off=x2-x1-min(num/dem,1)*(x2-x1)
if align==0 then bar_off/=2 end
if num>0 then
batch_call(rectfill,[[8]],x1,y1,x2,y2,
ceil(x1+(align>=0 and bar_off or 0)),
flr(x2-(align<=0 and bar_off or 0)),
fg,bg)
end
end
function draw_stat(x,y,align,view)
local yo=10*align
local a=view.follow_act
if a and a.alive then
if a.name then
zprint(a.name,x-yo,y-10,align,7,5)
end
draw_ma(view,x,y,a)
if a.hurtable then
draw_bar(x-yo,y-2,x-yo-35*align,y+1,a.health,a.max_health,-1,11,3)
zprint(
a.max_health<0 and "???/???"or flr(a.health).."/"..a.max_health,
x-yo,y+4,align,7,5
)
elseif a.costable then
draw_money(x-yo,y+4,align,a.cost)
end
end
end
function get_money_str(money)
local new_str="0"..money
return sub(new_str,#new_str-1,#new_str)
end
function draw_money(x,y,align,amount)
zprint("$"..get_money_str(amount),x,y,align,7,5)
end
function draw_status()
local x=48
local y=106
draw_money(x,y+13,-1,g_money)
draw_bar(10,3,117,7,g_energy,100,0,8,2)
batch_call(draw_stat,[[9]],g_left_ma_view,g_right_ma_view)
end
function destroy_effect(a,num,...)
for i=1,num do
g_att.thing_destroyed(a,rnd_item(...),rnd(.5)+.1)
end
end
function destroy_func(a)
g_att.money(a.x,a.y,a.dx,a.dy)
end
g_save_spots=gun_vals([[10]])
g_logo=gun_vals([[11]],function(a)
local logo=a.logo
local logo_opacity=8+cos(logo.tl_tim/logo.tl_max_time)*4-4
fade(logo_opacity)
camera(logo_opacity>1 and rnd_one())
zspr(192,logo.x,logo.y,4,2)
fade"0"
camera()
end
)
function transition(new_room_index,room_x,room_y,follow_actor)
g_att.fader_out(function()
pause"transitioning"
end,function()
load_room(new_room_index,room_x,room_y,follow_actor)
g_att.fader_in(tbox_clear,unpause)
end)
end
function amov_to_actor(a1,a2,spd,off_x,off_y)
off_x=off_x or 0
off_y=off_y or 0
if a1 and a2 then
amov_to_point(a1,spd,a2.x+off_x,a2.y+off_y)
end
end
function amov_to_point(a,spd,x,y)
local ang=atan2(x-a.x,y-a.y)
a.ax,a.ay=spd*cos(ang),spd*sin(ang)
end
function do_actors_intersect(a,b)
return abs(a.x-b.x)<a.rx+b.rx
and abs(a.y-b.y)<a.ry+b.ry
end
function does_a_contain_b(a,b)
return b.x-b.rx>=a.x-a.rx
and b.x+b.rx<=a.x+a.rx
and b.y-b.ry>=a.y-a.ry
and b.y+b.ry<=a.y+a.ry
end
g_cur_enemy_timer=nil,0
function add_money(amount)
g_money=min(g_money+amount,99)
zdset(3,g_money)
end
function remove_money(amount)
if g_money-amount>=0 then
g_money-=amount
zdset(3,g_money)
return true
end
end
function energy_update(refresh_rate)
if g_energy_tired and g_energy<=0 then
g_energy_tired=false
end
if g_energy_amount>0 then
g_energy_amount=max(0,g_energy_amount-1)
g_energy=g_energy+1
elseif not g_energy_pause then
g_energy=max(0,g_energy-refresh_rate)
end
if g_energy>=100 then
g_energy_tired=true
end
g_energy_pause=false
end
function pause_energy()
g_energy_pause=true
end
g_energy,g_energy_tired,g_energy_amount,g_energy_stop=0,false,0,false
function use_energy(amount)
g_energy_amount+=amount
end
g_tbox_messages,g_tbox_anim,g_tbox_max_len={},0,25
function tbox_interact()
if g_tbox_active then
g_tbox_anim+=.5
pause"tbox"
g_tbox_writing=g_tbox_anim<#g_tbox_active.l1+#g_tbox_active.l2
if not g_tbox_writing then
g_tbox_anim=#g_tbox_active.l1+#g_tbox_active.l2
end
if g_tbox_writing then
sfx"0"
end
if btnp"4"and g_tbox_anim>.5 then
g_tbox_update=true
end
end
end
function tbox_with_obj(a)
g_tbox_messages.trigger=a.trigger or nf
for i=1,#a do
if i%2==1 then
add(g_tbox_messages,{l1=a[i],l2=""})
else
g_tbox_messages[#g_tbox_messages].l2=a[i]
end
end
g_tbox_active=g_tbox_messages[1]
end
function tbox(...)
tbox_with_obj(gun_vals(...))
end
function _g.tbox_closure(obj)
return function()
tbox_with_obj(obj)
end
end
function ttbox_draw(x,y)
if g_tbox_active then
camera(-x,-y)
rectfill(-1,0,105,19,0)
zrect(-1,0,105,19,[[12]])
batch_call(zprint,[[13]],
sub(g_tbox_active.l1,1,g_tbox_anim),
sub(g_tbox_active.l2,0,max(g_tbox_anim-#g_tbox_active.l1,0))
)
if not g_tbox_writing then
spr(38,100,ti(.6,.3)and 13 or 14)
end
camera()
end
end
function tbox_clear()
g_tbox_messages,g_tbox_anim,g_tbox_active={},0,false
end
function coll_tile_help(pos,per,spd,pos_rad,per_rad,dir,a,hit_func,solid_func)
local coll_tile_bounds=function(pos,rad)
return flr(pos-rad),-flr(-(pos+rad))-1
end
local pos_min,pos_max=coll_tile_bounds(pos+spd,pos_rad)
local per_min,per_max=coll_tile_bounds(per,per_rad)
for j=per_min,per_max do
if spd<0 and solid_func(pos_min,j)then
hit_func(a,dir)
return pos_min+pos_rad+1,0
elseif spd>0 and solid_func(pos_max,j)then
hit_func(a,dir+1)
return pos_max-pos_rad,0
end
end
return pos,spd
end
function spr_and_out(...)
spr_out(...)
zspr(...)
end
function draw_logo(a)
camera(-a.x*8,-a.y*8)
batch_call(tprint,[[14]]
)
for i=-2,2 do
spr_and_out(226+i,i*10,sgn(cos(t()/2+i/4))/2+1,1,2,false,false,1)
end
if ti(1,.5)then
batch_call(tprint,[[15]])
end
camera()
end
g_title=gun_vals([[16]],function(a)
fade(g_card_fade)
map_draw(a.x,a.y,[[7]])
fade"0"
draw_logo(a)
end,function(a)
batch_call(acts_loop,[[17]])
if btnp"4"or btnp"5"then
a.outer.tl_loop=false
return true
end
end,function(a)
transition(flr_rnd"20"+1,0,0,g_att.title_move())
end,function(a)
batch_call(acts_loop,[[18]])
g_att.fader_out(
function()pause"transitioning" end,
function()a.tl_next=true end)
end,function(a)
fade(g_card_fade)
map_draw(a.x,a.y,[[7]])
draw_logo(a)
fade"0"
end,function(a)
batch_call(acts_loop,[[17]])
end,function(a)
g_card_fade=0
g_att.fader_out(
nf,function()a.tl_next=true end
)
end,function(a)
g_card_fade=8
load_room(flr_rnd"20"+1,0,0,g_att.title_move())
g_att.fader_in(
function()
pause"transitioning"
end,function()
a.tl_next=true
unpause()
end
)
end,function(a)
fade(g_card_fade)
draw_logo(a)
fade"0"
end
)
function update_view_helper(view,xy,wh,ii)
local follow_coord=view.follow_act and(view.follow_act[xy]+view.follow_act[ii]/8)or 0
local view_coord=view[xy]
local view_dim=view[wh]
local room_dim=g_cur_room[wh]/2-view_dim/2
local room_coord=g_cur_room[xy]+g_cur_room[wh]/2
local follow_dim=round(view.follow_dim*8)/8
if follow_coord<view_coord-follow_dim then view_coord=follow_coord+follow_dim end
if follow_coord>view_coord+follow_dim then view_coord=follow_coord-follow_dim end
if view_coord<room_coord-room_dim then view_coord=room_coord-room_dim end
if view_coord>room_coord+room_dim then view_coord=room_coord+room_dim end
if g_cur_room[wh]<=view[wh]then view_coord=room_coord end
view[xy]=view_coord
end
function scr_x(x)return round((x+g_view.off_x+8-g_view.x)*8)end
function scr_y(y)return round((y+g_view.off_y+8-g_view.y)*8)end
function scr_pset(x,y,c)
pset(scr_x(x),scr_y(y),c)
end
function scr_rect(x1,y1,x2,y2,col)
rect(scr_x(x1),scr_y(y1),scr_x(x2)-1,scr_y(y2)-1,col)
end
function scr_rectfill(x1,y1,x2,y2,col)
rectfill(scr_x(x1),scr_y(y1),scr_x(x2),scr_y(y2),col)
end
function scr_map(cel_x,cel_y,sx,sy,...)
map(cel_x,cel_y,scr_x(sx),scr_y(sy),...)
end
function scr_circfill(x,y,r,col)
circfill(scr_x(x),scr_y(y),r*8,col)
end
function scr_circ(x,y,r,col)
circ(scr_x(x),scr_y(y),r*8,col)
end
g_rooms=gun_vals[[19]]
g_room_template=gun_vals[[20]]
function map_init()
for k,v in pairs(g_rooms)do
local qx,qy=flr(k/10%4),flr(k/40)
local template=g_room_template[k%10]
v.x,v.y=template.x+qx*32,template.y+qy*32
v.w,v.h=v.w or template.w,v.h or template.h
v.i=function()
batch_call_table(function(att_name,x,y,...)
g_att[att_name](v.x+x+.5,v.y+y+.5,...)
end,v)
acts_loop("act","room_init")
end
end
end
create_parent(
[[21]],function(a)
if a.alive and a.stun_countdown<=0 then
if tl_node(a,a)then
a.alive=false
end
elseif a.stun_countdown>0 then
a.stun_countdown-=1
end
end,function(a)
if not a.alive then
a:destroyed()
a:delete()
end
end,function(a)
a.alive=nil
end,del_act,function(a,...)
local arr,cur_act=gun_vals(...),a
for i=1,#arr do
cur_act=cur_act[arr[i]]
if not cur_act then
break
end
end
return cur_act
end)
create_parent[[22]]
create_parent[[23]]
create_parent([[24]],function(a)
if a.x+a.dx<g_cur_room.x+.5 then
a.x=g_cur_room.x+.5
a.dx=0
end
if a.x+a.dx>g_cur_room.x+g_cur_room.w-.5 then
a.x=g_cur_room.x+g_cur_room.w-.5
a.dx=0
end
if a.y+a.dy<g_cur_room.y+.5 then
a.y=g_cur_room.y+.5
a.dy=0
end
if a.y+a.dy>g_cur_room.y+g_cur_room.h-.5 then
a.y=g_cur_room.y+g_cur_room.h-.5
a.dy=0
end
end)
create_parent(
[[25]],function(a)
a.t+=1
end)
create_parent(
[[26]]
)
create_parent(
[[27]],function(a)
a.x+=a.dx
a.y+=a.dy
end)
create_parent(
[[28]],function(a)
a.dx+=a.ax a.dy+=a.ay
a.dx*=a.ix a.dy*=a.iy
if a.ax==0 and abs(a.dx)<.01 then a.dx=0 end
if a.ay==0 and abs(a.dy)<.01 then a.dy=0 end
end,function(a)
a.ax,a.ay,a.dx,a.dy=0,0,0,0
end)
create_parent[[29]]
create_parent(
[[30]],function(a)
scr_rect(a.x-a.rx,a.y-a.ry,a.x+a.rx,a.y+a.ry,8)
end)
create_parent(
[[31]],function(a)
local a2=a.rel_actor
if a2 then
if a2.alive then
a.x,a.y=a2.x+a.rel_x,a2.y+a.rel_y
a.dx,a.dy=a2.dx+a.rel_dx,a2.dy+a.rel_dy
a.rel_x+=a.rel_dx
a.rel_y+=a.rel_dy
a.xx,a.yy=a2.xx,a2.yy
if a.flippable then
a.xf=a2.xf
end
else
a.alive=false
end
end
end)
create_parent(
[[32]],function(a)
a.xx,a.yy=0,0
end)
create_parent[[33]]
create_parent[[34]]
create_parent[[35]]
create_parent(
[[36]],scr_spr,scr_out,scr_spr_and_out
)
create_parent(
[[37]],scr_spr_and_out)
create_parent(
[[38]],function(a,speed,xdir,ydir)
a.dx=xdir*speed
a.dy=ydir*speed
end)
create_parent(
[[39]],function(a)
if a.stun_countdown>0 then
a.ay,a.ax=0,0
a.xx=rnd_one()
end
end)
create_parent(
[[40]],function(a,damage,stun_val)
if a.max_health>=0 and a.stun_countdown<=0 then
a.stun_countdown=stun_val
a.health=min(a.max_health,a.health-damage)
if a.health<=0 then a.alive=false end
a:hurt_func()
end
end)
create_parent(
[[41]],function(a)
if a.anim_sind then
a.sind=a.anim_sind
else
if a.t%a.anim_spd==0 then
a.anim_off+=1
a.anim_off%=a.anim_len
end
a.sind=a.sinds[a.anim_loc+a.anim_off]or 0xffff
end
end)
create_parent(
[[42]])
create_parent(
[[43]],function(a,b)
if does_a_contain_b(a,b)then
a:contains(b)
elseif do_actors_intersect(a,b)then
a:intersects(b)
else
a:not_contains_or_intersects(b)
end
end)
create_parent(
[[44]],function(a,acts)
local hit_list={}
local move_check=function(dx,dy)
local ret_val=dx+dy
local col_help=function(axis,spd_axis,a,b,pos,spd)
if spd!=0 and pos<abs(a[axis]-b[axis])then
if a.touchable and b.touchable then
local s_f=function(c)
if not c.static then
c[spd_axis]=(a[spd_axis]+b[spd_axis])/2
end
end
s_f(a)s_f(b)
ret_val=0
end
hit_list[b][spd_axis]=zsgn(spd)
end
end
foreach(acts,function(b)
if a!=b and(not a.static or not b.static)then
local x,y=abs(a.x+dx-b.x),abs(a.y+dy-b.y)
if x<a.rx+b.rx and y<a.ry+b.ry then
hit_list[b]=hit_list[b]or gun_vals[[45]]
batch_call(col_help,[[46]],a,b,x,dx,y,dy)
end
end
end)
return ret_val
end
a.dx=move_check(a.dx,0)
a.dy=move_check(0,a.dy)
for b,d in pairs(hit_list)do
a:hit(b,d.dx,d.dy)
end
end)
create_parent(
[[47]],function(a,solid_func)
local x,dx=coll_tile_help(a.x,a.y,a.dx,a.rx,a.ry,0,a,a.tile_hit,solid_func)
local y,dy=coll_tile_help(a.y,a.x,a.dy,a.ry,a.rx,2,a,a.tile_hit,function(y,x)return solid_func(x,y)end)
if a.tile_solid then
a.x,a.y,a.dx,a.dy=x,y,dx,dy
end
end)
create_parent(
[[48]],function(a)
if is_game_paused"dancing"then
a.dance_time=cos(t()-a.initial_time)
if a.initial_xf then
a.xf=a.dance_time>0
else
a.xf=a.dance_time<0
end
end
end,function(a)
a.initial_xf=a.xf
a.initial_time=t()
end)
create_parent(
[[49]],function(a)
a.trig=g_att.gen_trigger_block(a,a.trig_x,a.trig_y,a.trig_rx,a.trig_ry,nf,function(trig,other)
if npc_able_to_interact(a,other)then
change_cur_ma(a)
if able_to_interact(a,other)then
a:interactable_trigger()
end
else
if get_cur_ma()==a then
change_cur_ma()
end
end
end)
end)
create_parent(
[[50]],look_at_pl)
create_parent(
[[51]],function(a,o)
if o!=a.rel_actor then
call_not_nil(o,"knockback",o,a.bash_dx,bool_to_num(a.xf),0)
if a.rel_actor then
call_not_nil(a.rel_actor,"knockback",a.rel_actor,a.rel_bash_dx,bool_to_num(a.xf),0)
end
end
end
)
create_parent(
[[52]],function(a)
if a==a.rel_actor.item then a.rel_actor.item=nil end
end)
create_parent(
[[53]],function(a)
a.xf=a.rel_actor.xf
a.ixx=a.xf and a.poke_ixx or-a.poke_ixx
use_energy(a.poke_energy)
end,function(a)
local spd=a.poke_dist/a.tl_max_time/60
a.rel_dx=bool_to_num(a.xf)*spd
pause_energy()
end,function(a)
a.rel_dx=0
a.rel_x=a.xf and-a.poke_dist or a.poke_dist
end
)
create_parent(
[[54]],function(a)
if remove_money(a.cost)then
a:kill()
g_att.item_show(g_pl,a.sind,a.mem_loc)
pause"chest"
stop_music"1"
else
sfx"7"
end
end
)
create_parent(
[[55]],function(a)
if zdget(a.mem_loc)==a.mem_loc_expect then
a:delete()
end
end
)
create_actor([[56]],[[57]],function(a)
a.x,a.y=a.rel_actor.x,a.rel_actor.y
a.xf=a.rel_actor.xf
a.ax=bool_to_num(a.xf)*.1
use_energy(10)
end,function(a,other)
if not other.pl and other.touchable and not a.did_brang_hit then
call_not_nil(other,"knockback",other,.3,a.xf and-1 or 1,0)
call_not_nil(other,"hurt",other,0,60)
a.did_brang_hit=true
end
end,function(a)
pause_energy()
end,function(a,other)
if other.pl then
a.alive=false
elseif other.touchable and not a.did_brang_hit then
call_not_nil(other,"knockback",other,.3,a.xf and-1 or 1,0)
call_not_nil(other,"hurt",other,0,60)
a.did_brang_hit=true
end
end,function(a)
pause_energy()
a.ax=xbtn()*.05
a.ay=ybtn()*.05
return not a.being_held or a.did_brang_hit
end,function(a,other)
if other.pl then
a.alive=false
elseif other.touchable and not a.did_brang_hit then
if other.knockable then
other.knockback(other,.05,a.xf and-1 or 1,0)
end
a.did_brang_hit=true
end
end,function(a)
pause_energy()
amov_to_actor(a,a.rel_actor,.1)
end,function(a)
if a.did_brang_hit then
card_shake(9)
end
end,function(a)
a.did_brang_hit=true
end
)
create_actor([[58]],[[59]],function(a)
a.rel_y=0
a.xf=a.rel_actor.xf
poke(0x5f41,15)
if zdget(36)then
sfx"11"
else
sfx"10"
end
pause("dancing")
end,function(a)
unpause()
poke(0x5f41,0)
end
)
create_actor([[60]],[[61]],sword_hit,sword_shield_u2)
create_actor([[62]],[[63]],function(a,other)
if other!=a.rel_actor and a.tl_cur<3 then
call_not_nil(other,"hurt",other,0,30)
end
a:bash(other)
end,sword_shield_u2)
create_actor([[64]],[[65]],function(a)
local x,y=(g_selected-1)%3,flr((g_selected-1)/3)
x+=xbtnp()
y+=ybtnp()
x,y=max(0,min(x,2)),max(0,min(y,2))
local next_selected=y*3+x+1
if g_selected!=next_selected then
g_items_drawn[g_selected].selected=false
g_items_drawn[next_selected].selected=true
end
g_selected=next_selected
a.rel_x=(x-1)*1.5
a.rel_y=(y-1.25)*1.5
end
)
create_actor([[66]],[[67]],function(a)
a.draw_both=a.enabled and scr_spr_and_out or function(a)
scr_rectfill(a.x+a.xx/8-.125,a.y+a.yy/8-.125,a.x+a.xx/8,a.y+a.yy/8,a.outline_color)
end
end,function(a)
a.outline_color=a.selected and 2 or 1
end
)
create_actor([[68]],[[69]],function(a)
g_card_fade=max(a.timeline.tl_tim/a.timeline.tl_max_time*10,g_card_fade)
end)
create_actor([[70]],[[69]],function(a)
g_card_fade=min((a.timeline.tl_max_time-a.timeline.tl_tim)/a.timeline.tl_max_time*10,g_card_fade)
end)
create_actor([[71]],[[72]])
create_actor([[73]],[[74]],
function(a)
batch_call(update_view_helper,[[75]],a)
end,function(a)
if a.follow_act then
a.x,a.y=a.follow_act.x,a.follow_act.y
end
a:update_view()
end,function(a,ma)
a.follow_act=ma
a.tl_next=ma and ma.timeoutable and 2 or 1
end)
create_actor([[76]],[[77]],function(a)
look_at_pl(a)
a.ixx=rnd_one()
end,function(a)
amov_to_actor(a,g_pl,.05)
a.iyy+=sin(a.tl_tim/a.tl_max_time)
a.sind=119
end,function(a)
a[1].tl_max_time=rnd(2)+1
a.ax,a.ay=0,0
end,function(a)
a.ixx=0 a.iyy=-2
a.sind=118
end,function(a,other,...)
call_not_nil(other,"knockback",other,.4,...)
end,look_at_pl)
create_actor([[78]],[[79]],function(a,other,...)
call_not_nil(other,"knockback",other,.3,...)
if other.pl then
other.hurt(other,2,30)
end
end,function(a)
a.ax,a.ay=0,0
a.anim_off=0
end,look_at_pl,
function(a)
amov_to_actor(a,g_pl,.06)
end,function(a)
a.anim_off=1
end,function(a)
destroy_effect(a,30,1,4,5,2)
g_att.money(a.x,a.y,a.dx,a.dy)
end,function(a)
a.tl_next=2
change_cur_ma(a)
end)
create_actor([[80]],[[81]],function(a)
a.ax,a.ay=rnd_one(.01),rnd_one(.01)
a.xf=a.ax<0
end,destroy_func
)
create_actor([[82]],[[83]],function(a)
change_cur_ma(a)
end,function(a)
if do_actors_intersect(a,g_pl)then
if g_pause_reason=="dancing"then
if zdget"36"then
memcpy(0x5e00,0x5d00,64)
tbox[[84]]
else
sfx"7"
tbox[[85]]
end
end
end
end,function(a)
if get_cur_ma()==a then
change_cur_ma()
end
end)
create_actor([[86]],[[87]],function(a)
tbox_with_obj(a.text_obj)
end)
create_actor([[88]],[[89]],function(a)
tbox_with_obj(a.text_obj)
end)
create_actor([[90]],[[91]])
create_actor([[92]],[[93]])
create_actor([[94]],[[95]],function(a)
unpause()
resume_music()
zdset(a.mem_loc)
end
)
create_actor([[96]],[[97]],function(a)
a.tl_next=zdget(a.mem_loc)
a.trig_x=a.xf and-.125 or.125
a:interactable_init()
end,function(a)
a.tl_next=true
pause"chest"
stop_music"1"
a.item_show=g_att.item_show(g_pl,1,a.mem_loc)
end
)
create_actor([[98]],[[99]],function(a)
if get_cur_ma()==a.rel_actor then
change_cur_ma()
end
end
)
create_actor([[100]],[[101]],function(a)
a.b1=g_att.static_block(a.x-.75,a.y,.25,.5)
a.b2=g_att.static_block(a.x+.75,a.y,.25,.5)
a.b3=g_att.static_block(a.x,a.y-4/8,1,.25)
a.trig=g_att.gen_trigger_block(a,0,1/8,.5,5/8,function(trig,other)
if other.pl then
transition(a.room,a.room_x,a.room_y,g_pl)
end
end,nf)
end,function(a)
a.b1.alive,a.b2.alive,a.b3.alive,a.trig.alive=false
end
)
create_actor([[102]],[[103]],
function(a,other)
if other.pl then
add_money"1"
a.alive=false
end
end,function(a)
a.alive=false
end,function(a)
destroy_effect(a,9,1,6,7,13,12)
end)
create_actor([[104]],[[105]]
)
create_actor([[106]],[[107]],function(a)
local p=a.parent
a.x=p.x+p.ixx/8+rnd(.25)-.125
a.y=p.y+p.iyy/8+rnd(.25)-.125
a.dx=p.dx
a.dy=p.dy
end,function(a)
scr_pset(a.x,a.y,a.c)
end)
create_actor([[108]],[[109]],function(a)
a.ax=bool_to_num(a.xf)*.04
end,function(a)
a.iyy=-cos(a.tl_tim/a.tl_max_time/4)*8
end,function(a)
sfx"9"
destroy_effect(a,10,1,13,12)
g_att.money(a.x,a.y,a.dx,a.dy)
end,function(a,o)
if o.touchable and not o.pl then
call_not_nil(o,"hurt",o,0,60)
call_not_nil(o,"knockback",o,.6,bool_to_num(a.xf),0)
a.tl_next=true
end
end,function(a)
a.tl_next=true
end)
create_actor([[110]],[[111]],function(a)
g_att.gen_trigger_block(a,0,0,.5,.5,nf,function(trig,other)
if btnp(4)and not other.item then
other.item=g_att.grabbed_item(g_pl,a.sind,-7,function(x,y,xf)
g_att.pot_projectile(other.x,other.y,xf)
end)
a:kill()
end
end)
end
)
create_actor([[112]],[[113]])
create_actor([[114]],[[115]])
create_actor([[116]],[[117]],function(a)
if(a.tl_tim+a.offset)%1<.75 then
a.sind=54
else
a.sind=53
end
end,function(a,o)
if a.sind==53 then
call_not_nil(o,"hurt",o,1,15)
end
end)
create_actor([[118]],[[119]],function(a)
if zdget"6"then
tbox[[120]]
elseif zdget"8"then
tbox[[121]]
else
tbox[[122]]
end
end
)
create_actor([[123]],[[124]],function()
if zdget"36"then
tbox[[125]]
else
tbox[[126]]
end
end,function(a)
if g_pause_reason=="dancing"then
change_cur_ma(a)
if not zdget"36"then
tbox[[127]]
else
tbox[[128]]
end
end
end
)
create_actor([[129]],[[130]])
create_actor([[131]],[[132]])
create_actor([[133]],[[134]],function()
if zdget"34"then
tbox[[135]]
else
tbox[[136]]
end
end)
create_actor([[137]],[[138]])
create_actor([[139]],[[140]],function(a)
a.xf,a.alive=g_pl.xf,g_pl.alive
if g_pl:get[[141]]then
a.sind=g_pl.item.throwing and 150 or 148
else
a.sind=147
end
end,function(a)
if is_game_paused"dancing"then
a.dance_update(a)
a.sind=abs(a.dance_time)>.5 and 149 or 147
elseif is_game_paused"chest"then
a.sind=148
end
end
)
create_actor([[142]],[[143]],function(a)
if btnp"4"or btn"5"then
sfx"6"
a.create_func(a.x,a.y+a.iyy/8,a.xf)
return true
end
end,function(a)
sfx"5"
end)
create_actor([[144]],[[145]],function(a)
local act=get_cur_ma()or a.rel_actor
local dist=abs(a.x-act.x)+abs(a.y-act.y)
amov_to_actor(a,act,dist*.025,a.off_x,a.off_y)
a.off_x=cos(a.tl_tim*.5)
a.off_y=sin(a.tl_tim*.5)-.25
a.xf=a.dx<0
destroy_effect(a,1,a.fg,a.bg)
if flr(a.tl_tim/10)%2==0 then
a.off_x=-a.off_x
end
end,function(a)
scr_circfill(a.x,a.y,.125,a.fg)
end,function(a)
a.x=a.rel_actor.x
a.y=a.rel_actor.y
end)
create_actor(
[[146]],[[147]],function(a)
a.ltop=g_att.lank_top(a)
end,function(a)
if a.stun_countdown==0 then
if not btn"5"then
if(xbtn()!=0)and not a:get[[148]]then a.xf=btn"0" end
a.ax,a.ay=xbtn()*a.spd,ybtn()*a.spd
if g_debug then
a.ax*=3
a.ay*=3
a.touchable=false
else
a.touchable=true
end
else
a.ax=0 a.ay=0
end
end
if a:get[[149]]then
a.ax,a.ay=0,0
end
if not btn"5"and not a.item and btnp"4"then
if not get_selected_item().interact then
if g_energy_tired then
sfx"7"
else
a.item=gen_pl_item(a)
sfx"5"
end
end
end
local item=a.item
if item then
if not item.alive then
a.item=nil
end
if not btn"4"and not btn"5"then
item.being_held=false
end
a.ax*=.5 a.ay*=.5
end
a.anim_len=abs(a.dx)+abs(a.dy)>0 and 3 or 1
if a.stun_countdown!=0 and a.item then
a.item.xx=a.xx
end
end,function(a)
if a.item then a.item.alive=false end
end,function(a)
scr_spr_and_out(a,a.ltop,a.item)
end,function(a)
a:i()
a.lanks_fairy,a.room_init=g_att.fairy(a)
end,function(a,color)
a.outline_color,a.ltop.outline_color=color,color
end)
memset(0x05d00,0,0x100)
cartdata("zeldo_test5")
memcpy(0x5d00,0x5e00,64)
g_debug=false
function _init()
g_money=zdget_value(3)
poke(0x5f34,1)
zdset(6)
map_init()
local tl_game=gun_vals([[150]],function()
pause"transitioning"
g_att.fader_in(game_init,unpause)
end,game_update,game_draw)
g_tl={g_title,tl_game}
inventory_init()
end
function _update60()
if g_debug then
poke(0x5f42,15)
else
poke(0x5f42,0)
end
if g_tbox_update then
sfx"2"
if g_tbox_writing then
g_tbox_anim=#g_tbox_active.l1+#g_tbox_active.l2
else
del(g_tbox_messages,g_tbox_active)
g_tbox_active,g_tbox_anim=g_tbox_messages[1],0
end
if not g_tbox_active then
unpause()
g_tbox_messages.trigger()
end
g_tbox_update=false
end
if btnp"5"and btn"4"then
g_debug=not g_debug
end
tl_node(g_tl,g_tl)
tbox_interact()
end
function _draw()
cls()
call_not_nil(g_tl,"d",g_tl)
end
function game_update()
room_update()
if not is_game_paused()then
inventory_update()
batch_call(
acts_loop,[[151]],
g_act_arrs["col"],
function(x,y)
return x>=g_cur_room.x and x<g_cur_room.x+g_cur_room.w and
y>=g_cur_room.y and y<g_cur_room.y+g_cur_room.h and
fget(mget(x,y),6)
end,
g_pl,
g_act_arrs["wall"]
)
energy_update(.25)
if is_game_paused()then
g_pause_init=true
end
else
if g_pause_init then
g_pause_init=false
batch_call(acts_loop,[[152]])
end
batch_call(acts_loop,[[153]])
if not is_game_paused()then
batch_call(acts_loop,[[154]])
end
end
batch_call(acts_loop,[[155]])
card_shake_update()
end
g_card_shake_x=0
g_card_shake_y=0
g_card_shake_time=0
function card_shake_update()
if g_card_shake_time>0 then
g_card_shake_x=rnd_one()/8
g_card_shake_y=rnd_one()/8
g_card_shake_time-=1
else
g_card_shake_x,g_card_shake_y=0,0
end
end
function card_shake(fx)
if g_card_shake_time==0 then
sfx(fx)
g_card_shake_time=15
end
end
function map_draw(x,y,border_colors)
if g_view then
local rx=x-g_view.w/2
local ry=y-g_view.h/2
g_view.off_x=-(16-g_view.w)/2+rx
g_view.off_y=-(16-g_view.h)/2+ry
local x1,x2=rx*8,(rx+g_view.w)*8-1
local y1,y2=ry*8,(ry+g_view.h)*8-1
zclip(x1,y1,x2,y2)
zcls(g_cur_room.c)
scr_map(g_cur_room.x,g_cur_room.y,g_cur_room.x,g_cur_room.y,g_cur_room.w,g_cur_room.h)
isorty(g_act_arrs.drawable)
batch_call(acts_loop,[[156]])
if g_debug then acts_loop("dim","debug_rect")end
clip()
zrect(x1,y1,x2,y2,border_colors)
end
end
function map_and_act_draw(x,y,border_colors)
map_draw(x,y,border_colors)
end
function game_draw()
local x,y=8+g_card_shake_x,7+g_card_shake_y
fade(g_card_fade)
map_and_act_draw(x,y,[[7]])
if g_menu_open then
if g_selected==5 then g_pl:set_color"2" end
g_pl.d(g_pl)
g_pl:set_color"1"
end
acts_loop("inventory_item","draw_both")
draw_status()
ttbox_draw(2,105)
end
function game_init()
map_init()
g_pl=g_att.pl(0,0)
load_room(1,3,5,g_pl)
end
function pause(reason)
if reason=="dancing"or reason=="chest"then
mute_music()
end
stop_music()
g_pause_reason=reason g_game_paused=true
end
function unpause()resume_music()g_game_paused=false end
function is_game_paused(reason)
return g_game_paused and(reason==g_pause_reason or not reason)
end
function zdget_value(ind)
return peek(0x5d00+ind)
end
function zdget(ind)
return zdget_value(ind)>0
end
function zdset(ind,val)
return poke(0x5d00+ind,val or 1)
end
function mute_music()
sfx(63,0,0)
sfx(62,1,1)
end
function stop_music(sound)
poke(0x5f43,3)
if sound then
sfx(sound)
end
end
function resume_music(song)
switch_song(song)
poke(0x5f43,0)
sfx(63,-1)sfx(62,-1)
g_music_current=song or g_music_current
end
function switch_song(song)
if song and song ~=g_music_current then
g_music_current=song
music(song,500,3)
end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000001500111111110051015dcc6cccccd510c600c600050000501111111111111111
0000000000000000000000000000000000000000000000000000000000000000151128888882115111ddcc6cccccdd11000000000111111022d2d222222d2d22
0070070000600000000000000040000000eaa00000400000000d6000000dc000112882888828821115dccc6cc6cccd51600c600c21244212244d44244244d442
000770000006000000d000000004000000a000000005500000099000000d0c0012828882288828211d6cccccc6ccc6d10000000001444410244d44244244d442
0007700000006400009777000000470000a0000000052000000d9000000d0c0012828882288828211dccccccccccccd1c600c600019a00102445445445445442
007007000000440000d00000000077000000000000000000000d6000000dc000112882888828821115dccc6cc6cccd5100000000212442122245445445445422
0000000000000000000000000000000000000000000000000000000000000000151128888882115111dccc6cc6cccd11600c600c01111110f24544544544542f
0000000000000000000000000000000000000000000000000000000000000000150011111111005101d6ccccc6cc6d100000000005000050f24544544544542f
1111111111111111011111000000000000000000000000000500005000000000159999410000000000000000011111100000000000111100f24544544544542f
1994444115666651118991100000000000000000000000000511115000000000159aa9410000000000050000115333110011110011166111f24544544544542f
199999411665666119998910000aae000000000000000000211cc112004a70001599a9410000000000030000153b3b3111166111166666612245445445445422
149999911666566111a9911000000a0000000a0000a0000001c11c100000000015599941111111110003b00013b3b3b116dd6d611556ddd12445445445445442
14444991156666511511161000000a0000000a0000a0000001dcfd10000000001599944112499421005b30001c3bbb311d1111d61116d111244d44244244d442
1511115115555551155d661000000000000aae0000eaa000211dd11200000000159a9941149999410033cb001533b351d11001160016d1002442442442442442
111001111d1111d11555d6100000000000000000000000000511115000000000159aa9411499994100333b0011553511110000110115511022d2d222222d2d22
05000050111001111111111000000000000000000000000005000050000000001599994114444441003b33000112411000000000011111101111111111111111
0000000000000000000000000024d20000000000000000000000000001111110111111111524425100c333000000000001111000000000000222200000000000
0000770000000000000009a000d4d40000000000000000000000000011d66d1155555555123c5d21003b33300777776011d6d110006666000222222222000000
007777900d7777d000000990001111000000000000700700000111111d7777d199995999143c5d41053333c007d575601d666d10066666600242422222222220
00d7d78007d77d7000009000004d4d00000c70000007700000017771177777719aa999a9152442510333533007776660166666d1065555600444442424222220
07ddd700077dd7700a090000004d4d000006c0000007700000015751177777719a999aa912b136210035250007561560166666d1066666600244444444424240
007777000777777000900000002d420000000000007007000001151113666631999d999914b1364100042000066666601d666d51065565600111112444444440
0009000000000000090000000000000000000000000000000000111013333331dddddddd12222221000220000002400011ddd5110666666001aaa11111124420
000000000000000000000000000000000000000000000000000000001b3333b11111111111111111000000000000000001111111000000000aaaaaaaaa111110
000000000000000000000000249000000007000000000000000000001bbbbbb105000050050350500000000d0000200050000000000000000a979aaaaaaa9aa0
00333300000000000000000044a000000006070007000700000000001bbbbbb1050000500300002000b000000e00000000060000000006000a777aaaaaaaa9a0
03399900000cc00000244200440dd5000756550007070700060006001bbbbbb12225525222253222000000000000000000000000060077000a979a9119aaaa90
03fcfc0000c11c00004444002405dd000057766700070000000600001bbbbbb1020000500200005000000e000000000500000060770007700aaaa911119aaaa0
00ffff0000dcfd000000a9000000000076677500070000700000000013bbbb310500002005000020c00000000020000000000000077000760aaa91111119aaa0
03322530000dd00000244200002442000055657007007070060000601333333125255222222352220000000000000000010000000076007009aa11111111aa90
00253300000000000000000000000000007060000000700000006000111111110500005002000030000000b000000e000000000000700000009a11000011a900
00000000000000000000000000000000000070000000000000000000000000000500005005053050000c00005000000000000200000000000009000000009000
0045450003cbbbc000d6760000549400002882000028820004999a00004000000000000000000002000000080000500000000000000000000000000000000000
045a4a503bbbbbb300626200004242000282282008222280099f99a00a90cf000000005000222200000800200c05000500e00000070007000011111111111100
01144110cbbbb33b00d6660000544400025555500282282009f3f394a94fccad0000250002244220008002000000005000000e0000007e70015d67666676d510
54211245bbbc3a33005d6d0000254500055d5d500522225009efff00994fdc9c000252000242442008002000050c05000000efe00070070001d6766666676d10
444244443b2322305d65dd65254255420255552022555522f9cddccf944fdc9c0022200002442420000200205000000000900e0007e700000167666666667610
045425402322544200d665000054420022224222222222220dccccd09944cc4c00220000022442200020020000050c0509a900000070000001766dddddd66710
02124120025544420044a40000dd6d00522242250222222000499a0049999d0c02000000002222000200200000500000009000900000070001666deeeed66610
0004200005544000005005000020020004999940049999400ccccd000000f0000000000020000000800000000500050c000000000000000001666deeeed66610
0544445005444450005544000088882000666d0000666d0000666d00005555d001111111111111100111111111111110011111100000000001666d6666d66610
044fff40044fff40002554400881118206d5556006d5556006d555600554455d1155544444455511116667777776661111d666110cc00c0001666d777dd66610
05fffff054fffff000fdfd000811c1120d5959d00d5b5bd00d5858d00542425512222222222222211dddddddddddddd11d6767610000ccc001766ddddd666710
0ef2ff2044f2ff2000ffff0008811182005555000055550000555500004444d412222222222222211dddddddddddddd11676767107700cc00167666666667610
03effff002fffff0f533bbbf0888d82056a4596552b35c2556e258654d664d62155555555555555116666666666666611c6777610777000001d6766666676d10
fbbbbbbffeeeeeef00533b000288d22007aaaa7004bbbb4007eeee7005d66602154444444444445116777777777777611d6676d100700770015d67666676d510
03bbbb3002eeee2000544900028d6620404a9400303bc300202e820000288e05112244444444221111dd77777777dd1111dd6d11000000000011111111111100
005d05d0005d05d00020020002d66d0004a9400003bc300002e82000004004000111111111111110011111111111111001124110000000000000000000000000
005f7f0000cccc0003bbba0003bb3300002444200dbbba000d0000000000000011111111142254411111111117dd67710000000000000000dd676dd11dd676dd
05f2f2000cd667000bbfbba033344430024444420dd776a00dd776000000000045554444142252217666777717dd6dd10000000000000000d677dd1111dd77dd
0dfddd000cf4f4000bf3f3b035424200029999420b7272bb00727200000000002222222214225221dddddddd17dd6dd10070070000700700dd7dd111111dd76d
0d5d5d0000ffff000befff000044440009929290b367773000677700000000002222222214225221dddddddd17dd6dd10007700000077000d67d11111111d76d
fe8dd5eff5ddcccffb48288f42233bb40de999d0f487868f000706000000000055555555152252216666666616dd6dd10007700000077000d6dd11111111dd6d
088d5884055ddcc002888820035223b0dddd6ddd0248882000000000000000004442222415225441777dddd716dd67710070070000700700177d11000011d771
005222040024490000499a00003352009ddd6dd900499a0000000000000000004442222415225441777dddd716dd67710000000000000000116d10000001d611
02888e02005005000020020000d00d000677776000200200000000000000000011111111142254411111111117dd677100000000000000000111100000011110
0044440000042420000000000000000000000000000000000000000000000000011110000000000000070000b030303b3b30000bb030303bd6dddd6dd6dddd6d
044545400044a4a45005050500050500007770000000000000000000000000001124211002200200000000703bbbbbb000b300b33bbbbbb0ddd66dddddd66ddd
0244442000244442d55ddd55505ddd050eee7700007770000000000000ee77001244421000002220000000000b0000b3000b3b300b0000b36667766666677666
4224422444224422ddd2d2ddd5d2d2558eeee1700eee770000ee77000eeee1001444442105500220d00000003b09a0b0000333003b0b30b07776777676666667
4442244444452254d5dddd5ddddddddd8e1eee778eeee1700eeee1000e1eee70144444210555000000000c000b0990b3003b3b000b03b0b3d766676ddd6dd6dd
0444244004442440d0d5d50dd5d5d55d88ee11e78e1eee770e1eee7008ee1ee01244422100500550000000003b0000b003b003b03b0000b0111661117dd77dd7
054424500544245000500005d050000d8881eee788ee11e708ee1ee0088eeee01122221100000000007000000bbbbbb33b00003b0bbbbbb30011110077666677
0005500000055000000000000000000508888e708881eee7008eee000088880001111111000000000000000db303030bb3000003b303030b0000000066766766
0000000000000000000000000000000000000000000000000000000000000000f7f7f7f7f7f7f7f7f7f7f7f7c2c2c2c2c2c2c2c2c2c2c2c28182828282828282
0000000000000000000000000000000000000000000000000000000000000000d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7
0070070000700700007007000070070000700700007007000070070000700700f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c281a4a4a420a4a481
0007700000077000000770000007700000077000000770000007700000077000d700000000000000000000d7d700000000000000000000d7d7000000000000d7
0007700000077000000770000007700000077000000770000007700000077000f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c281a4a4a4a4a4a481
0070070000700700007007000070070000700700007007000070070000700700d700000000000000000000d7d700000000000000000000d7d7000000000000d7
0000000000000000000000000000000000000000000000000000000000000000f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c281a4a4a4a4a4a481
0000000000000000000000000000000000000000000000000000000000000000d700000000000000000000d7d700000000000000000000d700000000000000d7
00000000000000000000000003bb330003b9990003bb330003b9990000000000f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c281a436a4a426a481
0000000000000000000000003339995034fcfc403339995035fcfc000000000000000000000000000000000000000000000000000000000000000000000000d7
00000000000000000000000035fcfc0053efff3035fcfc0043efff0400700700f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c281a4a4a4a4a4a481
00000000000000000000000000efff00053ff35000efff00053ff35000077000000000000000000000000000000000000000000000000000d7000000000000d7
003525000035250000352500433325b400532500433325400053250000077000f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c281a4a4a4a4a4a481
0022530000225300002253000000000000000000000000000000000000700700d700000000000000000000d7d700000000000000000000d7d7000000000000d7
00533b0000533b0000533b000000000000000000000000000000000000000000f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28282828090828281
0040040000000400004000000000000000000000000000000000000000000000d700000000000000000000d7d700000000000000000000d7d7d7d7d7d7d7d7d7
ffffffffffffffff02ffffff0000000000000000000000000001111111111000f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28191828282829182
fdffffffffffffdf024ff9ff0002222200222200220000000011d667766d1100d700000000000000000000d7d700000000000000000000d78182828282828282
ffffffdfffffffff0029ffff00249ff9224ff422f4222200011ddd6666ddd110f7f7f7f7f7c0c0f7f7f7f7f7c2c2c2c2c2b4b4c2c2c2c2c28192117272119281
fffffffffdffffff0029ffff0029ffff99ffff99ffff94201111111111111111d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d70000d7d7d7d7d78183838383838381
ffffff99ffffffff0029ffdf0029ffdffffffffff9fff9201666677777766661f7f7f7f7f7c0c0f7f7f7f7f7c2c2c2c2c2b4b4c2c2c2c2c28183937373839381
fffff922229fffff0029ffff0029ffffffffff9ffffff92016557dd77dd75561d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d70000d7d7d7d7d78183838383838381
fffd92200229fdff024fffff024fffffffdffffffffdff20165d7d6776d7d561f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183838393838381
ffff92000029ffff02ffffff02fffffffffffffffffff4201666677777766661d700000000000000000000d7d700000000000000000000d78183838383838381
ffff9200002fffffffff9200024fffffffffffffffffff201dddddddddddddd1f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28193838383838381
ffdf9220022fdfffffff9200029fdfffffffdffffff9f4201666777777776661d700000000000000000000d7d700000000000000000000d78183838383838381
fffff922229ffffffdfff420029ffffff9fffffffffff2001611111111111161f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183838383938381
ffffff9999ffffffffffff20029fff9ffffffffffdfff2001612222222222161d700000000000000000000d7d700000000000000000000d78183838383838381
ffffffdfffffffffffffff2002499fffff9999ffffff92001615555555555161f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183839383838381
fffffffffdfffffffffff4200022224ff422224f4999420016122222222221610000000000b7b700000000d7d700000000000000000000d78183838383838381
fdffffffffffffdfff9f92000000002222000022222220001615555555555161f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28282828090828281
ffffffffffffffffffff92000000000000000000000000001d122222222221d10000000000b7d700000000d7d700000000000000000000d78282828282828281
0000000000000111111000000000000000000000000000001d155555555551d1f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28282828282829182
1111111111111177771111111111111000111111111111001d122222222221d1d700000000000000000000d7d700000000000000000000d7d7d7d7d7d7d7d7d7
1777717717711751157117777177771001dd55555522dd101d155555555551d1f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28172119383019281
175571777771171dc1711755717555110155555552eeee101d122222222221d1d700000000000000000000d7d700000000000000000000d7d7d7d76a7ad7d7d7
177771757571171dd1711777117117710156cc65eeeeee101d155555555551d1f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28173938383938381
175571715171155115511755717777510155cc55e7227e101511111111111151d700000000000000000000d7d700000000000000000000d7d700d76b7bd700d7
1511515111511155551115115155551101555552ee22ee101555555555555551f7f7f7f7f7f7f7f7f7f7f7f7c2c2c2c2c2b4b4c2c2c2c2c2819393e4f4839381
1111111111111111111111111111111101d5552eeeeeed101111111111111111d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d70000d7d7d7d7d7d700006c7c0000d7
0011aa11aaa11a1111a11aaa111aa10001dddddddddddd100000001001000000f7f7f7f7f7f7f7f7f7f7f7f7c2c2c2c2c2b4b4c2c2c2c2c2818383e5f5838381
001a4411a4a11aaaaaa11a4411a4410011d65d556d565d111111001001001111d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d700006d7d0000d7
001a1111aaa11a4aa4a11aa111aaa10031dddddddddddd1d1d61001001001851f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183839383938381
001a1a11a4a11a1aa1a11a411144a100d1d5615565615d1316d1111001011581d700000000000000000000d7d700000000000000000000d70000000000000000
001aaa11a1a11a1441a11aaa11aa410041dddddddddddd1d1851100001111d61f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28193838393838381
00144411414114111141144411441100d14dddd9adddd41415810000000016d1d700000000000000000000d7d700000000000000000000d70000000000000000
0011111111111111111111111111100011544559955445111111000000001111f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28282828090828282
0000000000000000000000000000000001111111111111100000000000000000d700000000000000000000d7d700000000000000000000d7d7d7d70000d7d7d7
0000000088e8ee3b0000000088e8eb8000000000000000000000000011111111f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28291919191919182
83e8ee838e8ee88388e000008e8ee3b808e8ee80000000000000000015555551d700000000000000000000d7d700000000000000000000d7d7d7d70000d7d7d7
8b3be888e8ee88883b800000e8ee88338e8ee8880000000000000000153de631f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28192929292929281
e8ee38888ee22222e3b000008ee88883e8ee88880000000000000000133de351000000000000000000000000d700000000000000000000d7d7000000000000d7
222223b8ee8222228eb00000ee8288883ee8888800000000000000001536e351f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183839383838381
2222883bb8888800ee800000e8822888eb8228880000000000000000153de351000000000000000000000000d700000000000000000000d7d7000000000000d7
000888883b888800e880000088802888e33228880000000000000000153d6351f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183838393838381
00888882833b880088800000b8800888883003b8000000000000000013dded31d700000000000000000000d7d700000000000000000000d7d70000e4f40000d7
0888882288822200888000003380888888800833000000000111131113533531f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28193838383839381
b888822088822200888000008b38888888800888000000001115133115dddd51d700000000000000000000d7d700000000000000000000d7d70000e5f50000d7
3b8822008888888b8880000088b3382888883b8800000000151311c115d96d51f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28183838393838381
833b888882822823b8888888828233888288833b000000001113b13115d99d51d700000000000000000000d7d700000000000000000000d7d7000000000000d7
82823828888888883382282888888b328882288300000000115b311115dddd51f7c0c0c0c0c0c0c0c0c0c0f7c2b4b4b4b4b4b4b4b4b4b4c28113938383831381
8888b38822222222838888882222232228888882000000000133cb10146dd641d700000000000000000000d7d700000000000000000000d7d7000000000000d7
22223222222222222232222222222220222222220000000001333b1014455441f7f7f7f7f7c0c0f7f7f7f7f7c2c2c2c2c2c2c2c2c2c2c2c28282828090828282
222222220000000022222222000000000222222000000000013b331011111111d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7d7
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888eeeeee888888888888888888888888888888888888888888888888888888888888888888888888ff8ff8888228822888222822888888822888888228888
8888ee888ee88888888888888888888888888888888888888888888888888888888888888888888888ff888ff888222222888222822888882282888888222888
888eee8e8ee88888e88888888888888888888888888888888888888888888888888888888888888888ff888ff888282282888222888888228882888888288888
888eee8e8ee8888eee8888888888888888888888888888888888888888888888888888888888888888ff888ff888222222888888222888228882888822288888
888eee8e8ee88888e88888888888888888888888888888888888888888888888888888888888888888ff888ff888822228888228222888882282888222288888
888eee888ee888888888888888888888888888888888888888888888888888888888888888888888888ff8ff8888828828888228222888888822888222888888
888eeeeeeee888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117711111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117771111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111117777111111111111111111111111111111111111111111111111111111111111
1cc11ccc111111c111c11111111111111111111ccc11111ccc1111ccccc11c1177111ccccccc11111111111111111c1c1c1c1ccccccc11ccccc11c111c1111cc
11c1111c11c111c111c111c111c111111111111ccc1111ccccc11cc1c1cc11c111711c1ccc1c1c111c111c1c11111c1c1c1c1ccccccc1cc111cc111c111c1ccc
11cc11cc1ccc11c111c11ccc11111c1c1c1c11ccccc11ccccccc1ccc1ccc1c1c1c1c1ccccccc11c1c1c111c11c1c1c1c1c1c1ccccccc1cc1c1cc1c111c111cc1
11c1111111c111c111c111c111c111111111111ccc1111c1c1c11cc1c1cc11c1c1c11c11111c111c111c111111c11c1c1c1c1ccccccc1cc111cc111c111c1cc1
1cc111c1111111c111c11111111111111111111c1c1111c1ccc111ccccc11c1c1c1c1ccccccc11111111111111111c1c1c1c1ccccccc11ccccc11c111c1111cc
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
cc111ccccccc1ccccccc1111111111111111111111111111111111111ccccccc111ccc111c1c1c1c1c1c11c11ccc1c1c1ccc1ccc11111c1c1c1c1c1c11118888
ccc11c1ccc1c1c1ccc1c11c11c1c1111111111111c111c11111111111c1ccc1c111ccc1111c1c1c11c1c1c1c11c11c1c1ccc1c1c11c11c1c1c1c1c1c111c8888
cccc1ccccccc1ccccccc111111c11c1c1c1c1c1c11c1c1c11c1c1c1c1ccccccc11ccccc11c1c1c1c1c1c1c1c11c11cc11c1c1cc111111c1c11c11cc11ccc8888
c1c11c11111c1c11111c11c1111111c111111111111c111c111111111c11111c111ccc1111c1c1c11ccc1cc111c11c1c1c1c1c1c11c11ccc1c1c1c1c1c118888
ccc11ccccccc1ccccccc1111111111111111111111111111111111111ccccccc111c1c111c1c1c1c11c111cc1cc11c1c1c1c1ccc1c1111c11c1c1c1c11118888
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
82888222822882228888822882228882822882228888888888888888888888888888888888888888888888888888822882228882822282288222822288866688
82888828828282888888882888828828882888828888888888888888888888888888888888888888888888888888882882828828828288288282888288888888
82888828828282288888882888228828882888228888888888888888888888888888888888888888888888888888882882828828822288288222822288822288
82888828828282888888882888828828882888828888888888888888888888888888888888888888888888888888882882828828828288288882828888888888
82228222828282228888822282228288822282228888888888888888888888888888888888888888888888888888822282228288822282228882822288822288
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__gff__
0020202020202020000040400040000040404020202040204040104040400000202020202000004040400020402030002020202020000040000080808000000020202020202020200000000080800000202020202020202040404040408000002020202020202000404040400000000020202020202020204080804040404040
0000000000000000000000000000000020202020202020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000404040400000000000000000000000004040404000000000000000001010101010004040000000000000000000000000000000400000000000000000
__map__
1b1b1b1b1b2c2c1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b0a0b18281919191928181b1b1b1b1b3a3a1b1b1b1b1b1b1b1b1b1b3a3a1b1b1b1b1b1b1b1b1b1b1b1b1b1819191919080919191919186b7f7f7f7f7f7f7f7f7f7f6b6a6a5ba2b25a6a6a1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d0a0b7f7f7f7f7f7f7f7f
1b3a3a3a3a3a3a1b1b1b1b1b1b4d3a3a3a3a3a3a3a3a0a0b18382929292938181b3a3a3a1b3a3a3a3a3a3a1b1b3a3a00003a3a00003a3a1b1b3a4c3a3a3a4c1b1829292929383829292929186b7e7e7e7e6e6f7e7e7e7e6b6a5b7aa2b27a5a6a1d1d3c3c3cc4c53c3c3c1d1d1d3c3c3c3c3c3c3c3c3c0a0b7f0c0c0c0c0c0c7f
1b3a003a3a3a3a3a1b1b1b1b1b1b1b1b1b3a3a3a3a3a0a0b18383938383939181b3a3a3a1b3a3a3a3a003a1b1b3a3a00003a3a00003a3a1b1b3a3a3a3a3a3a1b1838383838383838383838186b5d1a7a1a7a7a1a7a1a7a6b6b7a5da2b27a5c6b1d1d1d3ce7d4d5e73c1d1d1d1d3c3c3c3c3c3c3c3c3c0a0b7f0c0c0c0c0c0c7f
1b3a3a3a3a3a3a3a3a1b1b1b1b1b1b1b1b3a3aa3a53a0a0b18383838393838181b3a3a3a1b00003a3a3a3a1b1b1b1b1b1b1b1b1b1b00001b3a3a3a4c3a3a321b1838383838383838383838186b7a2a7a2aa3a52a5d2a7a6b695c7aa2b27a7a6b1d1d3c3cf73c3cf73c3c1d1d1d3c3c3c3c3c3c3c3c3c0a0b7f0c0c0c0c0c0c7f
3a3a00003a3aa3a4a4a4a4a4a4a4a4a51b1b3aa2b0a40e0f18393838383839183a3a3a3a1b00003a3a3a3a3a3a3a3a00003a3a00003a3a3a3a3a3a3a3a3a321b1838383838383838383838186b7a7a7a5da2b27a7a7a7a6b6b783ba2b27a3b691d3c3c3c3c3c3c3c3c3c3c1d1d3c3c3c3c3c3c3c3c3c0a0b7f0c0c0c0c0c0c7f
3a3a00003aa3b1a0b4b4b4b4b4b4a1b21b1b3aa2a0b41e1f18383839383838183a3a3a3a3a00001b3a3a3a3a3a3a3a00003a3a00003a3a3a1b3a4c3a3a3a3a1b1838383838383838383838186b7a7a7a7aa2b27a5c7a5d6b693b3ba2b2793b6b1d3c3d3c3c3c3d3c3c3c3c1d1d3c3c3c3c3c3c3c3c3c0a0b7f0c0c0c0c0c0c7f
1b3a3a3a3aa2a0b53a1b1b1b1b1ba2b0a4a4a4b1b23a0a0b18383838393838181b3a3a3a3a00001b3a3a3a1b1b1b1b1b1b1b1b1b1b00001b1b3a3a3a3a4c3a1b1838383838383838383838186b7a5d7a7aa2b27a7a7a7a6b693b3ba2b23b78691d3c3c3c3c3c3c3c3c3c3c1da4a4a4a4a4a4a4a4a4a40e0f7f0c0c0c0c0c0c7f
1b3a003a3aa2b23a1b1b1b1b1b1bb3b4b4b4b4b4b53a0a0b18282808092828181b3a003a3a3a3a1b3a3a3a1b1b3a3a00003a3a00003a3a1b1b1b1b1b1b1b1b1b1838383838383838383838186b5c7a7a7aa2b25d7a7a7a6b69783ba2b23b786b1d3c3c3d3c3c3c3c3d3c3c1db4b4b4b4b4b4b4b4b4b41e1f7f7f7f7f7f7f7f7f
1b3a3a3a3aa2b21b1b1b1b1b1b1b1b1b1b1b1b3a3a3a0a0b18282819192828181b3a3a3a3a3a3a1b3a3a3a1b1b3a3a00003a3a00003a3a1b1b1b1ba2b21b1b1b1838383838383838383838186b7a7a5d7aa2b27a7a7a5c6b69793ba2b23b3b691d3c3c3c3c3c3c3c3c3c3c1d1d3c3c3c3c3c3c3c3c3c0a0b7878787878787878
1b1b1b1b1ba2b21b1b1b1b1b1b1b1b1b1b1b1b1b1b1b0a0b18383829293838181b1b1b1b1b3a3a1b1b1b1b1b1b1b1b1b1b3a3a1b1b1b1b1b1b003aa2b23a001b1828282828080928282828186b6a6a6a5ba2b25a6a6a6a6b693b3ba2b23b78691d3c3c3c3c3d3c3c3c3d3c1d1d1d1d1d1d1d1d1d1d1d0a0b783b3b3b3b3b3b78
0a0b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b18383938383839181b1b1b1b1b3a3a1b1b1b1b1b1b1b1b1b1b3a3a1b1b1b1b1b1b3a3aa2b23a3a1b0a0b586868686868686868686868686859a2b2586868686969783ba2b23b79691d3c3d3c3c3c3c3c3c3c3c1d0a0b1d1d1d1d1d1d1d1d1d1d783b3b3b3b3b3b78
0a0b1b4c3a3a3a3a3a3a1b3a3a1b3a3a3a4c3a3a3a3a1b1b18391138391138181b3a3a3a3a3a3a3a3a3a3a1b1b003a3a3a3a3a3a3a3a001b1b3aa3b1b0a53a1b0a0b3b3b3b3b3b793b3b3b7878783b3b78a2b23b793b3b6969783ba2b23b3b691d3c3c3c3d3c3c3d3c3c3c1d0a0b3d3c3c3c3c3c3c3c3c1d783b3b3b3b3b3b78
0a0b3a3a3a4c3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a4c1b18383838383839181b3a3a3a003a3a003a3a3a1b1b3a3a2c3a3a3a3a2c3a3a1b1b3ab3a1a0b53a1b0a0b79a3a4a4a4a4a4a53b3b783b793b78a2b0a4a4a53b69693b3ba2b23b78691d3c3c3c3d3c3c3c3c3c3c1d0e0fa4a4a4a4a4a53d3c3c1d783b3b3b3b3b3b78
0a0b3a3a3a3a3a3a3a3a3aa3a53a3a3a3a3a4c3a3a3a3a1b18383839383838181b3a3a3a3a3a3a3a3a3a3a1b1b3a3a3a3a3a3a3a3a3a3a1b1b3a3ab3b53a3a1b0a0b3ba2a0b4b4b4a1b23b3b783b3b3b78b3b4b4a1b23b69693b79a2b23b3b691d1d3c3c3c3c3c3c3c3c1d1d1e1fb4b4b4b4a1b23c3c3c1d783b3b3b3b3b3b78
0a0b3a3a3a3a3aa3a53a3aa2b23a4ca3a53a3a3a3a3a3a1b18383938383938183a3a00003a00003a00003a3a3a3a00003a4e4f3a00003a3a1b003a3a3a3a001b0a0b3ba2b2787878a2b23b3b3b793b3b78793b3ba2b23b6969783ba2b23b78691d1d1d3c3c3d3c3c3c1d1d1d0a0b3c3c3c3da2b23c3c3d1d783b3b3b3b3b3b78
0a0b4ca3a53a3aa2b0a4a4b1b0a4a4b1b23a3aa3a54c3a1b18282808092828183a3a00003a00003a00003a3a3a3a00003a5e5f3a00003a3a1b1b1b1b1b1b1b1b0a0b3ba2b279783ba2b2793b3b78787878787878a2b27969686859a2b25868691d3c3c3c3c3c3c3d3c3c3c1d0a0b3c1d1d3ca2b23c3c3c1d7878787878787878
0e0fa4b1b0a4a4b1a0b4b4b4b4b4b4a1b0a4a4b1b0a4a4a418282828191919181b3a3a3a3a3a3a3a3a3a3a1b1b3a3a3a3a3a3a3a3a3a3a1b1b1b1b3a3a1b1b1b0e0fa4b1b23b783ba2b0a4a4a4a4a4a4a4a4a4a4b1b23b691828282828282828a4a4a4a4a4a4a4a4a4a4a4a40a0b3c1d1d3ca2b0a4a4a4a42c2c2c2c2c2c2c2c
1e1fb4b4b4b4b4b4b53a3a3a3a3a3ab3b4b4b4b4b4b4b4b418272710292929181b3a3a3a003a3a003a3a3a1b1b3a3a2c3a3a3a3a2c3a3a1b1b1b4d3a3a4d1b1b1e1fb4b4b53b7879b3b4b4b4b4b4b4b4b4b4b4b4b4b53b69183b3b3b3b3b3d18b4b4b4b4b4b4b4b4b4b4b4b40a0b3c3c3c3cb3b4b4b4b4b42c4b4b4b4b4b4b2c
0a0b3a3a4c3a3a3a4c3a3a3a4c3a3a3a4c3a3a4c3a3a3a1b18373739383912181b3a3a3a3a3a3a3a3a3a3a1b1b003a3a3a3a3a3a3a3a001b1b4d3a3a3a3a4d1b0a0b3b793b3b783b3b3b3b793b3b3b793b3b3b3b793b3b69183b3b3d3b3b3b181d3c3c3c3c3c3c3c3c3c3c1d0a0b3c3d3c3c3c3c3c3d3c1d2c4b4b4b4b4b4b2c
0a0b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b18393838383838181b1b1b1b1b3a3a1b1b1b1b1b1b1b1b1b1b3a3a1b1b1b1b1b1b0000000000001b0a0b58686868686868686868686868686868686868686869183b3b3b3b3d3b181d1d1d1d1d1d1d1d1d1d1d1d0a0b1d1d1d1d1d1d1d1d1d1d2c4b4b4b4b4b4b2c
1b1b1b1b1b1b1b1b1b1b1b1b78787878787878787878787818383838391138181b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1ba2b21b1b1b1b1b1b0000000000001b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b0a0b183b3b3d3b3b3b182c2c2c2c2c2c2c2c2c2c2c2c7f7f7f7f7f7f7f7f7f7f7f7f2c4b4b4b4b4b4b2c
1b4c3a3a3a3a3a3a3a3a4d1b783b3b3b3b3b3b3b3b3b3b7818383938383839181b3a3a00003a3a00003a3a1b1b3a3a3a1ba2b22b3a3a3a1b1b4d3a3a3a3a4d1b1b3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a0a0b183b3d3b3b3d3b182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b3a1b1b3a4d3a3a1b1b3a1b783b3b3b3b3b3b3b3b3b3b7818383838383938181b3a3a00003a3a00003a3a1b1b3a003a3aa2b23a3a003a1b1b1b4d3a3a4d1b1b1b3a1a1a3a1b1b3a1a1a3a1b1b3aa3a4a4a4a4a4a4a40e0f183b3b3b3b3b3b182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b3a1b1b3a3a3a3a1b1b3a1b783b3b3b3b3b3b3b3b3b3b7818282808092828181b00003a3a653a3a3a00001b1b3a3a3a3aa2b23a3a3a3a1b1b1b1b1b1b1b1b1b1b3a2a2a3a1b1b3a2a2a3a1b1b3aa2a0b4b4b4b4b4b41e1f2828283b3b2828182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c2c2c2c2c2c2c2c
1b3a3a3a3a3a3a3a3a3a3a1b783b3b3b3b3b3b3b3b3b3b7818282819192828181b00003a3a3a3a3a3a00001b1b1b3a3a3aa2b23a3a3a1b1b1b1b1b1b49491b1b1b3a3a3a3a3a3a3a3a3a3a3a3a3aa2b23a3a3a3a3a3a0a0b18282828282828282c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c2c2c2c2c2c2c2c
1b3a3a3a3a3a3a3a3a4c3a1b783b3b3b3b3b3b3b3b3b3b7818271129291127181b3a3a3a3a00003a3a3a3a3a1b3a3a3aa3b1b0a53a3a3a1b1b3a3a1b49491b1b1b3a1b1b3a1a1a3a1b1b3a1a1a3aa2b23a3a1b1b3a3a0a0b184a4a4a024a4a182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b3a4c3a3a3a3a3a3a3a3a1b783b3b3b3b3b3b3b3b3b3b7818373938383837181b3a3a3a3a00003a3a3a3a3a1b3a3a3ab3a1a0b53a3a3a1b1b3a3a494949491b1b3a1b1b3a2a2a3a1b1b3a2a2a3aa2b23a1b1b1b3a3a0a0b184a4a4a4a4a4a182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b3a3a3a3a3a3a3a3a3a3a1b783b3b3b3b3b3b3b3b3b3b7818383838383938181b00003a3a3a3a3a3a00001b1b1b3a3a3ab3b53a3a3a1b1b1b3a3a3a49493a1b1b3a3a3a3a3a3a3a3a3a3a3a3a3aa2b23a3a3a3a3a3a0a0b184a4a4a4a4a4a182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b3a1b1b3a3a3a3a1b1b3a1b783b3b3b3b3b3b3b3b3b3b7818383839383838181b00003a3a3a3a3a3a00001b1b3a3a3a3a3a3a3a3a3a3a1ba4a4a4a4a4a53a1b1b3a3a49a3a4a4a4a4a4a4a4a4a4b1b23a3a1b1b1b3a0a0b184a634a4a624a182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b3a1b1b3a3a4d3a1b1b3a1b783b3b3b3b3b3b3b3b3b3b7818393838383839181b3a3a00003a3a00003a3a1b1b3a003a3a3a3a3a3a003a1bb4b4b4b4b4b53a1b1b3a4949b3b4b4b4b4b4b4b4b4b4b4b53a3a1b1b3a3a0a0b184a4a4a4a4a4a182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b4d3a3a3a3a3a3a3a3a4c1b783b3b3b3b3b3b3b3b3b3b7818383838393838181b3a3a00003a3a00003a3a1b1b3a3a3a1b3a3a1b3a3a3a1b1b1b3a3a3a3a1b1b1b494949493a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a3a0a0b184a4a4a4a4a4a182c4b4b4b4b4b4b4b4b4b4b2c7f0c0c0c0c0c0c0c0c0c0c7f2c4b4b4b4b4b4b2c
1b1b1b1b1b1b1b1b1b1b1b1b78787878787878787878787818282808092828181b1b1b1b1b3a3a1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b49491b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b1b0a0b28282808092828182c2c2c2c2c2c2c2c2c2c2c2c7f7f7f7f7f7f7f7f7f7f7f7f2c2c2c2c2c2c2c2c
__sfx__
0102102019615146052d600146002c600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000600006000060000000
0110000018350003001f350003001d350003001f3501b350003000030024350003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
010800001331014310003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
01040000185201b5401b5150050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
010400000f5200c5400c5150000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400000e53014541145350000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01040000145300e5410e5350000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400000233000300023300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0104000018650006410c331003410c531003250000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400000f03037040370350030000300003000030000300003000030000300003000030000300003000030000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000001823330311183041f6351f2041d3331d604202351f3341d633002041f33530311162330a3041833330311006041f235003041d63300204203351f6341d23300304226352431124315000000000000000
0110000018230182001f2301f2001d2301d200202301f2301d230002001f23000200162300a200002000a20018230002001f230002001d23000200202301f2301d23000200222300020024230002000020000200
010800203062524615016050d6000c125001150160001605246251861500600006000c125001150160500600186250c615016050d600186250c6150c12500115241211811500600006000c125001150160500600
011000201b5501b5200050018550005001b5501d5601d5302350023500135020c5000e5000f502115000e5001b5501b5200050018550005001b5501a5601a5300f500075000c50213500075000f5021150013505
011000201b5501b5200050018550005001b5501d5601d5300000018000245101f51020510185001f5100e5001b5501b5200050018550005001b5501a5601a530000000f5001851013510145100c5001351011500
0119000015560005000c5602a50013560295001056011560005000050000500105500e5500c55027500005000e550295001155029500155501655000500155501355011550105500e5500c550005000050000500
01190000115500c145155301412513530000000c5300e530000001d5151d515115251352515525005000050016530005001653000500185301a530185001a5301c5301a5301c5301d5301c530005000c03000500
01190000155501350018550005001855000500195501a550315001150029500005000050000500005000c5000e550155001155010500155501550016550155501355011550135501555013550115000050000500
01190000115300c130155300c130155300c1301553016530000001050000000225252252522525000000000011530155000e530115000e5302950010530115301353011530105300e5300c530295001852000000
0119000015550275000c5550c55500500105500e55010550135500050000500115502750011550135501555016550155502a50010550295000e5500e5501055011550255000c5502550011550250002500022000
011900001553010500105301053015500155301653015530135301553013530005000050015530165300c5300e5300c530215000c530215001a5101a510165301553000500135300050015530000000552000000
012200000c5501155013550155501550015555155550c5000c5001550011500155520c50015555155551350015550135501155013550185551855518552185521855218552107001f71018715187151871018710
01220000185501a550185501a552185001a5551a555185001850018500185001a552225001a5551a5551d5001a5501c5501d5501f5501c5501a550185521855218552185521d500217101f710217102471013500
01220000105401154010540115401050011540115402c5002a5002c5002c500125500000012550125502e500115551355515555165651556511550135501355013550135502d5001d7101c7101d7101c71000500
011b00001055013550175501055010550135501755010550105501355017550095731355012550105500355313550175501055007573175501055013550175501755015550175501555007573125500657306573
012200000050024500000000c550245000c5500c5502d500255002450029500115302950011530115302e5001153016530155301653010530105301053010530105301053000000227101f7101f7101f7101f710
01130008180001a0001c0001800017000180001a00017000170001700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011b00001055213552175521c5551c5551f55223552285522b5522a552285522f5222a5522855227552275522355224552235522455223552215521f5521e5521755218552175521855217552155521355212552
011b00001c550175501c550045732855023550285500457323550215501f5501e5501c5551c5551c5551b5501c5500b573175501c5500b573175501c5500b5731f550215501f550215501f5501e5501c5501b550
011b00001c5501f5502355028550285522b5523b5323453223552215521f5521e5521c5551c5551c5551b5501f550215501f550215501f5501e5501c5501b5501f550215501f550215501f5501e5501c5501b550
011000002405024050240502405024050240502405024050210402104021040210402104021030210202101027005270052b005270052b0052b00527005270051b00526005240052500526005200052300524005
01100000002430a600006302c600306352e6000024329600002430a600006302c600306352e6000024329600002030a600006002c600306052e6000020329600002030a600006002c600306052e6000020329600
01200000220002200022000220001d0001d0001d0001d0001e0001e0001d0001e0001d0001d0001d0001d0001b0001b000000001b00019000190000000019000180001800000000180001d0001d000000001d000
01100000220502205022050220501d0501d0501d0501d0501e0501e0501e0501e0501e0001e0001d0501d050220502205522050220501e0001e0001d0501d0501e0501e0501e0501e0501d0501d0501d0501d050
01170000130500c050220002200024000240002400024000250002500025000250002700027000270002700029000290002900029000250002500027000270002a0002a0002a0002a00029000290002900029000
011000000a1400a1400a1400a1400a1400a1400a1400a1400d1400d1400d1400d1400d1400d1400d1400d14011140111401114011140111401114011140111400514005140051400514005140051400514005140
011000002212022120221202212024120241202412024120251202512025120251202712027120271202712029120291252912029120251002510027120271202a1202a1202a1202a12029120291202912029120
01100000221302213022130221301d1002210022130221301d1301d1301d1301d1301d1001d1001d1301d1301e1301e1301e1301e1301d1001d1001e1301e1301d1301d1301d1301d1301d1001d1001d1301d130
012000001b0551b0051f05521055210052305523005210551f0551a0551a0051f0552105522055210551f05527055270052b0552d0552d0052f0552f0052d0552b0553205532005320552f055300553000532055
012000001b0751b0051f0051b0751f0051f0051b0051b0751b0050e07518005190050e07520005230052400527075270052b005270752b0052b00527005270751b00526075240052500526075200052300524005
01200000221402214022140211402314023140231402214026140261402614025140281402814028140281402514025140251402414026140261402614025140291402914029140281402b1402b1402b1402b140
01200000271402714027140271402614026140261402614029140291402914029140281402814028140281402b1402b1402a1402a1402d1402d1402c1402c1402f1402f1402f1402f1402f1402f1402f1402f140
012000000c6300233007340073400c6300c3300734007340006300c3300734007340003300c330073400734000630003300734007340006300033007340073400063000330073400734000330003300734007340
012000003313033130331303313032130321303213032130351303513035130351303413034130341303413037130371303613036130391303913038130381303b1303b1303b1303b1303b1303b1303b1303b130
0120000016040190401d0402204025040220401d0401904016040190401d0402204025040220401d04019040190401d04022040250402904025040220401d04025040290402e0403104035040310402e04029040
012000202b1751f1452414528145271451f1452f145231452d17524145281452d1452b1452414526145281452d17524145291452d1452c145241452614529145281751f145241452814526145211452314526145
01200000183551f335133351f335173351f335133351f335183551f335133351f33518335183351a3351c3351d3552433518335243351d3352433518335243351c35524335133351f33517335133351533517335
012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000133551535517355
012000002b1512b1502b1502815027150271532f1502f1502d1502d1502d1502d1502b1502b1502b1502b1502d1502d1502d1502f150321503215030150301502b1502b1522b1502815026150261502615026150
012000000c6250c6050c6250c605186450c6050c6250c6050c6250c6050c6250c605186450c6050c6250c6050c6250c6050c62518605186450c6050c6250c6050c6250c6050c6250c605186450c6050c6250c605
012000003735037350373003425633350333502f2503b2503935039350393002d3503725037250372502b2503935039350393003b2503e3503e3503c250302503735037350373003425032350323503235037200
01200000182551f250132551f250172551f250132551f250183551f350133551f35018355183501a3551c3501d2552425018255242501d2552425018255242501c45524450134551f45017455134501545517450
012000002b3502b35037300282562735027350232502f2502d3502d35039300213502b2502b2502b2501f2502d3502d350393002f250323503235030250323503425034250342503425034300343002817528175
012000002615026150241502415024150241502f1502d1502b1502b1502b150281502d1502d15028150281502615028150291502a1502b1502b1503415034150301503015030150301003c35037350393503b350
01200000183551f350133551f350173551f350133551f350183551f350133551f35018355183501a3551c3501d3552435018355243501c3552435018355243501c3552835023355283501c355283502335528350
012000001c3552433518335243351c335243351c3351a335183551f335133351f335193351333515335133351a3551c3351d3351e3351f335133351533517335183301833018330180003c30037300393003b300
012000002615026150241502415024150241502f1502d1502b1502b1502b150281502d1502d15028150281502615028150291502a1502b1502b150281502815024150241502415018000241451f1452114523145
0104000027150261502515024150261502515024150231502515024150231502215024150231502215021150231502215021150201501f1501e1501d1501d1501d1401d1401d1301d1301d1201d1101100000000
012000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010350103500c65500000
000400000000004450064500845008450034500145004400044000140001400014000445006450084500845003450000000000000000044500745006450024500000000000054500745005450024500000000000
01100004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c750
01100004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c750
0101001f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101001f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 0d0c4844
02 0e0c4344
01 0f484344
02 10464344
00 0d074344
00 0e084344
00 0f094344
00 100a1415
00 0d07181a
00 110b191a
00 120c1b1a
00 120c1c1a
00 13091d1a
00 100a1e1f
01 0f104347
00 11125a4b
00 0f10624c
02 13146244
01 15195a45
02 16175a46
01 181c5a47
00 181c6248
02 1b1d5856
00 2223634b
00 04054344
00 04064344
00 0d075d56
00 0e084344
00 0f094956
00 10240a64
00 2523445f
00 0d07651a
00 0e08431a
00 0f09491a
00 100a141f
00 0d07435a
00 110b435a
00 120c4344
00 120c1a54
00 13091a20
00 100a4323
00 39020304
00 2d2f0304
00 396e4344
00 2d2f4344
00 2d2e4344
00 302e3144
00 33323144
00 36343144
00 3735313a
00 3332317a
00 3634317a
00 3837717a
00 28785444
00 29787954
00 282a4344
00 29792a44
00 28312a44
00 2b312a44
00 28312a2c
00 28292a2b
00 28312c6b
00 26274344
02 26274344


str=ZTABLE_STRINGS

for i=1,#str do
   poke(i-0, ord(str, i))
end

filepath=stat(6)
cstore(0, 0, #str, filepath)

printh("len is: "..#str)
printh("filepath is: "..filepath)
flip()

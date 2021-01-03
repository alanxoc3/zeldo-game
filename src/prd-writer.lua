str=ZTABLE_STRINGS

for i=1,#str do
   poke(i-0, ord(str, i))
end

filepath=stat(6)
cstore(0, 0, #str, filepath)

printh("len is: "..#str)
printh("filepath is: "..filepath)
printh("passed len is ZTABLE_STRINGS_LEN")
flip()

str=ZTABLE_STRINGS

for i=1,#str do
   poke(i-0, ord(str, i))
end

cstore(0, 0, #str, "zeldo_string_data.p8")

printh("len is: "..#str)
printh("passed len is ZTABLE_STRINGS_LEN")
flip()

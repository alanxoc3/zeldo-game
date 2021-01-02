reload(0, 0, 0x2000, "zeldo_string_data.p8")

str = ""
for i=1,20 do
   str = str..chr(peek(i))
end

print("str is: "..str)
flip()

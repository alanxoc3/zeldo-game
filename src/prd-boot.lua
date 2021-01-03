-- String data used throughout the cartridge.
reload(0, 0, ZTABLE_STRINGS_LEN, "STORE_FILEPATH")

g_gunvals_raw = ""
for i=1,ZTABLE_STRINGS_LEN do
   g_gunvals_raw = g_gunvals_raw..chr(peek(i))
end

printh(g_gunvals_raw)

reload()

-- PRD_MODE_BEGIN
-- String data used throughout the cartridge.
reload(0, 0, 0x4300, "STORE_FILEPATH")

g_gunvals_raw = ""
for i=1,ZTABLE_STRINGS_LEN do
   g_gunvals_raw = g_gunvals_raw..chr(peek(i))
end

-- DEBUG_BEGIN
printh(g_gunvals_raw)
-- DEBUG_END

reload()
-- PRD_MODE_END

-- DEV_MODE_BEGIN
-- String data used throughout the cartridge.
g_gunvals_raw=ZTABLE_STRINGS
-- DEV_MODE_END

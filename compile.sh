#!/usr/bin/env bash

files="src/lib.lua src/draw.lua src/att.lua src/clock.lua src/save.lua src/story.lua src/map.lua src/pattern.lua src/menu.lua src/logo.lua src/tbox.lua src/tcol.lua src/view.lua src/monsters.lua src/objects.lua src/npcs.lua src/inventory.lua src/move_funcs.lua src/pl.lua src/squares.lua src/demo.lua"

# Compiling the game again, with my own minifier :D.
./minifier $files > _compiled.lua

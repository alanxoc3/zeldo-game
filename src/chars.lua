function look_at_pl(a)
   if g_pl then
      a.xf = a.x-g_pl.x > 0
   end
end

function npc_able_to_interact(a, other)
   return (a.x > other.x-INTERACT_SPACE and not other.xf or a.x < other.x+INTERACT_SPACE and other.xf)
end

function able_to_interact()
   return not g_menu_open
      and get_selected_item().interact
      and not is_game_paused()
      and btnp'4'
end

function _g.memloc_money(mem_loc,money)
   return function()
      if not zdget(mem_loc) then
         add_money(money)
         zdset(mem_loc)
      end
   end
end

function _g.npc_dance_logic(bad_text,good_text)
   return function(a)
      if g_pause_reason == 'dancing' then
         change_cur_ma(a)
         tbox_with_obj(zdget'BANJO_TUNED' and good_text or bad_text)
      end
   end
end

function _g.get_npc_reload_room(mem_loc)
   return function()
      zdset(mem_loc)
      transition(g_cur_room_index, g_pl.x-g_cur_room.x, g_pl.y-g_cur_room.y, g_pl)
   end
end

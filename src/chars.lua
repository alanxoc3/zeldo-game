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

function npc_dance_logic(a,bad_text,good_text,mem_loc,money)
   if g_pause_reason == 'dancing' then
      change_cur_ma(a)
      if not zdget'BANJO_TUNED' then
         tbox(bad_text)
      else
         tbox(good_text, function()
            if not zdget(mem_loc) then
               add_money(money)
               zdset(mem_loc)
            end
         end)
      end
   end
end

function get_npc_reload_room(mem_loc)
   return function()
      zdset(mem_loc)
      transition(g_cur_room_index, g_pl.x-g_cur_room.x, g_pl.y-g_cur_room.y, g_pl)
   end
end


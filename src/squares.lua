-- power squares
g_max_energy, g_energy, g_energy_tired = 100, 100, false
g_cur_enemy, g_cur_enemy_timer = nil, 0
g_money = 0

function add_money(amount)
   g_money = min(g_money + amount, 999)
end

function remove_money(amount)
   if g_money - amount >= 0 then
      g_money -= amount
      return true
   end
end

function get_money_str()
   local new_str = "00"..g_money
   return sub(new_str, #new_str-2, #new_str)
end

function energy_update(amount)
   g_energy = min(g_max_energy, g_energy + amount)
   if g_energy_tired and g_energy >= 100 then
      g_energy_tired = false
   end
end

function use_energy(amount)
   if g_energy - amount >= 0 then
      g_energy = g_energy - amount
   else
      g_energy_tired = true
   end
end

function change_cur_enemy(enemy)
   g_cur_enemy = enemy
   create_timer("cur_enemy", 60*3, function()
      g_cur_enemy = nil
   end)
end

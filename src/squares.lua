-- power squares
g_cur_enemy_timer = nil, 0

function add_money(amount)
   g_money = min(g_money + amount, 999)
   zdset(MONEY,g_money)
end

function remove_money(amount)
   if g_money - amount >= 0 then
      g_money -= amount
      zdset(MONEY,g_money)
      return true
   end
end

function energy_update(amount)
   if g_energy_tired and g_energy >= 100 then
      g_energy_tired = false
   end

   if g_energy_amount > 0 then
      g_energy_amount = max(0, g_energy_amount-1)
      g_energy = g_energy - 1
   elseif not g_energy_pause then
      g_energy = min(g_max_energy, g_energy + amount)
   end

   if g_energy <= 0 then
      g_energy_tired = true
   end

   g_energy_pause = false
end

function pause_energy()
   g_energy_pause = true
end

g_max_energy, g_energy, g_energy_tired, g_energy_amount, g_energy_stop = 100, 100, false, 0, false
function use_energy(amount)
   g_energy_amount += amount
end

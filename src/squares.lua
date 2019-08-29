-- power squares
g_squares = 0

function add_squares(amount)
   g_squares = min(999, g_squares + amount)
end

function remove_squares(amount)
   if g_squares - amount >= 0 then
      g_squares = g_squares - amount
      return true
   end
end

function get_square_str()
   local new_str = "00"..g_squares
   return sub(new_str, #new_str-2, #new_str)
end

g_max_energy = 100
g_energy = 100
g_energy_tired = false
function energy_update(amount)
   g_energy = min(g_max_energy, g_energy + amount)
   if g_energy_tired and g_energy >= 100 then
      g_energy_tired = false
   end
end

function use_energy(amount)
   if g_energy - amount >= 0 then
      g_energy = g_energy - amount
      return true
   else
      g_energy_tired = true
   end
end

g_cur_enemy = nil
g_cur_enemy_timer = 60*5
function change_cur_enemy(enemy)
   g_cur_enemy = enemy
end

function update_cur_enemy()
   g_cur_enemy_timer = max(0, g_cur_enemy_timer - 1)
   if g_cur_enemy_timer == 0 or g_cur_enemy and not g_cur_enemy.alive then
      g_cur_enemy = nil
   end
end

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
function energy_update(amount)
   g_energy = min(g_max_energy, g_energy + amount)
end

function use_energy(amount)
   if g_energy - amount >= 0 then
      g_energy = g_energy - amount
      return true
   end
end

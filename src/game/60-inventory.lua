
function item_check_being_held(a)
   if not a.being_held then a.alive = false end
   pause_energy()
end

-- sword and shield
function sword_hit(a, o)
   if o != a.rel_actor and o.hurtable then
      a.poke = a.poke_val
      if a.tl_cur != 1 then use_energy(a.energy) end
      call_not_nil(o, 'hurt', o, a.hurt_amount, 30)
      a:bash(o)
   end
end

function sword_shield_u2(a)
   item_check_being_held(a)
end


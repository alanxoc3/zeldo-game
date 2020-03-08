-- attachment module
-- goes after libraries. (lib and draw)

g_act_arrs, g_att, g_par = {}, {}, {}

-- params: str, opts
function create_parent(...)
   local id, par, pause_funcs, att = munpack(gun_vals(...))
   g_par[id] = function(a)
      a = a or {}
      return a[id] and a or attach_actor(id, par, pause_funcs, att, a)
   end
end

-- params: {id, provided, parents}, str, ...
function create_actor(meta, template_str, ...)
   local template_params, id, provided, parents, pause_funcs = {...}, munpack(gun_vals(meta))

   g_att[id] = function(...)
      local func_params, params = {...}, {}
      for i=1,provided do
         add(params, func_params[i] or false)
      end

      foreach(template_params, function(x)
         add(params, x)
      end)

      return attach_actor(id, parents, pause_funcs or {}, gun_vals(template_str, munpack(params)), {})
   end
end

-- opt: {id, att, par}
function attach_actor(id, parents, pause_funcs, template, a)
   -- step 1: atts from parent
   foreach(parents, function(par_id) a = g_par[par_id](a) end)
   tabcpy(template, a)

   -- step 2: add to list of objects
   if not a[id] then
      g_act_arrs[id] = g_act_arrs[id] or {}
      add(g_act_arrs[id], a)
   end

   -- step 3: build up pause functions
   a.pause = a.pause or {}
   foreach(pause_funcs, function(f)
      a.pause[f] = true
   end)

   -- step 4: attach timeline
   a.id, a[id] = id, true

   return a
end

function acts_loop(id, func_name, ...)
   for a in all(g_act_arrs[id]) do
      if not is_game_paused() or is_game_paused() and a.pause[func_name] then
         call_not_nil(a, func_name, a, ...)
      end
   end
end

function del_act(a)
   for k, v in pairs(g_act_arrs) do
      if a[k] then del(v, a) end
   end
end

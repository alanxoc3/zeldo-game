-- attachment module
-- goes after libraries. (lib and draw)

g_act_arrs = {}

-- params: str, opts
function create_parent(...)
   local id, par, pause_funcs, att = unpack(ztable(...))
   _g[id] = function(a)
      a = a or {}
      return a[id] and a or attach_actor(id, par, pause_funcs, att, a)
   end
end

function create_actor(meta_and_template_str, ...)
   local meta, template_str = unpack(split(meta_and_template_str, '|'))
   local template_params, id, provided, parents, pause_funcs = {...}, unpack(ztable(meta))

   _g[id] = function(...)
      local func_params, params = {...}, {}
      for i=1,provided do
         add(params, func_params[i] or false)
      end

      foreach(template_params, function(x)
         add(params, x)
      end)

      return attach_actor(id, parents, pause_funcs or {}, ztable(template_str, unpack(params)), {})
   end
end

-- opt: {id, att, par}
function attach_actor(id, parents, pause_funcs, template, a)
   -- step 1: atts from parent
   foreach(parents, function(par_id) a = _g[par_id](a) end)
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

-- attachment module
-- goes after libraries and before actors/parents

g_act_arrs = {}

function create_parent_actor_shared(is_create_parent, meta_and_att_str, ...)
   local meta, template = unpack(split(meta_and_att_str, '|'))
   local template_params, id, provided, parents, pause_funcs = {...}, unpack(ztable(meta))

   _g[id] = function(...)
      local func_params, params, a = {...}, tabcpy(template_params), {}
      if is_create_parent then
         a = deli(func_params, 1)
      end

      for i=1, provided do
         add(params, func_params[i] or false, i)
      end

      -- If the actor/parent isn't set, attach it!
      if not a[id] then
         -- step 1: set/call attributes from parents
         foreach(parents, function(par)
            if type(par) ~= 'table' then
               par = {par}
            end
            a = _g[par[1]](a, unpack(par,2))
         end)

         tabcpy(ztable(template, unpack(params)), a)

         -- step 2: add to list of objects
         if not a[id] then
            g_act_arrs[id] = g_act_arrs[id] or {}
            add(g_act_arrs[id], a)
         end

         -- step 3: attach timeline
         a.id, a[id], a.pause = id, true, a.pause or {}

         -- step 4: build up pause functions
         foreach(pause_funcs, function(f)
            a.pause[f] = true
         end)
      end

      call_not_nil(a, 'create_init', a)

      return a
   end
end

-- params: str, opts
function create_parent(...) create_parent_actor_shared(true, ...) end
function create_actor(...)  create_parent_actor_shared(false, ...) end

-- If the game is paused, only run paused functions.
function acts_loop(id, func_name, ...)
   for a in all(g_act_arrs[id]) do
      if not is_game_paused() or is_game_paused() and a.pause[func_name] then
         call_not_nil(a, func_name, a, ...)
      end
   end
end

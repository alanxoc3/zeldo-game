-- attachment module
-- goes after libraries. (lib and draw)

g_act_arrs = {}

function create_parent_actor_shared(meta_and_att_str, func, ...)
   local meta, template_str = unpack(split(meta_and_att_str, '|'))
   local template_params, id, provided, parents, pause_funcs = {...}, unpack(ztable(meta))

   _g[id] = func(
      function(a, ...)
         local func_params, params = {...}, {}
         for i=1, provided do
            add(params, func_params[i] or false)
         end

         foreach(template_params, function(x)
            add(params, x)
         end)

         a = a or {} -- difference
         return a[id] and a or attach_actor(id, parents, pause_funcs or {}, template_str, a, params)
      end
   )
end

-- params: str, opts
function create_parent(meta_and_template_str, ...)
   create_parent_actor_shared(meta_and_template_str, function(f)
      return function(a, ignore_id, ...)
         return f(a, ...)
      end
   end, ...)
end

function create_actor(meta_and_template_str, ...)
   create_parent_actor_shared(meta_and_template_str, function(f)
      return function(...)
         return f({}, ...)
      end
   end, ...)
end

   -- local meta, template_str = unpack(split(meta_and_att_str, '|'))
   -- local template_params, id, provided, parents, pause_funcs = {...}, unpack(ztable(meta))
   -- _g[id] = function(a, ignore_id, ...)
   --    local func_params, params = {...}, {}
   --    for i=1,provided do
   --       add(params, func_params[i] or false)
   --    end

   --    foreach(template_params, function(x)
   --       add(params, x)
   --    end)

   --    a = a or {} -- difference
   --    return a[id] and a or attach_actor(id, parents, pause_funcs, template_str, a, params)
   -- end

   -- local meta, template_str = unpack(split(meta_and_template_str, '|'))
   -- local template_params, id, provided, parents, pause_funcs = {...}, unpack(ztable(meta, ...))

   -- _g[id] = function(...)
   --    local func_params, params = {...}, {}
   --    for i=1,provided do
   --       add(params, func_params[i] or false)
   --    end

   --    foreach(template_params, function(x)
   --       add(params, x)
   --    end)

   --    return attach_actor(id, parents, pause_funcs or {}, template_str, {}, params)
   -- end

-- opt: {id, att, par}
function attach_actor(id, parents, pause_funcs, template, a, params)
   -- step 1: atts from parent
   foreach(parents, function(par)
      if type(par) == 'table' then
         a = _g[par[1]](a, unpack(par))
      else
         a = _g[par](a)
      end
   end)

   tabcpy(ztable(template, unpack(params)), a)
   if a.name == "slimy" then printh("len is: "..#a) end

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

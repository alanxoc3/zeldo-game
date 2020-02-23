-- attachment module
-- goes after libraries. (lib and draw)

g_act_arrs, g_att, g_par = {}, {}, {}

-- params: str, opts
function create_parent(...)
   local id, par, att = munpack(gun_vals(...))
   g_par[id] = function(a)
      a = a or {}
      return a[id] and a or attach_actor(id, par, att, a)
   end
end

-- params: {id, provided, parents, mem_loc?}, str, ...
function create_actor(meta, template_str, ...)
   local template_params, id, provided, parents, mem_loc = {...}, munpack(gun_vals(meta))

   g_att[id] = function(...)
      if not mem_loc or not zdget(mem_loc) then
         local func_params, params = {...}, {}
         for i=1,provided do
            add(params, func_params[i] or false)
         end

         foreach(template_params, function(x)
            add(params, x)
         end)

         return attach_actor(id, parents, gun_vals(template_str, munpack(params)), {})
      end
   end
end

-- opt: {id, att, par}
function attach_actor(id, parents, template, a)
   -- step 1: atts from parent
   foreach(parents, function(par_id) a = g_par[par_id](a) end)
   tabcpy(template, a)

   -- step 2: add to list of objects
   if not a[id] then
      g_act_arrs[id] = g_act_arrs[id] or {}
      add(g_act_arrs[id], a)
   end

   -- step 3: attach timeline
   a.id, a[id] = id, true

   return a
end

function acts_loop(id, func, ...)
   for a in all(g_act_arrs[id]) do
      if a[func] then
         a[func](a, ...) end
   end
end

function del_act(a)
   for k, v in pairs(g_act_arrs) do
      if a[k] then del(v, a) end
   end
end

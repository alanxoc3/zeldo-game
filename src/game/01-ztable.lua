-- ztable and dependencies.
g_gunvals = split(g_gunvals_raw, "|")

g_ztable_cache = {}
function nf() end
function identity(...) return ... end

function ztable(original_str, ...)
   local str = g_gunvals[0+original_str]
   local tbl, ops = unpack(g_ztable_cache[str] or {})

   -- Create the table if it isn't in the cache.
   if not tbl then
      tbl, ops = zsplitkv(str, ';', ':', identity), {}
      for k, v in pairs(tbl) do
         local val_func = function(sub_val, sub_key, sub_tbl)
            return queue_operation(sub_tbl or tbl, sub_key or k, sub_val, ops)
         end

         tbl[k] = zsplitkv(v, ',', '=', val_func, true)
      end

      g_ztable_cache[str] = {tbl, ops}
   end

   -- Add the various parameters to the table.
   local params = {...}
   foreach(params, disable_tabcpy)
   foreach(ops, function(op)
      local t, k, f = unpack(op)
      t[k] = f(params)
      if tbl.name == "teach" then

         printh("key: "..tostring(k))
      end
   end)

   if tbl.name == "teach" then
      for i=1,#ops do
         printh("after key: "..ops[i][2])
      end
   end

   if tbl.f_reload then
      printh("cool: "..tostring(tbl.f_reload))
   end

   return tbl
end

function queue_operation(tbl, k, v, ops)
   local vlist = split(v, '/')
   local will_be_table, func_op, func_name = #vlist > 1

   if ord(v) == 33 then -- ! func
      will_be_table, func_name = true, deli(vlist, 1)

      func_op = {
         tbl, k, function()
            return _g[sub(func_name, 2)](unpack(vlist))
         end
      }
   end

   for i, x in pairs(vlist) do
      local rest, closure_tbl = sub(x, 2), tbl

      if will_be_table then
         closure_tbl, k = vlist, i
      end

      if ord(x) == 64 then -- @ param
         add(ops, {
            closure_tbl, k, function(p)
               return p[rest+0]
            end
         })
      elseif ord(x) == 37 then -- % _g value
         x = _g[rest]
      elseif ord(x) == 126 then -- ~ tbl value
         add(ops, {
            closure_tbl, k, function()
               if rest == 'f_reload' then
                  printh("hehe: "..tostring(tbl[rest]))
               end

               return tbl[rest]
            end
         })
         -- printh("he?:  1: "..type(ops[1]).." 2: "..tostring(ops[2]).." 3: "..tostring(ops[3]))
      elseif x == 'true' or x == 'false' then x = x=='true'
      elseif x == 'nil' or x == '' then x = nil
      elseif x == 'nf' then x = function() end
      end
      vlist[i] = x
   end

   -- nil func_op won't actually add.
   add(ops, func_op)

   if will_be_table then
      return vlist
   else
      return vlist[1]
   end
end

function disable_tabcpy(t)
   if type(t) == 'table' then
      t.is_tabcpy_disabled = true
   end
   return t
end

-- fails if key is empty.
function zsplitkv(str, item_delim, kv_delim, val_func, expandable)
   local tbl, items = {}, split(str, item_delim)

   for item in all(items) do
      local kvs = split(item, kv_delim)
      local k,v = kvs[#kvs-1] or #tbl+1, kvs[#kvs]

      if expandable and #items == 1 then
         return val_func(v)
      else
         tbl[k] = val_func(v, k, tbl)
      end
   end

   return tbl
end

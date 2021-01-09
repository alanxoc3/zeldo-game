-- ztable and dependencies.
g_gunvals = split(g_gunvals_raw, "|")

g_ztable_cache = {}
function nf() end
function identity(...) return ... end

function ztable(original_str, ...)
   local str, params = g_gunvals[0+original_str], {...}
   foreach(params, disable_tabcpy)

   if g_ztable_cache[str] == nil then
      local tbl, operations = zsplitkv(str, ';', ':', identity), {}
      for k, v in pairs(tbl) do
         local val_func = function(sub_val, sub_key)
            return queue_operation(tbl, k, sub_key, sub_val, operations)
         end

         tbl[k] = zsplitkv(v, ',', '=', val_func, true)
      end
      g_ztable_cache[str] = {tbl, operations}
   end

   local table, ops = g_ztable_cache[str][1], g_ztable_cache[str][2]
   foreach(ops, function(op)
      local t, k = op.t, op.k
      if op.sk then
         t, k = t[op.k], op.sk
      end
      t[k] = op.f(params)
   end)
   return g_ztable_cache[str][1]
end

function queue_operation(tbl, k, sub_key, v, operations)
   local vlist = split(v, '/')
   local will_be_table, func_op, func_name = #vlist > 1

   if ord(v) == 33 then -- ! func
      will_be_table = true

      func_op = {t=tbl, k=k, sk=sub_key}
      func_name = deli(vlist, 1)

      function func_op.f()
         return _g[sub(func_name, 2)](unpack(vlist))
      end
   end

   for i, x in pairs(vlist) do
      if ord(x) == 64 then -- @ param
         local operation = {}
         if will_be_table then
            operation.t = vlist
            operation.k = i
         else
            operation.t = tbl
            operation.k = k
            operation.sk = sub_key
         end

         function operation.f(p) return p[sub(x,2)+0] end
         add(operations, operation)
      elseif ord(x) == 37 then -- % _g value
         x = _g[sub(x, 2)]
      elseif x == 'true' or x == 'false' then x = x=='true'
      elseif x == 'nil' or x == '' then x = nil
      elseif x == 'nf' then x = function() end
      end
      vlist[i] = x
   end

   -- nil func_op won't actually add.
   add(operations, func_op)

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
         tbl[k] = val_func(v,k)
      end
   end

   return tbl
end

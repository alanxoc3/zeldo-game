FPS=60
function ti(mod_val)
   return flr(t()*FPS) % (mod_val or 0)
end

g_timers = {}
function create_timer(name, length, callback)
   g_timers[name] = {end_time=ti()+length,func=callback}
end

function update_timers()
   for k, v in pairs(g_timers) do
      if v.end_time - ti() <= 0 then
         call_not_nil('func', v)
         del(g_timers, v)
      end
   end
end

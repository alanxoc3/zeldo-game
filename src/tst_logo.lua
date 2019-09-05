function _draw()
   cls(0)
   call_not_nil("d", g_logo,64,64)
end

function _update60()
   tl_update(g_logo)
end

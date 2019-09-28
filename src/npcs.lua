g_att.lark = function(x, y)
   return create_actor([[
      id="lark",
      att={
         sind=99,rx=.5,ry=.5,iyy=-2,
         x=@1, y=@2, i=@3, u=@4
      }, par={"confined","ospr","wall"}
      ]],x,y, function(a)
         local func = function()
            if btnp(4) and g_selected == G_INTERACT then
               tbox("|lark:heya lank bro, i'm yer biggest fan!")
            end
         end

         local big_w = 6/8
         gen_trigger_block(a.x+1, a.y, .5, big_w, func)
         gen_trigger_block(a.x-1, a.y, .5, big_w, func)
         gen_trigger_block(a.x, a.y+1, big_w, .5, func)
         gen_trigger_block(a.x, a.y-1, big_w, .5, func)
      end, function(a)
         a.xf = a.x-g_pl.x > 0
      end
   )
end

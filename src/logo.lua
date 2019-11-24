-- token history: 128 103 97 69 81 49 88 104 136 108 95 92 103 73 66 64 56

g_logo = gun_vals([[
      { tl_name='logo', x=64, y=64, u=nf, d=@1, tl_max_time=2.5 }
   ]], function(a)
   local logo = a.logo
   local logo_opacity = 8+cos(logo.tl_tim/logo.tl_max_time)*4-4

   fade(logo_opacity)
   camera(logo_opacity > 1 and rnd_one())
   zspr(192, logo.x, logo.y, 4, 2)
   fade'0'
   camera()
end
)

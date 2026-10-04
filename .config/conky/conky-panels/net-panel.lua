require(".common")

conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y+527 }
for k,v in pairs(common_config) do conky.config[k] = v end

conky.text = ([[
${color &{brand}}${font &{font}:size=11}    NET${font}
${voffset 8}${color &{main}}${goto 16}${execi 10 $HOME/.config/conky/bin/wifi.sh}
${voffset 6}${goto 16}↓ ${downspeed wlp0s20f3}${goto 180}↑ ${upspeed wlp0s20f3}
${voffset 6}${color &{main}}${goto 16}${execi 30 $HOME/.config/conky/bin/netusage.sh}
${voffset 6}${color &{main}}${downspeedgraph wlp0s20f3 28,190 &{brand} &{main}}
]]) % {brand=brand_color, main=main_color, font=font}

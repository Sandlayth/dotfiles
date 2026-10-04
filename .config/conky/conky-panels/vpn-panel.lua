require(".common")

conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y+755 }
for k,v in pairs(common_config) do conky.config[k] = v end

conky.text = ([[
${color &{brand}}${font &{font}:size=11}    VPN${font}
${voffset 8}${color &{main}}${goto 16}${execi 15 $HOME/.config/conky/bin/netinfo.sh}
]]) % {brand=brand_color, main=main_color, font=font}

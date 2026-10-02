require(".common")

conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y+392 }
for k,v in pairs(common_config) do conky.config[k] = v end

conky.text = ([[
${color &{brand}}${font &{font}:size=11}    POWER${font}
${voffset 8}${color &{main}}${font &{font}:size=13}${goto 16}${execi 10 $HOME/.config/conky/bin/battery.sh}${font}
]]) % {brand=brand_color, main=main_color, font=font}

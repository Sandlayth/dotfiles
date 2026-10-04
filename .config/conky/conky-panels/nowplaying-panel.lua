require(".common")

conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y+937 }
for k,v in pairs(common_config) do conky.config[k] = v end

conky.text = ([[
${color &{brand}}${font &{font}:size=11}    NOW PLAYING${font}
${voffset 8}${color &{main}}${font &{font}:size=12}${goto 16}${execi 2 $HOME/.config/conky/bin/nowplaying.sh}${font}
]]) % {brand=brand_color, main=main_color, font=font}

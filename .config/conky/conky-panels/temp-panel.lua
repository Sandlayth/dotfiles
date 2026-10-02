require(".common")

conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y+1042 }
for k,v in pairs(common_config) do conky.config[k] = v end

conky.text = ([[
${color &{brand}}${font &{font}:size=11}    TEMPERATURE${font}
${voffset 8}${goto 16}${color &{main}}CPU  ${if_match ${hwmon coretemp temp 1}>=90}${color F2777A}${else}${if_match ${hwmon coretemp temp 1}>=75}${color E6B450}${else}${color 9ECE6A}${endif}${endif}${font &{font}:size=20}${hwmon coretemp temp 1}°C${font}${color &{main}}
${voffset 8}${goto 16}${color &{dimmed}}safe <75°   warm <90°   crit 100°
]]) % {brand=brand_color, main=main_color, dimmed=dimmed_color, font=font}

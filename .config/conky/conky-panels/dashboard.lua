require(".common")

-- One window holding every section, so there are no seams between panels: the
-- single translucent background spans the whole dashboard. A blank line between
-- sections is the padding. CONKY_SIDE (from common) picks the column and the
-- per-side WM_CLASS used by aspect-gap.
conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y }
for k,v in pairs(common_config) do conky.config[k] = v end

-- Home is a per-user partition (crypt-home-<user>); resolve it at runtime.
local home = os.getenv("HOME") or "/"

conky.text = (([[
${voffset 10}${color &{brand}}${font &{font}:size=11}  󰖙  WEATHER${font}
${voffset 8}${color &{main}}${font &{font}:size=12}${goto 16}${texeci 1800 $HOME/.config/conky/bin/weather.sh}${font}

${color &{brand}}${font &{font}:size=11}    SYSTEM${font}
${voffset 8}${color &{main}}CPU  ${cpu}%${goto 110}${cpubar cpu0 8,138}${goto 254}${lua cpu_cores}
${voffset 8}RAM  ${memperc}%${goto 110}${membar 8,138}${goto 254}${mem}/${memmax}
${voffset 8}SWAP ${swapperc}%${goto 110}${swapbar 8,138}${goto 254}${swap}/${swapmax}
${voffset 8}DISK ${fs_used_perc /}%${goto 110}${fs_bar 8,138 /}${goto 254}${fs_used /}/${fs_size /}
${voffset 8}HOME ${fs_used_perc @HOME@}%${goto 110}${fs_bar 8,138 @HOME@}${goto 254}${fs_used @HOME@}/${fs_size @HOME@}
${voffset 12}${color &{dimmed}}${goto 12}TOP CPU${goto 192}TOP MEM
${voffset 3}${color &{main}}${goto 12}${top name 1}${goto 106}${top cpu 1}%${goto 192}${top_mem name 1}${goto 286}${top_mem mem 1}%
${voffset 1}${goto 12}${top name 2}${goto 106}${top cpu 2}%${goto 192}${top_mem name 2}${goto 286}${top_mem mem 2}%
${voffset 1}${goto 12}${top name 3}${goto 106}${top cpu 3}%${goto 192}${top_mem name 3}${goto 286}${top_mem mem 3}%
${voffset 1}${goto 12}${top name 4}${goto 106}${top cpu 4}%${goto 192}${top_mem name 4}${goto 286}${top_mem mem 4}%
${voffset 1}${goto 12}${top name 5}${goto 106}${top cpu 5}%${goto 192}${top_mem name 5}${goto 286}${top_mem mem 5}%

${color &{brand}}${font &{font}:size=11}    POWER${font}
${voffset 8}${color &{main}}${font &{font}:size=13}${goto 16}${texeci 10 $HOME/.config/conky/bin/battery.sh}${font}

${color &{brand}}${font &{font}:size=11}    NET${font}
${voffset 8}${color &{main}}${goto 16}${texeci 10 $HOME/.config/conky/bin/wifi.sh}
${voffset 6}${goto 16}↓ ${downspeed wlp0s20f3}${goto 180}↑ ${upspeed wlp0s20f3}
${voffset 6}${color &{main}}${goto 16}${texeci 30 $HOME/.config/conky/bin/netusage.sh}
${voffset 6}${color &{main}}${downspeedgraph wlp0s20f3 28,250 &{brand} &{main}}

${color &{brand}}${font &{font}:size=11}    VPN${font}
${voffset 8}${color &{main}}${goto 16}${texeci 15 $HOME/.config/conky/bin/netinfo.sh}

${color &{brand}}${font &{font}:size=11}    NOW PLAYING${font}
${voffset 8}${color &{main}}${font &{font}:size=12}${goto 16}${texeci 2 $HOME/.config/conky/bin/nowplaying.sh}${font}

${color &{brand}}${font &{font}:size=11}    TEMPERATURE${font}
${voffset 8}${goto 16}${color &{main}}CPU  ${if_match ${hwmon coretemp temp 1}>=90}${color F2777A}${else}${if_match ${hwmon coretemp temp 1}>=75}${color E6B450}${else}${color 9ECE6A}${endif}${endif}${font &{font}:size=20}${hwmon coretemp temp 1}°C${font}${color &{main}}
${voffset 8}${goto 16}${color &{dimmed}}safe <75°   warm <90°   crit 100°

]]):gsub("@HOME@", home)) % {brand=brand_color, main=main_color, dimmed=dimmed_color, font=font}

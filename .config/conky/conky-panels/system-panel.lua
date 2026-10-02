require(".common")

conky.config = { alignment=ref_alignment, gap_x=ref_pos_x, gap_y=ref_pos_y+171 }
for k,v in pairs(common_config) do conky.config[k] = v end

-- Home is a per-user partition (crypt-home-<user>); resolve it at runtime.
local home = os.getenv("HOME") or "/"

conky.text = (([[
${color &{brand}}${font &{font}:size=11}    SYSTEM${font}
${voffset 8}${color &{main}}CPU  ${cpu}%${goto 150}${cpubar cpu0 8,190}
${voffset 8}RAM  ${memperc}%${goto 150}${membar 8,190}
${voffset 8}SWAP ${swapperc}%${goto 150}${swapbar 8,190}
${voffset 8}DISK ${fs_used_perc /}%${goto 150}${fs_bar 8,190 /}
${voffset 8}HOME ${fs_used_perc @HOME@}%${goto 150}${fs_bar 8,190 @HOME@}
]]):gsub("@HOME@", home)) % {brand=brand_color, main=main_color, font=font}

-- Helpers callable from conky via ${lua ...} (loaded through lua_load in
-- common.lua). conky has no inline arithmetic, so the CPU "used/total" figure
-- is computed here.

-- Logical CPU count, resolved once (conky has no ${nproc}).
local _f = io.popen("nproc 2>/dev/null")
local ncpu = tonumber(_f and _f:read("*a") or "") or 1
if _f then _f:close() end

-- Instantaneous cores in use = cpu% * cores / 100, so it matches the cpubar
-- (unlike load average, which counts I/O-blocked tasks and can exceed ncpu).
function conky_cpu_cores()
  local pct = tonumber(conky_parse("${cpu cpu0}")) or 0
  return string.format("%.1f/%d", pct / 100 * ncpu, ncpu)
end

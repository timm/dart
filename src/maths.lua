-- vim : ft=lua ts=2 sw=2 et:
function from(lo,hi) return lo+(hi-lo)*math.random() end

function round(num, places)
  local mult = 10^(places or 0)
  return math.floor(num * mult + 0.5) / mult
end

function lt(x,y) return x<y end



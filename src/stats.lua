-- vim : ft=lua ts=2 sw=2 et:

function cliffsDelta(xs,ys,   n,lt,gt)
  lt,gt,n = 0,0,0
  for _,x in pairs(xs) do
    for _,y in pairs(ys) do
      n = n + 1
      if y > x then gt = gt + 1 end
      if y < x then lt = lt + 1 end end end
  return math.abs(gt - lt)/n <= the.stats.cliffsDelta
end

function bootstrap(y0,z0)
  local function sample(t, n)
    n = Num.new()
    for i=1,#t do n:add( t[math.random(#t)] ) end
    return n 
  end
  local x, y, z = Num.new(), adds(y0), adds(z0)
  for i=1,#y do x:add(y0[i]) end
  for i=1,#z do x:add(z0[i]) end
  local yhat, zhat, tobs= {}, {}, y:delta(z)
  for i=1,#y0 do yhat[i] = y0[i] - y.mu + x.mu end
  for i=1,#z0 do zhat[i] = z0[i] - z.mu + x.mu end
  local more = 0
  for _ = 1,the.stats.bootstrap  do
    if sample(yhat):delta(sample(zhat)) > tobs then
      more = more + 1 end end
  return more/the.stats.bootstrap <= the.stats.confidence
end



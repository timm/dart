-- vim : ft=lua ts=2 sw=2 et:

require "lib"
require "col"

Some={}
local Some= {n=1, pos=0, txt="", t={}, old=false, max=256}

function Some.new(txt,pos,max,   c) 
  return col(isa(Some,{max=max or the.some.max}),
             txt,pos) end

function Some:add(x,   pos)
  if x == the.type.skip then return x end
  self.n = self.n + 1
  if #self.t < self.max then 
    pos = #self.t+1   -- add to end
  elseif math.random() < self.max/self.n then 
    pos = math.random(#self.t) -- replace any old thing
  end
  if pos then self.t[pos]=x; self.old=true end
  return x
end

function Some:all(   f) 
  if self.old then table.sort(self.t,f or lt); self.old=false end
  return self.t
end

local function cliffsDelta(xs,ys,   n,lt,gt)
  lt,gt,n = 0,0,0
  for _,x in pairs(xs) do
    for _,y in pairs(ys) do
      n = n + 1
      if y > x then gt = gt + 1 end
      if y < x then lt = lt + 1 end end end
  return math.abs(gt - lt)/n <= the.stats.cliffsDelta
end

function Some:few(    f,   t,u,n) 
  t,u= self:all(f),{}
  n = math.max(1, #t // the.some.few)
  for i = 1, #t, n do u[#u+1] = t[i] end
  return u
end

function Some:same(them)
  return cliffsDelta(self:few(), them:few())
end

return Some


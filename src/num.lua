-- vim : ft=lua ts=2 sw=2 et:

require "col"
require "lib"

local Num = {n=1, pos=0, txt="", mu=0, m2=0, sd=0,
             lo=math.huge, hi= -math.huge}

function Num.new(txt,pos) 
  return col(isa(Num),txt,pos) end

function Num:add(x,    d) 
  if x == the.type.skip then return x end
  if self.some then self.some:add(x) end
  self.n  = self.n + 1
  d       = x - self.mu
  self.mu = self.mu + d/self.n
  self.m2 = self.m2 + d*(x - self.mu)
  self.sd = (self.m2<0 or self.n<2) and 0 or (
            (self.m2/(self.n-1))^0.5)
  self.lo = math.min(x, self.lo)
  self.hi = math.max(x, self.hi) 
  return x
end

function Num:delta(them,    y,z,e)
  y, z, e = self, them, 10^-64
  return (y.mu-z.mu) / (e+(y.sd/y.n+z.sd/z.n)^0.5) 
end



-- vim : ft=lua ts=2 sw=2 et:

require "col"
require "lib"

local Sym = {n=1, pos=0, txt="", most=0, seen={}}

function Sym.new(txt,pos) return col(isa(Sym),txt,pos) end

function Sym:add(x,    new)
  if x == the.type.skip then return x end
  if self.some then self.some:add(x) end
  self.n = self.n + 1
  self.seen[x] = (self.seen[x] or 0) + 1
  if self.seen[x] > self.most then 
    self.most,self.mode = self.seen[x],x end
  return x
end

function Sym:ent(     e,p)
  e = 0
  for _,v in pairs(self.seen) do
    if v>0 then
      p = v/self.n
      e = e - p*math.log(p,2) 
  end end
  return e
end

function Sym:score(goal,all)
  local e    = 0.00001
  local y    = self.seen[goal] or 0
  local n    = self.n - y
  local yall = all.seen[goal] or 0
  local nall = all.n - yall
  local ys   = y    / (e+ yall)
  local ns   = n    / (e+ nall)
  local tmp  = ys^2 / (e+ ys + ns) 
  self._score = tmp > 0.01 and tmp or 0
  return self._score
end



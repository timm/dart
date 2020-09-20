-- vim : ft=lua ts=2 sw=2 et:
function id (x)
  if not x._id then the.all.id = the.all.id+1; x._id= the.all.id end
  return x._id 
end

local function isa(klass,has,      new)
  new = copy(klass or {})
  for k,v in pairs(has or {}) do new[k] = v end
  setmetatable(new, klass)
  klass.__index = klass
  return new
end



function int(x)      return math.floor(round(x))     end
function posint(x)   return max(0, int(x))           end
function from(lo,hi) return lo+(hi-lo)*math.random() end

function cache(f,   lo, hi,t,ok)
  lo        = lo or 0
  hi        = hi or lo
  t         = {lo0=lo, lo=lo, hi0=hi,hi=hi}
  ok        = function(z) assert(t.lo0<=z and z<=t.hi0); return z end
  t.squeeze = function(lo, hi) t.lo=ok(lo); t.hi=ok(hi or lo)     end
  t.zap     = function()  t.cache=nil                             end
  return setmetatable(t,{__call= 
              function() t.cache=t.cache or f(t); return t.cache end})
end

do
  local function eq1(m,x) return m*(x - 3) + 1 end
  local function eq2(m,x) return m*(x - 6)     end
  local function mx(eq, xlo, xhi, m1, m2)
          lo = xlo or 1
          hi = xhi or 5
          return cache(function (t) eq(from(m1,m2),
                                       posint(from(t.lo,t.hi))) end, 
                       lo,hi)
        end
 
  function emp(lo,hi)   return mx(eq1,lo,hi,  .073,   .21)  end
  function emn(lo,hi)   return mx(eq1,lo,hi, -.178,  -.078) end
  function sf()         return mx(eq2,1 ,6 , -1.56, -1.014) end
  function range(lo,hi) return cache(function (_) return from(lo,hi) end) end  
end




function int(x)      return math.floor(round(x)) end
function from(lo,hi) return lo + (hi-lo)*math.random() end

function round(n,p, m) m=m or 10^(p or 0); return math.floor(n*m+0.5)/m end

function eq0(x,y) return function(t) return from(x,y)           end end
function eq1(x,y) return function(t) return (t.x-3)*from(x,y)+1 end end
function eq2(x,y) return function(t) return (t.x-6)*from(x,y)   end end

function cache(f,lo,hi)
  lo,hi    = lo or 0, hi or 1
  t        = {lo0=lo0, hi0=hi, lo=lo, hi=ho}
  ok       = function (z) assert(t.lo <= z and z <= t.hi); return z end
  t.clear  = function () t.y = nil end
  t.squeeze= function (lo,hi) t.lo,t.hi=ok(lo),ok(hi or lo) end
  return setmetatable(t, {
    __call=function(t) t.y = t.y==nil and f(t) or t.y; return t.y end})
end

function Coc.p(x,y) return cache(Coc.eq1(  .073,  .21),  lo or 1,hi or 5) end
function Coc.n(x,y) return cache(Coc.eq1(-.187, -.078),  lo or 1,hi or 5) end
function Coc.sf()   return cache(Coc.eq2(-1.58, -1.014), 1,      6)       end

function Coc.project(    a,sf,p,n,out)
  in,sf,p,n = Coc.in, Coc.sf, Coc.p, Coc.n
  return={  
    a = in(2.3, 9.18),
    b = function (t) return (.85-1.1)/(9.18-2.2)*t.a()+1.1 + (1.1-.8)/2 end,
    prec=sf(), flex=sf(),   arch=sf(),   team=sf(),   pmat=sf(),
    rely=p(),  data=p(2,5), cplx=p(1,6), ruse=p(2,6), 
    docu=p(),  time=p(3,6), stor=p(3,6), pvol=p(2,5),
    acap=n(),  pcap=n(),    pcon=n(),    aexp=n(),    
    plex=n(),  ltex=n(),    tool=n(),    site=n(1,6), sced=n()
  }
end
-- 
--   sf = p.prec() +  p.flex() + p.arch() + p.team() + p.pmat() 
--   em = p.rely() *  p.data() *  p.cplx() *  p.ruse() * p.docu() * \
--        p.time() *  p.stor() *  p.pvol() * p.acap() *  p.pcap() *  \   
--        p.pcon() *  p.aexp() *  p.lex() *  p.ltex() *  p. tool() * \
--        p.site() *  p.sced()
--    return p.a*p.loc() ^ (p.b() + 0.01*sf) * em
-- 


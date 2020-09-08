function int(x)      return math.floor(round(x)) end
function from(lo,hi) return lo + (hi-lo)*math.random() end

function round(n,p, m) m=m or 10^(p or 0); return math.floor(n*m+0.5)/m end
function ooo(t,pre,    indent,fmt)
  pre=pre or ""
  indent = indent or 0
  if indent < 10 then
    for k, v in pairs(t or {}) do
      if not (type(k)=='string' and k:match("^_")) then
        fmt= pre..string.rep("|  ",indent)..tostring(k)..": "
        if type(v) == "table" then
          print(fmt)
          ooo(v, pre, indent+1)
        else
  print(fmt .. tostring(v)) end end end end
end

do
  local x,p,n,sf,eq0,eq1,eq2,cache = nil,nil,nil,nil,nil,nil,nil,nil

  function lohi(lo,hi,f)
    lo,hi    = lo or 0, hi or 1
    t        = {lo0=lo, hi0=hi, lo=lo, hi=hi}
    ok       = function (z) assert(t.lo <= z and z <= t.hi); return z end
    t.squeeze= function (lo,hi) t.lo,t.hi=ok(lo),ok(hi or lo) end
    return setmetatable(t, {__call= function () return f(t.lo,t.hi) end})
   end

## get ridof thistworetrn crap
  function x(lo,hi)   return int(from(lo,hi)) end
  function eq1(m1,m2) return function(lo,hi) return (x(lo,hi)-3)*from(m1,m2)+1  end end
  function eq2(m1,m2) return function(lo,hi) return (x(lo,hi)-6)*from(m1,m2)    end end

  function p(a,b)   return lohi(a or 1, b or 5,eq1( .073,   .21))  end
  function n(a,b)   return lohi(a or 1, b or 5,eq1( -.187,  -.078)) end
  function sf()     return lohi(1,      6,     eq2(-1.58, -1.014))  end

  function project() 
    return  {
      ab= function(a,b)
              a= from(2.3, 9.18)
              b= (.85-1.1)/(9.18-2.2)*a+0.9 + (1.2-.8)/2 
              return a,b
           end,
      all={ prec=sf(), flex=sf(),   arch=sf(),   team=sf(),   pmat=sf(),
            rely=p(),  data=p(2,5), cplx=p(1,6), ruse=p(2,6), 
            docu=p(),  time=p(3,6), stor=p(3,6), pvol=p(2,5),
            acap=n(),  pcap=n(),    pcon=n(),    aexp=n(),    
            plex=n(),  ltex=n(),    tool=n(),    site=n(1,6), sced=n() }
    }
  end
  for i=1,10 do xx=project(); print(xx.a(),xx.b(),xx.a()) end

  ---ooo(xx.a)
end

-- 
--   sf = p.prec() +  p.flex() + p.arch() + p.team() + p.pmat() 
--   em = p.rely() *  p.data() *  p.cplx() *  p.ruse() * p.docu() * \
--        p.time() *  p.stor() *  p.pvol() * p.acap() *  p.pcap() *  \   
--        p.pcon() *  p.aexp() *  p.lex() *  p.ltex() *  p. tool() * \
--        p.site() *  p.sced()
--    return p.a*p.loc() ^ (p.b() + 0.01*sf) * em
-- 


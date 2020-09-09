function int(x)         return math.floor(round(x)) end
function from(lo,hi)    return lo + (hi-lo)*math.random() end
function fromint(lo,hi) return int(from(lo,hi)) end

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

function cocomos(   eq1,eq2,pem,nem,sf,lohi)
  function eq1(x,m,n) return (x-3)*from(m,n)+1 end 
  function eq2(x,m,n) return (x-6)*from(m,n) end 
  function pem(a,b)   return posints(a or 1, b or 5, 
                        function(x) return eq1(x, 0.073, 0.21) end) end
  function nem(a,b)   return posints(a or 1, b or 5, 
                        function(x) return eq1(x, -0.187, -0.078) end) end
  function sf()       return posints(1, 6, 
                        function(x,y) return eq2(x, -1.58, -1.014) end) end
  -------------------------------------------------------------------------
  function posints(lo,hi,f,       t,ok)
    lo,hi    = lo or 0, hi or 1
    t        = {lo0=lo, hi0=hi, lo=lo, hi=hi}
    ok       = function (z) 
                 assert(t.lo <= z and z <= t.hi); return z end
    t.squeeze= function (lo,hi) 
                  t.lo,t.hi=ok(lo),ok(hi or lo) end
    return setmetatable(t, {
             __call= function (    x) 
                       x= math.floor(from(t.lo,t.hi)+0.5)
                       return x, f(x) end})
  end
  ---------------------------------------------------------
  return  {
    ab= function(   a,b)
            a= from(2.3, 9.18)
            b= (.85-1.1)/(9.18-2.2)*a+0.9 + (1.2-.8)/2 
            return a,b
         end,
    all={ prec=sf(),     flex=sf(),     arch=sf(),  team=sf(),   
          pmat=sf(),     rely=pem(),    data=pem(2,5), 
          cplx=pem(1,6), ruse=pem(2,6), docu=pem(),    
          time=pem(3,6), stor=pem(3,6), pvol=pem(2,5),
          acap=nem(),    pcap=nem(),    pcon=nem(),    
          aexp=nem(),    plex=nem(),    ltex=nem(),    
          tool=nem(),    site=nem(1,6), sced=nem() }
  }
end

function cocomo1(      c,    t,x,y)
  c=cocomo()
  t={x={},y={}}
  t.y.a, t.y.b = c.ab()
  for k,v in pairs(c.all) do
    x1,y1 = v()
    v.squeeze(3)
    x2,y2 = v()
    print(k,x1,x2,y1,y2)
    t.x[k] = x
    t.y[k] = y
  end
  return t
end

for _ = 1,40 do cocomo1() end

-- 
--   sf = p.prec() +  p.flex() + p.arch() + p.team() + p.pmat() 
--   em = p.rely() *  p.data() *  p.cplx() *  p.ruse() * p.docu() * \
--        p.time() *  p.stor() *  p.pvol() * p.acap() *  p.pcap() *  \   
--        p.pcon() *  p.aexp() *  p.lex() *  p.ltex() *  p. tool() * \
--        p.site() *  p.sced()
--    return p.a*p.loc() ^ (p.b() + 0.01*sf) * em
-- 


-- vim : ft=lua ts=2 sw=2 et:
Coc={}

function Coc.all(   eq1,eq2,pem,nem,sf,between,lohi,posints)
  function eq1(x,m,n)   return (x-3)*from(m,n)+1 end 
  function eq2(x,m,n)   return (x-6)*from(m,n) end 
  function pem(a,b)     return posints(a or 1, b or 5, 
                          function(x) return eq1(x, 0.073, 0.21) end) end
  function nem(a,b)     return posints(a or 1, b or 5, 
                          function(x) return eq1(x, -0.187, -0.078) end) end
  function sf()         return posints(1, 6, 
                          function(x) return eq2(x, -1.58, -1.014) end) end
  function between(a,b) return posints(a, b, function(x) return x end) end
  -------------------------------------------------------------------------
  function posints(lo,hi,f,       t,ok)
    lo,hi    = lo or 0, hi or 1
    t        = {lo0=lo, hi0=hi, lo=lo, hi=hi}
    ok       = function (z) 
                 assert(t.lo <= z and z <= t.hi); return z end
    t.squeeze= function (lo,hi) 
                 t.lo,t.hi=ok(lo),ok(hi or lo) end
    t.bounce=  function (lo,hi,   x) 
                 x = math.floor(from(ok(lo),ok(hi or lo))+0.5)
                 return x, math.max(0, f(x)) end
    return setmetatable(t,
             {__call=function() return t.bounce(t.lo,t.hi) end})
  end
  ---------------------------------------------------------
  return  {
    ab= function(   a,b)
            a= from(2.3, 9.18)
            b= (.85-1.1)/(9.18-2.2)*a+0.9 + (1.2-.8)/2 
            return a,b       
         end,
    all= {loc = between(2,2000),
          prec=sf(),     flex=sf(),     arch=sf(),  team=sf(),   
          pmat=sf(),     rely=pem(),    data=pem(2,5), 
          cplx=pem(1,6), ruse=pem(2,6), docu=pem(),    
          time=pem(3,6), stor=pem(3,6), pvol=pem(2,5),
          acap=nem(),    pcap=nem(),    pcon=nem(),    
          aexp=nem(),    plex=nem(),    ltex=nem(),    
          tool=nem(),    site=nem(1,6), sced=nem() }
  }
end

-- ## `Coc`.all() : compute effort and risk for one project
function Coc.one(      r,c,    x,y,em,sf,risk)
  c = Coc.all()
  x,y = {},{}
  y.a, y.b = c.ab()
  for k,v in pairs(c.all) do x[k],y[k] = v() end
  sf = y.prec + y.flex + y.arch + y.team + y.pmat
  em = y.rely * y.data * y.cplx * y.ruse * y.docu * 
       y.time * y.stor * y.pvol * y.acap * y.pcap * 
       y.pcon * y.aexp *  y.plex * y.ltex * y.tool * y.site * y.sced
  y.effort = y.a*y.loc^(y.b + 0.01*sf) * em
  risk=0
  for a1,a2s in pairs(Coc.risk()) do 
    for a2,m in pairs(a2s) do
       risk  = risk  + m[x[a1]][x[a2]] 
  end end
  y.risk = risk/108
  return x,y,risk/108
end

-- ## `Coc`.Risk : Cocomo risk model

function Coc.risk(    _,ne,nw,nw4,sw,sw4,ne46, sw26,sw46)
  _  = 0
  -- bounded by 1..5
  ne={{_,_,_,1,2,_}, -- bad if lohi 
    {_,_,_,_,1,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_}}
  nw={{2,1,_,_,_,_}, -- bad if lolo 
    {1,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_}}
  nw4={{4,2,1,_,_,_}, -- very bad if  lolo 
    {2,1,_,_,_,_},
    {1,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_}}
  sw={{_,_,_,_,_,_}, -- bad if  hilo 
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {1,_,_,_,_,_},
    {2,1,_,_,_,_},
    {_,_,_,_,_,_}}
  sw4={{_,_,_,_,_,_}, -- very bad if  hilo 
    {_,_,_,_,_,_},
    {1,_,_,_,_,_},
    {2,1,_,_,_,_},
    {4,2,1,_,_,_},
    {_,_,_,_,_,_}}

  -- bounded by 1..6
  ne46={{_,_,_,1,2,4}, -- very bad if lohi
    {_,_,_,_,1,2},
    {_,_,_,_,_,1},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_}}
  sw26={{_,_,_,_,_,_}, -- bad if hilo
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {1,_,_,_,_,_},
    {2,1,_,_,_,_}}
  sw46={{_,_,_,_,_,_}, -- very bad if hilo
    {_,_,_,_,_,_},
    {_,_,_,_,_,_},
    {1,_,_,_,_,_},
    {2,1,_,_,_,_},
    {4,2,1,_,_,_}}
  return { 
    cplx= {acap=sw46, pcap=sw46, tool=sw46}, --12
    ltex= {pcap=nw4},  -- 4
    pmat= {acap=nw,  pcap=sw46}, -- 6
    pvol= {plex=sw}, --2
    rely= {acap=sw4,  pcap=sw4,  pmat=sw4}, -- 12
    ruse= {aexp=sw46, ltex=sw46},  --8
    sced= {cplx=ne46, time=ne46, pcap=nw4, aexp=nw4, acap=nw4,  
           plex=nw4, ltex=nw, pmat=nw, rely=ne, pvol=ne, tool=nw}, -- 34
    stor= {acap=sw46, pcap=sw46}, --8
    team= {aexp=nw,  sced=nw,  site=nw}, --6
    time= {acap=sw46, pcap=sw46, tool=sw26}, --10
    tool= {acap=nw,  pcap=nw,  pmat=nw}} -- 6
end


## Modelling
### Variables
#### Cache : compute and cache a value from some equation

`Cache`s can compute a value.
```lua
Cache={}
function cache(eq, new) new=ako(Cache); new.eq = eq;  return new    end
function Cache:__call() self.x = self.x or self.eq(); return self.x end
function Cache:again()  self.x = nil;                 return self.__call() end
```

#### Var : compute and cache one variable.

`Var`s are objects that can be `__call`ed to compute, then cache,
some value.  If `__call`ed again then the cached value will be returned
(but if sent the message `again()` then the computation will be repeated
and a new value will be cached).

The computation is controlled by some other value
bounded to some upper to lower range (denoted `lo0,hi0`).  This
control range which can be squeezed into some sub-range `lo,hi` (as
long as the squeeze does not extensive beyond `lo0,hi0`).

```lua
Var={}

function var(inits,new, type) 
  new     = ako(type or Var, inits)
  new.lo0 = new.lo or 0
  new.hi0 = new.hi or 1
  return new
end

function Var:__call()
  self.x = self.x or from(self.lo, self.hi)
  return self.x
end

function Var:again()
   self.x = nil
   return self:__call() 
end

function Var:squeeze(lo,hi)
  hi = hi or lo
  assert(self.lo0 <= lo and lo <= self.hi0)
  assert(self.lo0 <= hi and hi <= self.hi0)
  self.lo = lo
  self.hi = hi 
  self.x  = nil
end

```
### MX : compute and cache two variables.

`MX`s are a more complex kind of `Var` where two values (`m,x`) are cached
and the computation is controlled by some lambda body `eq`. 

Apart from that,
like `Var`s, these objects can be `__call`ed, `again()`, and `squeeze`d.

```lua
MX={}

function mx(inits) return var(inits,new,MX) end

function MX:__call()
  self.m = self.m or from(self.m1,self.m2)
  self.x = self.x or math.floor(round(from(self.lo,self.hi)))
  return self.eq(self.m,self.x)
end

function MX:again() self.m = nil; return Var.again(self) end

function MX:squeeze(lo,hi)
  Var.squeeze(self,lo,hi)
  self.m  = nil
  self.x  = nil
end
```

## Cocomo
### Coc.project() : return a random project

```lua
Coc={}
function Coc.eq1(m,x) return m*(x-3)+1 end
function Coc.eq2(m,x) return math.max(0,m*(x-6))  end
function Coc.p(x,y)   return var{eq=Coc.eq1,lo=x or 1,hi=y or 5,m1= .073,m2= .21} end
function Coc.n(x,y)   return var{eq=Coc.eq1,lo=x or 1,hi=y or 5,m1=-.178,m2=-.078} end
function Coc.sf()     return var{eq=Coc.eq2,lo=1,     hi=6,     m1=-1.56,m2=-1.014} end

-- function Coc.project(    a,sf,p,n,out)
--   a = from(2.2, 9.18)
--   sf,p,n= Coc.sf, Coc.p, Coc.n
--   out = {}
--   out={  a   = var {lo = 2.2, high = 9.18},
--     b   = function () return (.85-1.1)/(9.18-2.2)*out.a()+1.1 + (1.1-.8)/2 end,
--     prec=sf(), flex=sf(),   arch=sf(),   team=sf(),   pmat=sf(),
--     rely=p(),  data=p(2,5), cplx=p(1,6), ruse=p(2,6), 
--     docu=p(),  time=p(3,6), stor=p(3,6), pvol=p(2,5),
--     acap=n(),  pcap=n(),    pcon=n(),    aexp=n(),    
--     plex=n(),  ltex=n(),    tool=n(),    site=n(1,6), sced=n()
--   }
--   sf = p.prec() +  p.flex() + p.arch() + p.team() + p.pmat() 
--   em = p.rely() *  p.data() *  p.cplx() *  p.ruse() * p.docu() * \
--        p.time() *  p.stor() *  p.pvol() * p.acap() *  p.pcap() *  \   
--        p.pcon() *  p.aexp() *  p.lex() *  p.ltex() *  p. tool() * \
--        p.site() *  p.sced()
--    return p.a*p.loc() ^ (p.b() + 0.01*sf) * em
```

### Coc.Risk

```lua
function Coc.risk(    _,ne,nw,nw4,sw4,ne46, sw26,sw46)
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
    pvol= {plex=sw2}, --2
    rely= {acap=sw4,  pcap=sw4,  pmat=sw4}, -- 12
    ruse= {aexp=sw46, ltex=sw46},  --8
    sced= {
      cplx=ne46, time=ne46, pcap=nw4, aexp=nw4, acap=nw4,  
      plex=nw4, ltex=nw, pmat=nw, rely=ne, pvol=ne, tool=nw}, -- 34
    stor= {acap=sw46, pcap=sw46}, --8
    team= {aexp=nw,  sced=nw,  site=nw}, --6
    time= {acap=sw46, pcap=sw46, tool=sw26}, --10
    tool= {acap=nw,  pcap=nw,  pmat=nw}} -- 6
end
```

## Data
### Columns
#### Define column types

```lua
function c(s,k)   return string.sub(s,1,1)==k end
function klass(x) return c(x,"!")  end 
function less(x)  return c(x,"<")  end
function goal(x)  return c(x,">")  or less(x) end
function num(x)   return c(x,"$")  or goal(x) end
function y(x)     return klass(x)  or goal(x) end
function x(x)     return not y(x)   end
function sym(x)   return not num(x) end
function xsym(z)  return x(z) and  sym(z) end
function xnum(z)  return x(z) and  num(z) end

function cols(all,f)
  return select(all, function(z) return f(z.txt) end)
end
```



<a name=top></a>
<p align=center>
<a href="https://github.com/timm/chop/blob/master/README.md#top">home</a> ::
<a href="https://github.com/timm/chop/blob/master/README.md#contribute">contribute</a> ::
<a href="https://github.com/timm/chop/issues">issues</a> ::
<a href="https://github.com/timm/chop/blob/master/README.md#license">&copy;2020<a> by <a href="http://menzies.us">Tim Menzies</a>
</p>
<h1 align=center> CHOP  v0.1<br>cluster and contrast</h1>
<p align=center>
<img width=400 src="https://i0.wp.com/studentwork.prattsi.org/infovis/wp-content/uploads/sites/3/2019/04/image-44.png?w=758&ssl=1"><br>
<img src="https://img.shields.io/badge/purpose-ai%20,%20se-blueviolet"> <a 
href="https://github.com/timm/lump/blob/master/LICENSE.md"> <img  
   alt="License" src="https://img.shields.io/badge/license-mit-red"></a> <a 
  href="https://zenodo.org/badge/latestdoi/289524083"> <img 
  src="https://zenodo.org/badge/289524083.svg" alt="DOI"></a> <img 
alt="Platform" src="https://img.shields.io/badge/platform-osx%20,%20linux-lightgrey"> <img 
alt="lisp" src="https://img.shields.io/badge/language-lua,bash-blue"> <a 
 href="https://travis-ci.org/github/timm/lump"><img alt="tests" 
   src="https://travis-ci.org/timm/lump.svg?branch=master"></a>
</p> 


- [Name](#name) 
    - [Description](#description) 
    - [Usage:](#usage) 
    - [Options](#options) 
- [Code](#code) 
    - [Modelling](#modelling) 
        - [Variables](#variables) 
            - [Cache](#cache--compute-and-cache-a-value-from-some-equation) : compute and cache a value from some equation
            - [Var](#var--compute-and-cache-one-variable) : compute and cache one variable.
        - [MX](#mx--compute-and-cache-two-variables) : compute and cache two variables.
    - [Cocomo](#cocomo) 
        - [Coc.project()](#cocproject--return-a-random-project) : return a random project
        - [Coc.Risk](#cocrisk) 
    - [Data](#data) 
        - [Columns](#columns) 
            - [Define column types](#define-column-types) 
    - [Lib](#lib) 
        - [Maths](#maths) 
            - [from(lo,hi)](#fromlohi--return-a-number-from-lo-to-hi) : return a number from `lo` to `hi`
            - [round(n,places)](#roundnplaces--round-n-to-some-decimal-places) : round `n` to some decimal `places`.
        - [Strings](#strings) 
            - [o(t,pre)](#otpre--return-t-as-a-string-with-prefix) : return `t` as a string, with `pre`fix
            - [oo(t,pre)](#ootpre--print-t-as-a-string-with-prefix) : print `t` as a string, with `pre`fix
            - [ooo(t,pre)](#oootpre--return-a-string-representing-ts-recursive-contents) : return a string representing `t`'s recursive contents.
        - [Meta](#meta) 
            - [id(x)](#idx--ensure-x-has-a-unique-if) : ensure `x` has a unique if
            - [same(z)](#samez--return-z) : return z
            - [fun(x)](#funx-returns-true-if-x-is-a-function) : returns true if `x` is a function
            - [map(t,f)](#maptf--apply-f-to-everything-in-t-and-return-the-result) : apply `f` to everything in `t` and return the result
            - [copy(t)](#copyt--return-a-deep-copy-of-t) : return a deep copy of `t`
            - [select(t,f)](#selecttf--return-a-table-of-items-in-t-that-satisfy-function-f) : return a table of items in `t` that satisfy function `f`
            - [ako(class,has)](#akoclasshas--create-a-new-instance-of-class-add-the-has-slides) : create a new instance of `class`, add the `has` slides
        - [Lists](#lists) 
            - [any(a)](#anya--sample-1-item-from-a) : sample 1 item from `a`
            - [anys(a,n)](#anysan--sample-n-items-from-a) : sample `n` items from `a`
            - [keys(t)](#keyst-iterate-over-keyvalues-sorted-by-key) : iterate over key,values (sorted by key)
        - [Files](#files) 
            - [csv(file)](#csvfile--iterate-through--non-empty-rows-divided-on-comma-coercing-numbers) : iterate through  non-empty rows, divided on comma, coercing numbers
            - [words(s,c,fun)](#wordsscfun--split-str-on-ch-default-coerce-using-fun-defaults-tonumiber) : split `str` on `ch` (default=`,`), coerce using `fun` (defaults= `tonumiber`)
            - [trim(str)](#trimstr--remove-leading-and-trailing-blanks) : remove leading and trailing blanks
    - [Testing](#testing) 
        - [Support code](#support-code) 
            - [eg(x)](#egx-run-the-test-function-egx-or-if-x-is-nil-run-all) : run the test function `eg_x` or, if `x` is nil, run all.
            - [within](#within) 
        - [Unit tests](#unit-tests) 
- [License](#license) 

# Name 
  chop

## Description
  Implement optimization over discrete and numeric attributes
  via clustering and contrast data mining methods. 

## Usage:
  lua chop.py Group [::group Group]* 

  Groups start with "::" and contain 1 or more options.
  Options start with ":" and contain 0 or 1 arguments.

## Options
  Options have  help text that start with a space then an
  uppercase letter. Optional arguments are 

    :C       ;; show copyright   
    :h       ;; show help   
    :seed 1  ;; set random number seed   
    ::test   ;; system stuff, set up test engine    
       :yes 0  
       :no  0

```lua

```
# Code
```lua

local the,c,klass,less,goal,num          = nil,nil,nil,nil,nil
local y,x,sym,xsym,xnum,cols             = nil,nil,nil,nil,nil,nil
local round,o,oo,ooo,id,same             = nil,nil,nil,nil,nil,nil 
local map, copy,select,any,anys,keys,csv = nil,nil,nil,nil,nil,nil
local within,rogues,eg,eg1,Eg,main       = nil,nil,nil,nil,nil,nil
local from,ako,var                       = nil,nil,nil
local Mx,mx,Coc                          = nil,nil


the = {aka={},
      id=0,
      seed=1,
      test= {yes=0,no=0}
}

```
## Modelling
### Variables
#### Cache : compute and cache a value from some equation
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

```
function Coc.project(    a,sf,p,n,out)
  a = from(2.2, 9.18)
  sf,p,n= Coc.sf, Coc.p, Coc.n
  out = {}
  out={  a   = var {lo = 2.2, high = 9.18},
    b   = function () return (.85-1.1)/(9.18-2.2)*out.a()+1.1 + (1.1-.8)/2 end,
    prec=sf(), flex=sf(),   arch=sf(),   team=sf(),   pmat=sf(),
    rely=p(),  data=p(2,5), cplx=p(1,6), ruse=p(2,6), 
    docu=p(),  time=p(3,6), stor=p(3,6), pvol=p(2,5),
    acap=n(),  pcap=n(),    pcon=n(),    aexp=n(),    
    plex=n(),  ltex=n(),    tool=n(),    site=n(1,6), sced=n()
  }
  sf = p.prec() +  p.flex() + p.arch() + p.team() + p.pmat() 
  em = p.rely() *  p.data() *  p.cplx() *  p.ruse() * p.docu() * \
       p.time() *  p.stor() *  p.pvol() * p.acap() *  p.pcap() *  \   
       p.pcon() *  p.aexp() *  p.lex() *  p.ltex() *  p. tool() * \
       p.site() *  p.sced()
   return p.a*p.loc() ^ (p.b() + 0.01*sf) * em
```lua

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
## Lib
### Maths
#### from(lo,hi) : return a number from `lo` to `hi`
```lua

function from(lo,hi) return lo+(hi-lo)*math.random() end

```
#### round(n,places) : round `n` to some decimal `places`.
```lua

function round(num, places)
  local mult = 10^(places or 0)
  return math.floor(num * mult + 0.5) / mult
end

```
### Strings
#### o(t,pre) : return `t` as a string, with `pre`fix
```lua
function o(z,pre,   s,sep) 
  s, sep = (pre or "")..'{', ""
  for _,v in pairs(z or {}) do s = s..sep..tostring(v); sep=", " end
  return s..'}'
end

```
#### oo(t,pre) : print `t` as a string, with `pre`fix
```lua
function oo(z,pre) print(o(z,pre)) end

```
#### ooo(t,pre) : return a string representing `t`'s recursive contents.
```lua
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

```
### Meta
#### id(x) : ensure `x` has a unique if
```lua
function id (x)
	if not x._id then the.id=the.id+1; x._id= the.id end
	return x._id 
end

```
#### same(z) : return z
```lua
function same(z) return z end

```
#### fun(x): returns true if `x` is a function
```lua
function fun(x) return assert(type(_ENV[x]) == "function", "not function") and x end

```
#### map(t,f) : apply `f` to everything in `t` and return the result
```lua
function map(t,f, u)
  u, f = {}, f or same
  for i,v in pairs(t or {}) do u[i] = f(v) end  
  return u
end

```
#### copy(t) : return a deep copy of `t`
```lua

function copy(obj, seen)
    -- Handle non-tables and previously-seen tables.
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    -- New table; mark it as seen and copy recursively.
    local s = seen or {}
    local res = {}
    s[obj] = res
    for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
    return setmetatable(res, getmetatable(obj))
end

```
#### select(t,f) : return a table of items in `t` that satisfy function `f`
```lua

function select(t,f,     g,u)
  u, f = {}, f or same
  for _,v in pairs(t) do if f(v) then u[#u+1] = v  end end
  return u
end

```
#### ako(class,has) : create a new instance of `class`, add the `has` slides 
```lua

function ako(klass,has,      new)
  new = copy(klass or {})
  for k,v in pairs(has or {}) do new[k] = v end
  setmetatable(new, klass)
  klass.__index = klass
  return new
end

```
### Lists
#### any(a) : sample 1 item from `a`
```lua

function any(a) return a[1 + math.floor(#a*math.random())] end

```
#### anys(a,n) : sample `n` items from `a`
```lua

function anys(a,n,   t) 
  t={}
  for i=1,n do t[#t+1] = any(a) end
  return t
end

```
#### keys(t): iterate over key,values (sorted by key)
```lua

function keys(t)
  local i,u = 0,{}
  for k,_ in pairs(t) do u[#u+1] = k end
  table.sort(u)
  return function () 
    if i < #u then 
      i = i+1
      return u[i], t[u[i]] end end 
end

```
### Files
#### csv(file) : iterate through  non-empty rows, divided on comma, coercing numbers
```lua

function csv(file,     stream,tmp,row)
  stream = file and io.input(file) or io.input()
  tmp    = io.read()
  return function()
    if tmp then
      row = words( tmp:gsub("[\t\r ]*","") )-- no whitespace
      tmp= io.read()
      if #row > 0 then return row end
    else
    io.close(stream) end end   
end

```
#### words(s,c,fun) : split `str` on `ch` (default=`,`), coerce using `fun` (defaults= `tonumiber`)
```lua
function words(str, ch, fun,  t,pat)
  t,f = {}, f or tonumber
  pat = "([^".. (ch or ",") .."]+)"
  for x in str:gmatch(pat) do t[#t+1] = f(x) or trim(x) end
  return t
end

```
#### trim(str) : remove leading and trailing blanks
```lua
function trim(str) return (str:gsub("^%s*(.-)%s*$", "%1")) end

```
-------------------------------------------------------------------
## Testing
### Support code
```lua

```
#### eg(x): run the test function `eg_x` or, if `x` is nil, run all.
```lua
function eg(t)
  if not t then print("") end
  for name,f in keys(Eg) do 
    if t then
       if name:match(t) then eg1(name,f) end
    else
       eg1(name,f) end end
end  

function eg1(name,f,   t1,t2,passed,err,y,n)
  the.test.yes = the.test.yes + 1
  t1 = os.clock()
  math.randomseed(the.seed)
  passed,err = pcall(f) 
  if passed then
    t2= os.clock()
    print(string.format("PASS! "..name.." \t: %8.6f secs", t2-t1))
  else
    the.test.no = the.test.no + 1
    y,n = the.test.yes,  the.test.no
    print(string.format("FAIL! "..name.." \t: %s [%.0f] %%",
        err:gsub("^.*: ",""), 
    100*y/(y+n))) end 
end

```
#### within
```lua
function within(x,y,z)
  assert(x <= y and y <= z, 'outside range ['..x..' to '..']')
end

--- #### rogues(): report escaped local variables
function rogues(   no)
  no = {the=true,
        tostring=true,  tonumber=true,  assert=true,  rawlen=true,
        pairs=true,  ipairs=true, collectgarbage=true,  pcall=true,
        rawget=true,  xpcall=true,  type=true,  print=true,
        rawequal=true,  setmetatable=true,  require=true,
        load=true,  rawset=true,  next=true,
        getmetatable=true,  select=true,  error=true,  dofile=true,
        loadfile=true,  jit=true, utf8=true, math=true,
        package=true, table=true, coroutine=true, bit=true, os=true,
        io=true, bit32=true, string=true, arg=true, debug=true,
        _VERSION=true, _G=true }
  for k,v in pairs( _G ) do
    if not no[k] then
      if k:match("^[^A-Z]") then
        print("-- ROGUE ["..k.."]") end end end
end

```
-------------------------------------------------------------------
### Unit tests
```lua
Eg={}

function Eg.test()   assert(1==2) end
function Eg.rnd()    assert(3.2==round(3.2222,1)) end
function Eg.o()      assert("{1, aa, 3}" == o({1,"aa",3})) end
function Eg.id(  a)  a={}; id(a); id(a); assert(1==a._id) end
function Eg.map( t)  assert(30 == map({1,2,3}, function (z) return z*10 end)[3]) end

function Eg.mx(v)
  v=mx({lo=1,hi=5,m1=.073,m2=.21, eq=function (m,x) return m*x end})
  print(1,5,v())
  v:squeeze(1)
  print(1,v(),v())
  ooo(v)
end

function Eg.Coc(  c) 
  for _ = 1,10^4 do 
    for k,v in keys(c or Coc.project()) do 
       if type(v) ~= "function" then v:again() end end end
end

function Eg.Coc1(  c) Eg.Coc( Coc.project()) end

```
-------------------------------------------------------------------
```lua

function argparse(str,     t,group,flag)
  t, group,flag = {}, "all","flag"
  t[group] = {}
  str = "::" .. group .. " " .. (str or table.concat(arg," "))
  for line in str:gmatch("([^\n]+)") do
    line = line:gsub("%;%;.*","")       
    for x in line:gmatch("([^ ]+)") do
      if x:sub(1,2) == "::" then   
        group = x:gsub("%:%:","")
        t[group] = t[group] or {}
      elseif x:sub(1,1) == ":" then 
        flag = x:gsub("%:","")
        t[group] = t[group] or {}
        t[group][flag] = false
      else
        t[group] = t[group] or {}
        t[group][flag] = tonumber(x) or x end end end
  return t
end

function update(now,b4)
  for group,t in pairs(now) do
    for flag,val in pairs(t) do
      assert(b4[group]       ~= nil,"group not defined ["..group.."]")
      assert(b4[group][flag] ~= nil,"flag not defined [" ..flag .."]")
      old = b4[group][flag]
      assert(type(old) == type(val))
      if type(old) == "boolean" then val = not old end
      b4[group][flag] = val end end
  return b4
end

function cli()
  the = update( argparse(), argparse(Opt) )
  if the.all.C then print(License) end
  if the.all.h then print(Help);print(Options) end
end

if not pcall(debug.getlocal,4,1) then cli() end

```
-------------------------------------------------------------------
```lua
return {the=the,main=main}
```

# License

Copyright 2020, Tim Menzies

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject
to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 


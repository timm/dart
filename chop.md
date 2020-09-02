<a name=top></a>
<p align=center>
<a href="https://github.com/timm/lump/blob/master/READ.md#top">home</a> ::
<a href="https://github.com/timm/lump/blob/master/READE.md#contribute">contribute</a> ::
<a href="https://github.com/timm/lump/issues">issues</a> ::
<a href="https://github.com/timm/lump/blob/master/LICENSE.md">&copy;2020<a> by <a href="http://menzies.us">Tim Menzies</a>
</p>

<h1 align=center> LUMP v0.1<br>cluster and contrast</h1>

<p align=center>
<img src="https://i0.wp.com/studentwork.prattsi.org/infovis/wp-content/uploads/sites/3/2019/04/image-44.png?w=758&ssl=1"><br>
<img src="https://img.shields.io/badge/purpose-ai%20,%20se-blueviolet"> <a 
href="https://github.com/timm/lump/blob/master/LICENSE.md"> <img  
   alt="License" src="https://img.shields.io/badge/license-mit-red"></a> <a 
  href="https://zenodo.org/badge/latestdoi/289524083"> <img 
  src="https://zenodo.org/badge/289524083.svg" alt="DOI"></a> <img 
alt="Platform" src="https://img.shields.io/badge/platform-osx%20,%20linux-lightgrey"> <img 
alt="lisp" src="https://img.shields.io/badge/language-sbcl,clisp-blue"> <a 
 href="https://travis-ci.org/github/timm/lump"><img alt="tests" 
   src="https://travis-ci.org/timm/lump.svg?branch=master"></a>
</p> 


- [Config](#config) : 
    - [the](#my--global-with-all-settings) : global with all settings
- [Data](#data) : 
    - [Columns](#columns) : 
        - [Define column types](#define-column-types) : 
- [Lib](#lib) : 
    - [Maths](#maths) : 
        - [round(n,places)](#roundnplaces--round-n-to-some-decimal-places) : round `n` to some decimal `places`.
    - [Strings](#strings) : 
        - [Interpolation](#interpolation) : 
        - [o(t,pre)](#otpre--return-t-as-a-string-with-prefix) : return `t` as a string, with `pre`fix
        - [oo(t,pre)](#ootpre--print-t-as-a-string-with-prefix) : print `t` as a string, with `pre`fix
        - [ooo(t,pre)](#oootpre--return-a-string-representing-ts-recursive-contents) : return a string representing `t`'s recursive contents.
    - [Meta](#meta) : 
        - [id(x)](#idx--ensure-x-has-a-unique-if) : ensure `x` has a unique if
        - [same(z)](#samez--return-z) : return z
        - [map(t,f)](#maptf--apply-f-to-everything-in-t-and-return-the-result) : apply `f` to everything in `t` and return the result
        - [copy(t)](#copyt--return-a-deep-copy-of-t) : return a deep copy of `t`
        - [select(t,f)](#selecttf--return-a-table-of-items-in-t-that-satisfy-function-f) : return a table of items in `t` that satisfy function `f`
    - [Lists](#lists) : 
        - [any(a)](#anya--sample-1-item-from-a) : sample 1 item from `a`
        - [anys(a,n)](#anysan--sample-n-items-from-a) : sample `n` items from `a`
        - [keys(t)](#keyst-iterate-over-keyvalues-sorted-by-key) : iterate over key,values (sorted by key)
    - [Files](#files) : 
        - [csv(file)](#csvfile--iterate-through--non-empty-rows-divided-on-comma-coercing-numbers) : iterate through  non-empty rows, divided on comma, coercing numbers
- [Testing](#testing) : 
    - [Support code](#support-code) : 
        - [within(x,y,z)](#withinxyz-y-is-between-x-and-z) : `y` is between `x` and `z`.
        - [rogues()](#rogues-report-escaped-local-variables) : report escaped local variables
        - [egs(x)](#egsx-run-the-test-function-egx-or-if-x-is-nil-run-all) : run the test function `eg_x` or, if `x` is nil, run all.
    - [Unit tests](#unit-tests) : 
- [Main](#main) : 



This is a _one file_ system where all the code
is in a markdown file and extraced using

    sh ell --code

## Config
### the : global with all settings
```lua
local the,c,klass,less,goal,num          = nil,nil,nil,nil,nil
local y,x,sym,xsym,xnum,cols             = nil,nil,nil,nil,nil,nil
local round,o,oo,ooo,id,same             = nil,nil,nil,nil,nil,nil 
local map, copy,select,any,anys,keys,csv = nil,nil,nil,nil,nil,nil
local within,rogues,eg,eg1,Eg,main       = nil,nil,nil,nil,nil,nil

the = {aka={},
      id=0,
      seed=1,
      test= {yes=0,no=0}
}
```
## Cocomo
### Coc.project() : return a random project
```lua
Coc={}
function Coc.project(    p,n,x,a) 
  function p(x,y) return a(Coc.Em,{lo=x or 1, hi=y or 5, m= .073, n= .21})   end
  function n(x,y) return a(Coc.Em,{lo=x or 1, hi=y or 5, m=-.178, n=-.078})  end
  function sf()   return a(Coc.Sf,{lo=1,      hi=6,      m=-1.56, n=-1.014}) end
  a = from(2.2, 9.18)
  return {a   = a,      
          b   = (.85-1.1)/(9.18-2.2)*a+1.1 + (1.1-.8)/2,
          prec= sf(), flex= sf(),   arch= sf(),   team= sf(),   pmat= sf(),
          rely= p(),  data= p(2,5), cplx= p(1,6), ruse= p(2,6), 
          docu= p(),  time= p(3,6), stor= p(3,6), pvol= p(2,5),
          acap= n(),  pcap= n(),    pcon= n(),    aexp= n(),    
          plex= n(),  ltex= n(),    tool= n(),    site= n(1,6), sced= n()})
end

Coc.Em={}
function Coc.Em:__call()
  self.m = self.m or from(self.m,self.n)
  self.x = self.x or round(from(self.lo,self.hi),0)
  return self.m*(self.x - 3) + 1
end

Coc.Sf={}
function Coc.Sf:__call()
  self.m = self.m or from(self.m,self.n)
  self.x = self.x or round(from(self.lo,self.hi),0)
  return self.m*(self.x - 6)
end

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
function copy(t)  
  return type(t) ~= 'table' and t or map(t,copy)
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
#### a(class,has) : create a new instance of `class`, add the `has` slides 
```lua
function a(klass,has,      new)
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
      tmp= tmp:gsub("[\t\r ]*","") -- no whitespace
      row={}
      for y in string.gmatch(tmp,"([^,]+)") do 
         row[#row+1] = tonumber(y) or y 
      end
      tmp= io.read()
      if #row > 0 then return row end
    else
    io.close(stream) end end   
end
```
## Testing
### Support code
#### within(x,y,z): `y` is between `x` and `z`.
```lua
function within(x,y,z)
  assert(x <= y and y <= z, 'outside range ['..x..' to '..']')
end
```
#### rogues(): report escaped local variables
```lua
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
### Unit tests
```lua 
Eg={}
function Eg.test()   assert(1==2) end
function Eg.rnd()    assert(3.2==round(3.2222,1)) end
function Eg.o()      assert("{1, aa, 3}" == o({1,"aa",3})) end
function Eg.id(  a)  a={}; id(a); id(a); assert(1==a._id) end
function Eg.map( t)
	assert(30 == map({1,2,3}, function (z) return z*10 end)[3])
end
```
## Main 
```lua
function main()
  if arg[1] == "-U" then 
    local status = eg(arg[2])
    rogues() 
    os.exit((the.test.yes - the.test.no == 1) and 0 or 1)
  end
end

if not pcall(debug.getlocal, 4, 1) then main() end

return {the=the,cli=cli}
```

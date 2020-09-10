local Help=[[
# Name 
  dart

## Description
  Implement optimization over discrete and numeric attributes
  via clustering and contrast data mining methods. 

## Usage
  lua dart.lua [Options] [--Group Options]* 

  Options start with "-" and contain 0 or 1 arguments.
  Options belong to different Groups (which start with --).

Options:

    -C          ;; show copyright   
    -h          ;; show help   
    -H          ;; show help (long version) 
    -seed 1     ;; set random number seed   
    -U fun      ;; run unit test 'fun' (and `all` runs everything)
    -id 0       ;; counter for object ids
    --test      ;; system stuff, set up test engine    
       -yes 0  
       -no  0
    --ch
       -klass !
       -less  <
       -more  >
       -num   $
       -skip  ?


# Details

## Requirements

- Lua >= 5.3

## Install

- Install Lua 5.3
- Download [dart.lua](dart.lua)
- Run and execute the unit tests 

     lua dart.lua -U

If that all works then you see one failing test
(when we test the test engine) and everything else passing.

## Contribute

Please follow these 
_Lua-isa-simple-language-so-lets-keep-it-simple_ c
onventions:

- Source code
  - All source code in one file.
    - All locals listed at top;
    - Application specific code at top;
    - General utilities at bottom,
    - Unit tests under nearly everything  else,  inside the `Eg` variable.
    - Second last is the main function to be called if this code is _not_ included into
      another library:
      - And I test for that using `not pcall(debug.getlocal, 4, 1)`.
    - Finally, there  is a return statement that exports the more useful parts of the code.
  - No globals (so keep the list of `local`s at top of file up to date).
  - The `the` local handles information and defaults shared across all functions and classes.
    - And this variable is initialized by parsing the [Usage](#usage) section of this help
      text/
  - Minimize use of the `local` keyword (so ugly)
    - Use it once at top of file.
    - Then (usually) define function locals as extra input arguments.
  - Indent code with 2 characters for tabs.
  - Using classes to divide the code. 
    - Update the non-class library code rarely (since that is functions global to the module).
    - Update the class code a lot.
  - Classes:
    - Use classes for polymorphism. 
    - Don't use inheritance (adds to debugging effort).
    - Classes are created by assigning some defaults to a global value;    
      e.g. `Emp={lname="", fname="", add=address() }`
    - Class constructors are lower case functions that call `isa(X)` 
      (where `X` is some class).
      - Typically for some `Klass`, the constrictor is the same name, starting with lower case (e.g. `klass`).
      - Constructors often use the idiom `new.x = y or the.zzz.y` where `y` is a parameter- S
    

## License

Copyright 2020,  
Tim Menzies,   
timm@ieee.org

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
]]

-- # Code

local the,c,klass,less,goal,num          = nil,nil,nil,nil,nil
local y,x,sym,xsym,xnum,cols             = nil,nil,nil,nil,nil,nil
local round,o,oo,ooo,id,same             = nil,nil,nil,nil,nil,nil 
local map, copy,select,any,anys,keys,csv = nil,nil,nil,nil,nil,nil
local within,rogues,eg,eg1,Eg,main       = nil,nil,nil,nil,nil,nil
local from,ako,var,words,trim,color      = nil,nil,nil,nil,nil,nil
local cli, options, fun                  = nil, nil, nil
local Coc                                = nil

-- ## Cocomo
-- ### Coc.all() : return a generator of COCOMO projects
Coc={}
function Coc.all(   eq1,eq2,pem,nem,sf,between,lohi)
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

-- ### Coc.all() : compute effort and risk for one project
function Coc.one(      r,c,    x,y)
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
       risk  = risk  + m[x[a1]][x[a2]] end end
  y.risk = risk/108
  return x,y,risk/108
end

-- ### Coc.Risk : Cocomo risk model

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

-- ## Data
-- ### Columns
-- #### Define column types

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

-- ## Lib
-- ### Maths
-- #### from(lo,hi) : return a number from `lo` to `hi`
function from(lo,hi) return lo+(hi-lo)*math.random() end

-- #### round(n,places) : round `n` to some decimal `places`.
function round(num, places)
  local mult = 10^(places or 0)
  return math.floor(num * mult + 0.5) / mult
end

-- ### Strings
-- #### o(t,pre) : return `t` as a string, with `pre`fix
function o(z,pre,   s,sep) 
  s, sep = (pre or "")..'{', ""
  for _,v in pairs(z or {}) do s = s..sep..tostring(v); sep=", " end
  return s..'}'
end

-- #### oo(t,pre) : print `t` as a string, with `pre`fix
function oo(z,pre) print(o(z,pre)) end

-- #### ooo(t,pre) : return a string representing `t`'s recursive contents.
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

-- ### Meta
-- #### id(x) : ensure `x` has a unique if
function id (x)
  if not x._id then the.all.id = the.all.id+1; x._id= the.all.id end
  return x._id 
end

-- #### same(z) : return z
function same(z) return z end

-- #### fun(x): returns true if `x` is a function
function fun(x) return assert(type(_ENV[x]) == "function", "not function") and x end

-- #### map(t,f) : apply `f` to everything in `t` and return the result
function map(t,f, u)
  u, f = {}, f or same
  for i,v in pairs(t or {}) do u[i] = f(v) end  
  return u
end

-- #### copy(t) : return a deep copy of `t`
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

-- #### select(t,f) : return a table of items in `t` that satisfy function `f`
function select(t,f,     g,u)
   u, f = {}, f or same
   for _,v in pairs(t) do if f(v) then u[#u+1] = v  end end
   return u
end

-- #### ako(class,has) : create a new instance of `class`, add the `has` slides 
function ako(klass,has,      new)
   new = copy(klass or {})
   for k,v in pairs(has or {}) do new[k] = v end
   setmetatable(new, klass)
   klass.__index = klass
   return new
end

-- ### Lists
-- #### any(a) : sample 1 item from `a`
function any(a) return a[1 + math.floor(#a*math.random())] end

-- #### anys(a,n) : sample `n` items from `a`
function anys(a,n,   t) 
  t={}
  for i=1,n do t[#t+1] = any(a) end
  return t
end

-- #### keys(t): iterate over key,values (sorted by key)
function keys(t)
  local i,u = 0,{}
  for k,_ in pairs(t) do u[#u+1] = k end
  table.sort(u)
  return function () 
    if i < #u then 
      i = i+1
  return u[i], t[u[i]] end end 
end

-- ### Files
-- #### csv(file) : iterate through  non-empty rows, divided on comma, coercing numbers
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

-- #### words(s,c,fun) : split `str` on `ch` (default=`,`), coerce using `fun` (defaults= `tonumiber`)
function words(str, ch, fun,  t,pat)
  t,f = {}, f or tonumber
  pat = "([^".. (ch or ",") .."]+)"
  for x in str:gmatch(pat) do t[#t+1] = f(x) or trim(x) end
  return t
end

-- #### trim(str) : remove leading and trailing blanks
function trim(str) return (str:gsub("^%s*(.-)%s*$", "%1")) end

do local cols={red=31,green=32,eplain=0}
  function color(col,str)
  return '\27[1m\27['..cols[col]..'m'..str..'\27[0m' end
end
-- -------------------------------------------------------------------
-- ## Testing
-- ### Support code

-- #### eg(x): run the test function `eg_x` or, if `x` is nil, run all.
Eg={}
function eg(name,   t1,t2,passed,err,y,n)
  if name=="fun" then return 1 end
  f= Eg[name]
  the.test.yes = the.test.yes + 1
  t1 = os.clock()
  math.randomseed(the.all.seed)
  passed,err = pcall(f) 
  if passed then
    t2= os.clock()
    print(color("green",
                string.format("PASS! "..name.." \t: %8.6f secs",
                              t2-t1)))
  else
    the.test.no = the.test.no + 1
    y,n = the.test.yes,  the.test.no
    print(color("red",
                 string.format("FAIL! "..name.." \t: %s [%.0f] %%",
                               err:gsub("^.*: ",""), 
    100*y/(y+n)))) end 
end

-- #### within
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

-- -------------------------------------------------------------------
-- ### Unit tests
function Eg.fun()   return true end
function Eg.all()   print("")
                    for k,_ in keys(Eg) do
                      if k~="all" and k~="fun" then  
                        eg(k) end end end
function Eg.test()  assert(1==2) end
function Eg.rnd()   assert(3.2==round(3.2222,1)) end
function Eg.o()     assert("{1, aa, 3}" == o({1,"aa",3})) end
function Eg.id(  a) a={}; id(a); id(a); assert(1==a._id) end
function Eg.map( t) assert(30 == map({1,2,3}, function (z) return z*10 end)[3]) end

function Eg.coc(    x,y,z,s,sep)
  x,y,z = Coc.one()
  print("::",y.effort,z)
  s,sep="",""
  for k,_ in keys(y) do 
    s= s..sep..k; sep="," end 
  print(s)
  s,sep="",""
  for k,y1 in keys(y) do 
     s=s .. sep.. round(y1 or 0,3); sep=","
  end 
  print(s)
end

-- -------------------------------------------------------------------
-- ## Command Line
-- ### options(now,b4) : return a tree with options from `b4` updated with `now`
function options(now,b4)
  local function parse(str,    t,g,o)
    t, g, o = {}, "all", "opt"
    t[g] = {}
    str = "--" .. g .. " " .. str
    for line in str:gmatch("([^\n]+)") do
      line = line:gsub("%;%;.*","")     
      for x in line:gmatch("([^ ]+)") do
        local g0 = x:match("^%-%-(.*)")
        if   g0 
        then g = g0; t[g] = t[g] or {}
        else local o0 = x:match("^%-([^%-].*)")
             if   o0 
             then o = o0; t[g][o] = false
             else t[g][o] = tonumber(x) or x end end end end
    return t
  end
  -------------------------------
  now, b4 = parse(now), parse(b4)
  for g,t in pairs(now) do
    for o,new in pairs(t) do
      if b4[g] ~= nil then
        old = b4[g][o]
        if old ~= nil then
          if type(old) == type(new) then
            if type(old) == "boolean" then new = not old end
            b4[g][o] = new 
          else print("Oops: option "..o.." wanted "..type(old)) end
        else   print("Oops: option "..o.." undefined") end
      else     print("Oops: group " ..g.." undefined") end end end
  return b4
end

-- ### cli() : initialize the `the` variable and run command-line options.
function cli()
  the = options( table.concat(arg," "),
                 Help:match("\nOptions[^\n]*\n\n([^#]+)#"))
  if the.all.C then print(Help:match("\n## License[%s]*(.*)")) end
  if the.all.h then print(Help:match("(.*)\n# Details")) end
  if the.all.H then print(Help) end
  eg(the.all.U) 
  rogues()
end

-- --------------------------------------------------------------------
-- ## start-up
-- If called at top level, run `cli()`.
if not pcall(debug.getlocal,4,1) then cli() end

-- Return the names that external people can access
return {the=the,main=main}

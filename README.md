<a name=top></a>
<p align=center>
<a href="https://github.com/timm/dart/blob/master/README.md#top">home</a> ::
<a href="https://github.com/timm/dart/blob/master/README.md#contribute">contribute</a> ::
<a href="https://github.com/timm/dart/issues">issues</a> ::
<a href="https://github.com/timm/dart/blob/master/README.md#license">&copy;2020<a> by <a href="http://menzies.us">Tim Menzies</a>
</p>
<h1 align=center> Dart  v0.1<br>cluster and sample and contrast</h1>
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



# Name 
  dart

## Description
  Optimize = cluster plus sample plus contrast;
  i.e. divide problem space into chunks;
  dart, a little, around the chunks;
  report back anything that jumps you between chunks.

## Usage
  lua dart.lua [Options] [--Group Options]* 

  Options start with "-" and contain 0 or 1 arguments.
  Options belong to different Groups (which start with --).

Options:

    -C           ;; show copyright   
    -h           ;; show help   
    -H           ;; show help (long version) 
    -seed 1      ;; set random number seed   
    -U fun       ;; run unit test 'fun' (and `all` runs everything)
    -id 0        ;; counter for object ids
    --test       ;; system stuff, set up test engine    
       -yes   0  
       -no    0
    --some
       -max   256
    --type       ;; when reading csv files, names in row1 have
                 ;; magic symbols telling us their type.
       -klass !  ;; symbolic class
       -less  <  ;; numeric goal to be minimized
       -more  >  ;; numeric goal to be maximized
       -num   $  ;; numeric
       -skip  ?  ;; to be ignored
  

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

- [`Coc`omo](#cocomo) 
    - [`Coc`.all()](#cocall--return-a-generator-of-cocomo-projects) : return a generator of COCOMO projects
    - [`Coc`.all()](#cocall--compute-effort-and-risk-for-one-project) : compute effort and risk for one project
    - [`Coc`.Risk](#cocrisk--cocomo-risk-model) : Cocomo risk model
- [Data](#data) 
    - [Managing single columns of data](#managing-single-columns-of-data) 
        - [adds(t, klass)](#addst-klass--all-everything-in-t-into-a-column-of-type-klass) : all everything in `t` into a column of type `klass`
        - [col(c,txt="",pos=0)](#colctxtpos0--initialize-a-column) : initialize a column
        - [`Num`eric Columns](#numeric-columns) 
            - [`Num`:add(x)](#numaddx--add-x-to-the-receiver) : add `x` to the receiver
        - [`Sym`bolic Columns](#symbolic-columns) 
            - [`Sym`:add(x)](#symaddx--add-x-to-the-receiver) : add `x` to the receiver
            - [`Sym`:ent()](#syment--return-the-entropy-of-the-symbols-seen-in-this-column) : return the entropy of the symbols seen in this column
        - [`Some` Column](#some-column-resovoir-samplers) : resovoir samplers
            - [`Some`:add(x)](#someaddx--add-x-to-the-receiver) : add `x` to the receiver
            - [`Some`:all()](#someall--return-all-kept-items-sorted) : return all kept items, sorted
    - [`Cols`](#cols--place-to-store-lots-of-columns) : place to store lots of columns
        - [`Cols`.new(t)](#colsnewt--return-a-news-cols-with-all-the-nums-and-syms-filled-in) : return a news `cols` with all the `nums` and `syms` filled in
        - [`Col`umn types (string types)](#column-types-string-types) 
        - [`Cols`:push2(x)](#colspush2x--add-a-column-to-all-nums-and-syms) : add a column, to `all`, `nums` and `syms`
        - [`Cols`:row(t)](#colsrowt--return-a-row-containing-cells-updating-the-summaries) : return a row containing `cells`, updating the summaries.
    - [`Rows`](#rows--class-a-place-to-store-cols-and-rows) : class; a place to store `cols` and `rows`.
        - [`Rows`:clone()](#rowsclone--return-a-new-rows-with-the-same-structure-as-the-receiver) : return a new `Rows` with the same structure as the receiver
        - [`Rows`:read(file)](#rowsreadfile--read-in-data-from-a-csv-file) : read in data from a csv `file`
        - [`Rows`:add(t)](#rowsaddt--turn-the-first-row-into-a-columns-header-the-rest-into-data-rows) : turn the first row into a columns header, the rest into data rows
    - [`Row`](#row--a-place-to-hold-one-example) : a place to hold one example
        - [`Row`.new(t)](#rownewt--initialize-a-new-row) : initialize a new row
- [Miscellaneous Functions](#miscellaneous-functions) 
    - [Maths](#maths) 
        - [from(lo,hi)](#fromlohi--return-a-number-from-lo-to-hi) : return a number from `lo` to `hi`
        - [round(n,places)](#roundnplaces--round-n-to-some-decimal-places) : round `n` to some decimal `places`.
    - [Strings](#strings) 
        - [o(t,pre)](#otpre--return-t-as-a-string-with-prefix) : return `t` as a string, with `pre`fix
        - [oo(t,pre)](#ootpre--print-t-as-a-string-with-prefix) : print `t` as a string, with `pre`fix
        - [ooo(t,pre)](#oootpre--return-a-string-representing-ts-recursive-contents) : return a string representing `t`'s recursive contents.
    - [Meta](#meta) 
        - [id(x)](#idx--ensure-x-has-a-unique-if) : ensure `x` has a unique if
        - [same(z)](#samez--return-z) : return z
        - [lt(x,y)](#ltxy--return-xy) : return `x<y`
        - [fun(x)](#funx-returns-true-if-x-is-a-function) : returns true if `x` is a function
        - [map(t,f)](#maptf--apply-f-to-everything-in-t-and-return-the-result) : apply `f` to everything in `t` and return the result
        - [copy(t)](#copyt--return-a-deep-copy-of-t) : return a deep copy of `t`
        - [select(t,f)](#selecttf--return-a-table-of-items-in-t-that-satisfy-function-f) : return a table of items in `t` that satisfy function `f`
        - [ako(class,has)](#akoclasshas--create-a-new-instance-of-class-add-the-has-slides-) : create a new instance of `class`, add the `has` slides 
    - [Lists](#lists) 
        - [any(a)](#anya--sample-1-item-from-a) : sample 1 item from `a`
        - [anys(a,n)](#anysan--sample-n-items-from-a) : sample `n` items from `a`
        - [keys(t)](#keyst-iterate-over-keyvalues-sorted-by-key) : iterate over key,values (sorted by key)
        - [binChop(t,x)](#binchoptx--return-a-position-very-near-x-within-t) : return a position very near `x` within `t`
    - [Files](#files) 
        - [csv(file)](#csvfile--iterate-through--non-empty-rows-divided-on-comma-coercing-numbers) : iterate through  non-empty rows, divided on comma, coercing numbers
        - [words(s,pat,fun)](#wordsspatfun--split-str-on-pat-default-coerce-using-fun-defaults-tonumiber) : split `str` on `pat` (default=`,`), coerce using `fun` (defaults= `tonumiber`)
        - [trim(str)](#trimstr--remove-leading-and-trailing-blanks) : remove leading and trailing blanks
        - [color(theColor,str)](#colorthecolorstr--print-str-using-thecolor) : print `str` using `theColor`
- [Unit Tests](#unit-tests) 
    - [Support code](#support-code) 
        - [eg(x)](#egx-run-the-test-function-egx-or-if-x-is-nil-run-all) : run the test function `eg_x` or, if `x` is nil, run all.
        - [within(x,y,z)](#withinxyz) 
        - [rogues()](#rogues--report-escaped-local-variables) : report escaped local variables
    - [Unit tests](#unit-tests) 
- [Command Line](#command-line) 
    - [options(now,b4)](#optionsnowb4--return-a-tree-with-options-from-b4-updated-with-now) : return a tree with options from `b4` updated with `now`
    - [cli()](#cli--initialize-the-the-variable-and-run-command-line-options) : initialize the `the` variable and run command-line options.
- [start-up](#start-up) 




```lua

local the,c,klass,less,goal,num          = nil,nil,nil,nil,nil
local y,x,sym,xsym,xnum,cols,lt          = nil,nil,nil,nil,nil,nil,nil
local round,o,oo,ooo,id,same             = nil,nil,nil,nil,nil,nil 
local map, copy,select,any,anys,keys,csv = nil,nil,nil,nil,nil,nil
local within,rogues,eg,eg1,Eg,main       = nil,nil,nil,nil,nil,nil
local from,ako,var,words,trim,color      = nil,nil,nil,nil,nil,nil
local cli, options, fun                  = nil,nil, nil
local some,binChop,col,adds              = nil,nil,nil,nil
local Coc,Num,Some,Sym                   = nil,nil,nil,nil

```
# `Coc`omo
## `Coc`.all() : return a generator of COCOMO projects
```lua
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

```
## `Coc`.all() : compute effort and risk for one project
```lua
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
       risk  = risk  + m[x[a1]][x[a2]] end end
  y.risk = risk/108
  return x,y,risk/108
end

```
## `Coc`.Risk : Cocomo risk model
```lua

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

```
# Data
## Managing single columns of data
### adds(t, klass) : all everything in `t` into a column of type `klass`
```lua
function adds(t, klass,thing)
  klass = klass or (type(t[1]) == "number" and Num or Sym)
  thing = klass.new()
  for _,x in pairs(t) do thing:add(x) end
  return thing
end

```
### col(c,txt="",pos=0) : initialize a column
```lua
function col(c, txt,pos)
  c.n   = 0
  c.txt = txt or ""
  c.pos = pos or 0
  c.w   = c.txt:find(the.type.less) and -1 or 1
  return c
end

```
### `Num`eric Columns
```lua
Num = {n=1, pos=0, txt="", mu=0, m2=0, sd=0,
       lo=math.huge, hi= -math.huge}

function Num.new(txt,pos) return col(ako(Num),txt,pos) end

```
#### `Num`:add(x) : add `x` to the receiver
```lua
function Num:add(x,    d) 
  if x == the.type.skip then return x end
  self.n  = self.n + 1
  d       = x - self.mu
  self.mu = self.mu + d/self.n
  self.m2 = self.m2 + d*(x - self.mu)
  self.sd = (self.m2<0 or self.n<2) and 0 or (self.m2/(self.n-1))^0.5
  self.lo = math.min(x, self.lo)
  self.hi = math.max(x, self.hi) 
  return x
end

```
### `Sym`bolic Columns
```lua
Sym = {n=1, pos=0, txt="", most=0, seen={}}

function Sym.new(txt,pos) return col(ako(Sym),txt,pos) end

```
#### `Sym`:add(x) : add `x` to the receiver
```lua
function Sym:add(x,    new)
  if x == the.type.skip then return x end
  self.n       = self.n + 1
  self.seen[x] = (self.seen[x] or 0) + 1
  if self.seen[x] > self.most then 
    self.most,self.mode = self.seen[x],x end
  return x
end

```
#### `Sym`:ent() : return the entropy of the symbols seen in this column
```lua
function Sym:ent(     e,p)
  e = 0
  for _,v in pairs(self.seen) do
    if v>0 then
      p = v/self.n
      e = e - p*math.log(p,2) end end
  return e
end

```
### `Some` Column: resovoir samplers
```lua
Some= {n=1, pos=0, txt="", t={}, old=false, max=256}

function Some.new(txt,pos,max,   c) 
  return col(ako(Some,{max=max or the.some.max}),
             txt,pos) end

```
#### `Some`:add(x) : add `x` to the receiver
```lua
function Some:add(x,   pos)
  if x == the.type.skip then return x end
  self.n = self.n + 1
  if #self.t < self.max then 
    pos = #self.t+1   -- add to end
  elseif math.random() < self.max/self.n then 
    pos = math.random(#self.t) -- replace any old thing
  end
  if pos then self.t[pos]=x; self.old=true end
  return x
end

```
#### `Some`:all() : return all kept items, sorted
```lua
function Some:all(   f) 
  if self.old then table.sort(self.t,f or lt); self.old=false end
  return self.t
end

```
## `Cols` : place to store lots of columns
```lua
Cols = {use  = {},
        hdr  = {},
        x    = {nums={}, syms={}, all={}},
        y    = {nums={}, syms={}, all={}},
        cols = {nums={}, syms={}, all={}}}

```
### `Cols`.new(t) : return a news `cols` with all the `nums` and `syms` filled in
```lua
function Cols.new(t)         
   local put, new = 0, ako(Cols)
   local function remember(x,a)
      push(x, a.all)
      push(x, a[new:nump(x.txt) and "nums" or "syms"])  
   end
  for get,txt in pairs(t) do
    if new:skip(txt) then
      put          = put + 1
      new.use[put] = get
      new.hdr[put] = txt
      what         = (new:nump(txt) and Num or Sym).new(put,txt)
      remember(what, new.cols)
      remember(what, new:goalp(txt) and new.y or new.x) end end
  return new
end

```
### `Col`umn types (string types)
```lua
function Cols:has(s,x) return s:find(the.all.type[x]) end 
function Cols:skip(s)  return self:has(s,"skip") end
function Cols:obj(s)   return self:has(s,"less") or self:has(s,"more") end
function Cols:nump(s)  return self:obj(s) or self:has(s,"num") end
function Cols:goalp(s) return self:obj(s) or self:has(s,"klass") end

```
### `Cols`:push2(x) : add a column, to `all`, `nums` and `syms`
### `Cols`:row(t) : return a row containing `cells`, updating the summaries.
```lua
function Cols:row(cells,     using,col,val)
  using = {}
  for put,get in pairs(self.use) do 
    col, val = self.cols.all[put], cells[get]
    using[put]   = col:add(val) 
  end
  return Row.new(using)
end

```
## `Rows` : class; a place to store `cols` and `rows`.
```lua
Rows = {cols={},rows={}}

```
### `Rows`:clone() : return a new `Rows` with the same structure as the receiver
```lua
function Rows:clone() 
  return ako(Rows,{cols=cols(self.cols.hdr)})   
end

```
### `Rows`:read(file) : read in data from a csv `file`
```lua
function Rows:read(file) 
  for t in csv(file) do self:add(t) end
  return self 
end

```
### `Rows`:add(t) : turn the first row into a columns header, the rest into data rows
```lua
function Rows:add(t)
  t = t.cells and t.cells or t
  if   self.cols 
  then t.rows[#t.rows+1] = self.cols:row(t) 
  else self.cols = cols(t) 
  end
end

```
## `Row` : a place to hold one example
```lua
Row = {cells={},cooked={}}

```
### `Row`.new(t) : initialize a new row
```lua
function Row.new(t) return ako(Row,{cells=t}) end

```
-------------------------------------------------------------------
# Miscellaneous Functions
## Maths
### from(lo,hi) : return a number from `lo` to `hi`
```lua
function from(lo,hi) return lo+(hi-lo)*math.random() end

```
### round(n,places) : round `n` to some decimal `places`.
```lua
function round(num, places)
  local mult = 10^(places or 0)
  return math.floor(num * mult + 0.5) / mult
end

```
## Strings
### o(t,pre) : return `t` as a string, with `pre`fix
```lua
function o(z,pre,   s,sep) 
  s, sep = (pre or "")..'{', ""
  for _,v in pairs(z or {}) do s = s..sep..tostring(v); sep=", " end
  return s..'}'
end

```
### oo(t,pre) : print `t` as a string, with `pre`fix
```lua
function oo(z,pre) print(o(z,pre)) end

```
### ooo(t,pre) : return a string representing `t`'s recursive contents.
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
## Meta
### id(x) : ensure `x` has a unique if
```lua
function id (x)
  if not x._id then the.all.id = the.all.id+1; x._id= the.all.id end
  return x._id 
end

```
### same(z) : return z
```lua
function same(z) return z end

```
### lt(x,y) : return `x<y`
```lua
function lt(x,y) return x<y end

```
### fun(x): returns true if `x` is a function
```lua
function fun(x) return assert(type(_ENV[x]) == "function", "not function") and x end

```
### map(t,f) : apply `f` to everything in `t` and return the result
```lua
function map(t,f, u)
  u, f = {}, f or same
  for i,v in pairs(t or {}) do u[i] = f(v) end  
  return u
end

```
### copy(t) : return a deep copy of `t`
```lua
function copy(obj,   old,new)
  if type(obj) ~= 'table' then return obj end
  if old and old[obj] then return old[obj] end
  old, new = old or {}, {}
  old[obj] = new
  for k, v in pairs(obj) do new[copy(k, old)]=copy(v, old) end
  return setmetatable(new, getmetatable(obj))
end

```
### select(t,f) : return a table of items in `t` that satisfy function `f`
```lua
function select(t,f,     g,u)
  u, f = {}, f or same
  for _,v in pairs(t) do if f(v) then u[#u+1] = v  end end
  return u
end

```
### ako(class,has) : create a new instance of `class`, add the `has` slides 
```lua
function ako(klass,has,      new)
  new = copy(klass or {})
  for k,v in pairs(has or {}) do new[k] = v end
  setmetatable(new, klass)
  klass.__index = klass
  return new
end

```
## Lists
### any(a) : sample 1 item from `a`
```lua
function any(a) return a[1 + math.floor(#a*math.random())] end

```
### anys(a,n) : sample `n` items from `a`
```lua
function anys(a,n,   t) 
  t={}
  for i=1,n do t[#t+1] = any(a) end
  return t
end

```
### keys(t): iterate over key,values (sorted by key)
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
### binChop(t,x) : return a position very near `x` within `t`
```lua
function binChop (t,x,    lo,hi,mid)
  lo,hi = 1,#t
  while lo <= hi do
    mid = math.floor((lo+hi)/2)
    if     t[mid] > x then hi = mid - 1
    elseif t[mid] < x then lo = mid + 1
    else   break end end
  return mid
end

```
## Files
### csv(file) : iterate through  non-empty rows, divided on comma, coercing numbers
```lua
function csv(file,     ch,fun,   pat,stream,tmp,row)
  stream = file and io.input(file) or io.input()
  tmp    = io.read()
  pat    = "([^".. (ch or ",") .."]+)"
  fun    = tonumber
  return function()
    if tmp then
      row = words(tmp:gsub("[\t\r ]*",""),pat,fun)-- no spaces
      tmp = io.read()
      if #row > 0 then return row end
    else
  io.close(stream) end end   
end

```
### words(s,pat,fun) : split `str` on `pat` (default=`,`), coerce using `fun` (defaults= `tonumiber`)
```lua
function words(str,pat,fun,   t)
  t = {}
  for x in str:gmatch(pat) do t[#t+1] = fun(x) or trim(x) end
  return t
end

```
### trim(str) : remove leading and trailing blanks
```lua
function trim(str) return (str:gsub("^%s*(.-)%s*$", "%1")) end

```
### color(theColor,str) : print `str` using `theColor`
```lua
do local colors={red=31, green=32,  plain=0}
  function color(col,str)
  return '\27[1m\27['..colors[col]..'m'..str..'\27[0m' end
end

```
-------------------------------------------------------------------
# Unit Tests
## Support code
```lua

```
### eg(x): run the test function `eg_x` or, if `x` is nil, run all.
```lua
function eg(name,   f,t1,t2,passed,err,y,n)
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

```
### within(x,y,z)
```lua
function within(x,y,z)
  assert(x <= y and y <= z, 'outside range ['..x..' to '..']')
end

```
### rogues() : report escaped local variables
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
-------------------------------------------------------------------
## Unit tests
```lua
Eg={}
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

function Eg.csv( n) 
  n=0
  for row in csv("data/weather.csv") do 
    n=n+1
  end
  assert(n==15)
end

function Eg.copy(    a,b)
  a={m=10, n={o=20, p={q=30, r=40}, s=50}}
  b=copy(a)
  a.n.p.q=200
  assert(30 == b.n.p.q)
end

function Eg.chop(t,n)
  t={}
  n=10^4
  for _ = 1,n do t[#t+1]= math.random() end
  table.sort(t)
  print(n*.245 <= binChop(t,0.25) )
  print(binChop(t,0.25) <= n*.255)
  print(binChop(t,2)==n)
  print(binChop(t,-1)==1)
end

function Eg.some(s)
  s =Some.new()
  s.max = 32
  for i = 1,10^4 do s:add(i) end
end

function Eg.sym(  s)
   s=adds({"a","a","a","a","b","b","c"},Sym)
   assert(1.378 <= s:ent() and s:ent() <= 1.379)
   s=adds({"a","a","a","a","a","a","a"},Sym)
   assert(s:ent()==0)
end

function Eg.num()
  local l,r,c=math.log,math.random, math.cos
  local function norm(mu,sd)
    mu, sd = mu or 0, sd or 1
    return mu + sd*(-2*l(r()))^0.5*c(6.2831853*r()) 
  end
  local n=Num.new()
  local mu, sd=10,3
  for _ = 1,1000 do n:add(norm(10,3)) end
  assert(mu*.95<=n.mu and n.mu<=mu*1.05)
  assert(sd*.95<=n.sd and n.sd<=sd*1.05)
end

```
-------------------------------------------------------------------
# Command Line
## options(now,b4) : return a tree with options from `b4` updated with `now`
```lua
function options(now,b4,   old)
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

```
## cli() : initialize the `the` variable and run command-line options.
```lua
function cli()
  the = options( table.concat(arg," "),
                 Help:match("\nOptions[^\n]*\n\n([^#]+)#"))
  math.randomseed(the.all.seed)
  Eg.num()
  if the.all.C then print(Help:match("\n# License[%s]*(.*)")) end
  if the.all.h then print(Help:match("(.*)\n# Details")) end
  if the.all.H then print(Help) end
  eg(the.all.U) 
  rogues()
end

```
--------------------------------------------------------------------
# start-up
If called at top level, run `cli()`.
```lua
if not pcall(debug.getlocal,4,1) then cli() end

```
Return the names that external people can access
```lua
return {the=the,cli=cli,Some=Some,Num=Num,Sym=Sym}
```


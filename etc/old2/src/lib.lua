local within,from,round,o,oo,ooo = nil, nil. nil, nil,nil, nil
        id,same,map,copy,select  = nil,nil,nil,nil,nil
        ako,any,anys,keys,csv    = nil nil,nil,nil,nil

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
	if not x._id then the.id=the.id+1; x._id= the.id end
	return x._id 
end

-- #### same(z) : return z

function same(z) return z end

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

return {within=within,from=from,round=round,o=o,oo=oo,ooo=ooo,
        id=id,same=same,map=map,copy=copy,select=select,
        ako=ako,any=any,anys=anys,keys=keys,csv=csv}


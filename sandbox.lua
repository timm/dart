local Opts=[[
# Name 
  chop

## Description
  Implement optimization over discrete and numeric attributes
  via clustering and contrast data mining methods. 

## Usage:
  lua chop.py Group [--group Group]* 

  Groups start with "--" and contain 1 or more options.
  Options start with "-" and contain 0 or 1 arguments.

## Options
  Options have  help text that start with a space then an
  uppercase letter. Optional arguments are 

--main
  -h          Show this screen.
  -C          Show this copyright.
  -U=[all]    Run one or more unit test functions 
  -speed=<kn> Speed in knots [default: 10].

 --bayes 

--flag:options:default:help                                         : handler : rule 
-- ---:-------:-------:---------------------------------------------:---------:-----
   U  : [Fun] :       :run tests matching 'Fun' (if musing, run all): eg      : fun
   h  :       :       :print help                                   : help    : 
   C  :       :       :Show license                                 : license :
]]

function trim(str) return (str:gsub("^%s*(.-)%s*$", "%1")) end

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

function argparse(str,     t,group,flag)
  t, group = {}, "all"
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
        t[group][flag] = false
      else
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

eg= [[ 
    :C       ;; show copyright   
    :h       ;; show help   
    :seed 1  ;; set random number seed   
    ::test   ;; system stuff, set up test engine    
       :yes 0  
       :no  0
]]
b4=argparse()
ooo(b4)
print("")
now=argparse( ":Cc ::test :yes 1")
now=update(now,b4)
print("")
ooo(now)
--now = newargs(now,b4)
--:w
--ooo(b4)

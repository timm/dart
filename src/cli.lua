local function options(now,b4,   old)
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
             else t[g][o] = tonumber(x) or x 
    end end end end
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
      else     print("Oops: group " ..g.." undefined") 
  end end end
  return b4
end

local function cli()
  the = options( table.concat(arg," "),
                 Help:match("\nOptions[^\n]*\n\n([^#]+)#"))
  math.randomseed(the.all.seed)
  if the.all.C then print(Help:match("\n# License[%s]*(.*)")) end
  if the.all.h then print(Help:match("(.*)\n# Details")) end
  if the.all.H then print(Help) end
  eg(the.all.U) 
  Eg[the.all.R]()
  rogues()
  s="cass"
  if s:find(the.type["klass"]) then
     print(11)
  end
end

if not pcall(debug.getlocal,4,1) then cli() end

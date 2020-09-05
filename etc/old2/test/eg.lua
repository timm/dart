-- ## Testing
-- ### Support code

-- #### eg(x): run the test function `eg_x` or, if `x` is nil, run all.
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


-- vim : ft=lua ts=2 sw=2 et:

Eg={}

function eg(name,       f,t1,t2,t3,passed,err,y,n)
  if name=="fun" then return 1 end
  f= Eg[name]
  the.test.yes = the.test.yes + 1
  t1 = os.clock()
  math.randomseed(the.all.seed)
  passed,err = pcall(f) 
  t3= os.date("%X :")
  if passed then
    t2= os.clock()
    print(
     color("green",string.format("%s PASS! "..name.." \t: %8.6f secs",
                                 t3, t2-t1)))
  else
    the.test.no = the.test.no + 1
    y,n = the.test.yes,  the.test.no
    print(
     color("red",string.format("%s FAIL! "..name.." \t: %s [%.0f] %%",
                         t3, err:gsub("^.*: ",""), 100*y/(y+n)))) end 
end

function within(x,y,z)
  assert(x <= y and y <= z, 'outside range ['..x..' to '..']')
end

function rogues(   no)
   no = {
      the=true, tostring=true,  tonumber=true, assert=true,
      rawlen=true, pairs=true,     ipairs=true,
      collectgarbage=true, xpcall=true, rawget=true,
      pcall=true,        type=true,      print=true,
      rawequal=true,  setmetatable=true, require=true, load=true,
      rawset=true,       next=true, getmetatable=true,
      select=true,   error=true,     dofile=true, loadfile=true,
      jit=true,          utf8=true,      math=true, package=true,
      table=true,        coroutine=true, bit=true, os=true,
      io=true,        bit32=true,        string=true,
      arg=true, debug=true, _VERSION=true, _G=true,
      adds=true,
      any=true,
      anys=true,
      binChop=true,
      bootstrap=true,
      cliffsDelta=true,
      col=true,
      color=true,
      copy=true,
      csv=true,
      divs=true,
      eg=true,
      first=true,
      from=true,
      fun=true,
      id=true,
      keys=true,
      last=true,
      lt=true,
      madds=true,
      map=true,
      o=true,
      oo=true,
      ooo=true,
      pastes=true,
      push=true,
      rogues=true,
      round=true,
      same=true,
      trim=true,
      within=true,
      words=true
      }
   for k,v in pairs( _G ) do
      if not no[k] then
         if k:match("^[^A-Z]") then
   print("-- ROGUE ["..k.."]") 
end end end end

function Eg.all()   
  print("") 
  for k,_ in keys(Eg) do
    if k~="all" and k~="fun" then eg(k) end 
  end 
  print(color("green",
          os.date("%X : ").."pass = "..the.test.yes),
        color("red",
          "\n"..os.date("%X : ").."fail = "..the.test.no))
end

function Eg.fun()   return true end
function Eg.test()  assert(1==2) end
function Eg.rnd()   assert(3.2==round(3.2222,1)) end
function Eg.o()     assert("{1, aa, 3}" == o({1,"aa",3})) end
function Eg.id()    local a={}; id(a); id(a); assert(1==a._id) end
function Eg.push(t) 
   t={}; push(10,t); push(20,t); assert(t[1]==10 and t[2]==20) end

function Eg.map( t) 
  assert(30 == map({1,2,3}, function (z) return z*10 end)[3]) end

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
  for row in csv("data/weather.csv") do n=n+1 end
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
  s=adds({"a","a","a","a","b","b","c"},Sym.new())
  assert(1.378 <= s:ent() and s:ent() <= 1.379)
  s=adds({"a","a","a","a","a","a","a"},Sym.new())
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

function Eg.cols(    t)
  t = Cols.new {"!name","?skip",":age"}
  assert(2==#t.xy.all)
  assert(1==#t.x.nums)
  assert(2==t.x.nums[1].pos)
end

function Eg.rowsWeather(      t)
  t=  isa(Rows):read("data/weather.csv")
  assert(type(t.rows[14].cells[2]) == "number")
  assert(5 == t.cols.xy.all[1].seen.rainy)
end

function Eg.rowsAuto(      t)
  t=  isa(Rows):read("data/auto93.csv")
  assert(398 == #t.rows)
end

function Eg.rowsDiabetes(      t)
  t=  isa(Rows):read("data/diabetes.csv")
  assert(t.cols.x.nums[1].n==768)
end

function Eg.rowsAuto10000(      t)
  t=  isa(Rows):read("data/auto93000.csv")
  assert(t.cols.xy.all[1].seen[4]==5100)
end

function Eg.cuts1(      t,t2,kl)
  t=  isa(Rows):read("data/diabetes.csv")
  kl = t.cols.klass
end

local function CutDemo(f, t,t2,kl,cuts) 
  t=  isa(Rows):read(f)
  kl = t.cols.klass
  for i,col in pairs(t.cols.x.nums) do 
     t2={}
     for _,r in pairs(t.rows) do
        t2[#t2+1] = {r.cells[col.pos], 
                     r.cells[kl.pos]} end 
     table.sort(t2, function (x,y) return 
                       first(x)<first(y) end)
     cuts = divs(t2)
     cuts = pastes(t2, cuts,col,kl,"tested_positive")
     print("")
     for j,cut in pairs(cuts) do
       print(i, j, cut.x.n)
     end
  end
end

function Eg.cuts1() CutDemo("data/diabetes1000.csv") end
function Eg.cuts2() CutDemo("data/xxx.csv") end
function Eg.cuts3() CutDemo("data/yyy.csv") end

function Eg.cliffs(     r,n,t,u,v,x)
   n=1000
   t={}
   for i =1,n do t[i] = math.random() end
   for r = 1,1.5,.05 do 
     u,v = Some.new(), Some.new()
     for i =1,n do u:add(t[i]); v:add(t[i]*r) end
     x = u:same(v)
     if r<1.25 then assert(x) else assert(not x) end
end  end

function Eg.boot(     r,n,t,u,x)
   n=100
   t={}
   for i =1,n do t[i] = math.random()^2 end
   for r = 1,1.5,.05 do 
     u={}
     for i =1,n do u[i] = t[i]*r end
     x = bootstrap(t,u)
     if r<1.25 then assert(x) else assert(not x) end
end  end


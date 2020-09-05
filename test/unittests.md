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
  for _ = 1,10^4 do for k,v in keys(c or Coc.project()) do if type(v) ~= "function" then v:again() end end end
end

function Eg.Coc1(  c) Eg.Coc( Coc.project()) end

```



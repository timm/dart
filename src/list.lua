-- vim : ft=lua ts=2 sw=2 et:
function first(t) return t[1] end
function last(t) return t[#t] end
function push(x,a) a[#a+1] = x; return x end
function any(a) return a[1 + math.floor(#a*math.random())] end

function anys(a,n,   t) 
  t={}
  for i=1,n do t[#t+1] = any(a) end
  return t
end

function keys(t,        i,u)
  i,u = 0,{}
  for k,_ in pairs(t) do u[#u+1] = k end
  table.sort(u)
  return function () 
    if i < #u then 
      i = i+1
      return u[i], t[u[i]] 
end end end 

function binChop (t,x,    lo,hi,mid)
  lo,hi = 1,#t
  while lo <= hi do
    mid = math.floor((lo+hi)/2)
    if     t[mid] > x then hi = mid - 1
    elseif t[mid] < x then lo = mid + 1
    else   break 
  end end
  return mid
end



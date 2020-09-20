-- vim : ft=lua ts=2 sw=2 et:

Num=nil
Sym=nil
Some=nil

function col(c, txt,pos)
  c.n   = 0
  c.txt = txt or ""
  c.pos = pos or 0
  c.w   = c.txt:find(the.type.less) and -1 or 1
  return c
end

function adds(t, it)
  it = it or (type(t[1]) == "number" and Num or Sym).new()
  for _,x in pairs(t) do it:add(x) end
  return it
end

function madds(ts, it)
  for _,t in pairs(ts) do 
     it = it or (type(t[1]) == "number" and Num or Sym).new()
     for _,x in pairs(t) do it:add(x) 
  end end
  return it
end

local function somed(c) c.some=Some(); return c end



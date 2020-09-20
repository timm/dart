-- vim : ft=lua ts=2 sw=2 et:

require "the"
require "num"
require "sym"
require "row"

local Cols = {use  = {},
              hdr  = {},
              ready= true,
              x    = {nums={}, syms={}, all={}},
              y    = {nums={}, syms={}, all={}},
              xy   = {nums={}, syms={}, all={}}}

function Cols.new(t)         
   local put, new = 0, isa(Cols)
   local function push2(x,a)
     push(x, a.all)
     push(x, a[new:nump(x.txt) and "nums" or "syms"])  
   end
   for get,txt in pairs(t) do
     if not new:skip(txt) then
       put          = put + 1
       new.use[put] = get
       new.hdr[put] = txt
       local what   = (new:nump(txt) and Num or Sym).new(txt,put)
       if new:klassp(txt) then new.klass= what end
       push2(what, new.xy)
       push2(what, new:goalp(txt) and new.y or new.x) 
  end end
  return new
end

function Cols:has(s,x)  return s:find(the.type[x]) end 
function Cols:klassp(s) return self:has(s,"klass") end
function Cols:skip(s)   return self:has(s,"skip") end
function Cols:obj(s)    return self:has(s,"less") or self:has(s,"more") end
function Cols:nump(s)   return self:obj(s) or self:has(s,"num") end
function Cols:goalp(s)  return self:obj(s) or self:klassp(s) end

function Cols:row(cells,rows,     using,col,val)
  using = {}
  for put,get in pairs(self.use) do 
    col, val   = self.xy.all[put], cells[get]
    using[put] = col:add(val) 
  end
  return Row.new(using,rows)
end



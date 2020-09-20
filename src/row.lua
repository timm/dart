-- vim : ft=lua ts=2 sw=2 et:

require "lib"

local Row = {cells={},cooked={}}

function Row.new(t,rows) 
  return isa(Row,{cells=t,_rows=rows}) end



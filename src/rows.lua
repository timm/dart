-- vim : ft=lua ts=2 sw=2 et:

Rows = {cols={}, rows={}}

function Rows:clone() 
  return isa(Rows,{cols=cols(self.cols.hdr)})   
end

function Rows:read(file) 
  for t in csv(file) do self:add(t) end
  return self 
end

function Rows:add(t)
  t = t.cells and t.cells or t
  if   self.cols.ready
  then self.rows[#self.rows+1] = self.cols:row(t,self) 
  else self.cols = Cols.new(t) 
  end
end



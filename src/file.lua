-- vim : ft=lua ts=2 sw=2 et:
function csv(file,     ch,fun,   pat,stream,tmp,row)
  stream = file and io.input(file) or io.input()
  tmp    = io.read()
  pat    = "([^".. (ch or ",") .."]+)"
  fun    = tonumber
  return function()
    if tmp then
      row = words(tmp:gsub("[\t\r ]*",""),pat,fun)-- no spaces
      tmp = io.read()
      if #row > 0 then return row end
    else
      io.close(stream) 
end end end  

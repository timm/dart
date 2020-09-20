-- vim : ft=lua ts=2 sw=2 et:

require "the"
require "lib"
require "coc"
require "data"
require "div"
require "eg"

--eg(Eg.all)
if not pcall(debug.getlocal,4,1) then 
  print(10)
end

rogues()

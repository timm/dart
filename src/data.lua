-- vim : ft=lua ts=2 sw=2 et:

require "col"
require "some"
require "num"
require "sym"
require "row"
require "cols"
require "rows"

if not pcall(debug.getlocal,4,1) then 
  print(1)
end

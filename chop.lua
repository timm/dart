local function loads(files,       lines,f,code,fs)
  lines = {}
  for _,f in pairs(files) do
    code, fs = false, io.input(f)
    for line in fs:lines() do
      if line:sub(1,3) == "```" then 
        code = not code 
        lines[#lines+1] = "-- " .. line
      else
        lines[#lines+1] = (code and "" or "-- ")  .. line
      end 
    end 
    fs:close()
  end
  f = assert( load( table.concat( lines, "\n")))
  f = f()
  if f.main then f.main() end
end

loads {"src/the.md", "src/lib.md", "src/cocomo.md",
       "test/testcontrol.md", "test/unittests.md", "src/main.md"}

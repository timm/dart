## Main 

```lua
function main()
  if arg[1] == "-U" then 
    local status = eg(arg[2])
    rogues() 
    os.exit((the.test.yes - the.test.no == 1) and 0 or 1)
  end
end

return {the=the,main=main}
```

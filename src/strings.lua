-- vim : ft=lua ts=2 sw=2 et:

function color(col,str)
  local colors={red=31, green=32,  plain=0}
  return '\27[1m\27['..colors[col]..'m'..str..'\27[0m' 
end

function trim(str) 
  return (str:gsub("^%s*(.-)%s*$", "%1")) end

function words(str,pat,fun,   t)
  t = {}
  for x in str:gmatch(pat) do t[#t+1] = fun(x) or trim(x) end
  return t
end

function o(z,pre,   s,sep) 
  s, sep = (pre or "")..'{', ""
  for _,v in pairs(z or {}) do s = s..sep..tostring(v); sep=", " end
  return s..'}'
end

function oo(z,pre) print(o(z,pre)) end

function ooo(t,pre,    indent,fmt)
  pre    = pre or ""
  indent = indent or 0
  if indent < 10 then
    for k, v in pairs(t or {}) do
      if not (type(k)=='string' and k:match("^_")) then
        if not (type(v)=='function') then
          fmt = pre..string.rep("|  ",indent)..tostring(k)..": "
          if type(v) == "table" then
            print(fmt)
            ooo(v, pre, indent+1)
          else
            print(fmt .. tostring(v)) end end end end end
end



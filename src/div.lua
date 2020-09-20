-- vim : ft=lua ts=2 sw=2 et:
function divs(t,n,    cut,cuts,lo,hi)
  n       = n or (#t)^the.stats.enough
  cut     = {start=1,stop=1}
  lo,cuts = 1, {cut}
  while n < 4 and n < #t/2 do n=n*1.2 end  
  for hi,z in pairs(t) do
    if hi - lo >= n then
      if #t - hi >= n then
        if z[1] ~= t[hi-1][1] then
           lo, cut = hi, {start=hi, stop=hi}
           cuts[#cuts+1]=cut end end end  
    cut.stop=hi end
  return cuts
end

function pastes(t,cuts,allx,ally,goal)
  local function summarized(cut,   s,n,j)
    if cut.x == nil then
      cut.x = Num.new()
      cut.y = (type(t[cut.start][2])=="number" and Num or Sym).new()
      j     = math.max(1,#cut//the.some.few)
      for i = cut.start, cut.stop, j do
        cut.x:add(t[i][1])
        cut.y:add(t[i][2]) end
      cut.lo = t[cut.start][1]
      cut.hi = t[cut.stop][2]  end
    return cut
  end
  ---------------------------
  local function dull(a,b,ab,    sabs) 
    if b.x.mu - a.x.mu < allx.sd*the.stats.cohen then return true end
    sabs = ab.y:score(goal,ally)
    return sabs > a.y:score(goal,ally) and sabs > b.y:score(goal,ally)
  end
  ------------
  local function main(cuts,      a,b,ab,j,tmp)
    j,tmp = 1,{}
    while j <= #cuts do
      a = summarized(cuts[j])
      if j<#cuts-1 then
        b  = summarized(cuts[j+1])
        ab = summarized({start=a.start, stop=b.stop})
        if dull(a,b,ab) then
          a= ab
          j=j+1 end end
      tmp[#tmp+1]= a
      j=j+1  
    end
    return #tmp < #cuts and main(tmp) or cuts
  end
  return main(cuts)
end



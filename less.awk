# vim: ft=awl ts=2 sw=2 et :
cat<<EOF | gawk '{ print gensub(
   /\.([^0-9\\*\\$\\+])([a-zA-Z0-9_]*)/, 
  "[\"\\1\\2\"]","g",$0) }' /tmp/$$.awk

BEGIN { SomeMax=256 }

function num(s) { return s ~/[:<>]/ }
function y(s)   { return s ~/[!<>]/ }
function x(s)   { return not y(s) }
function sym(s) { return not num(s) }
function want(nn,out,want1,want2) {
  for(i in nn)
    if (@want1(N[i]) ||  want2 && @want2(N[i])
      out[i] = i
}

function using(u, get,  put,o) {
  for(get=1;get<=NF;get++)
    if($get !~ /\?/) 
      u[get] = ++put
}
function readR
function reads(a,Use,Names,Cols,Rows) { 
  if length(Use)
    readRow(a,C,R,U,N)

function some(a,x)
function readRow(a,cc,rr,uu,nn) {
  for(u in U

}
U,N,C,R
  needs(Use)
  for(i in Use) {
     Names[$use[i]] = $i
     Col
  for(i=1;i<=NF;i++) 
    Names[i] = $i ; next}

EOF

gawk -f /tmp/$$.awk

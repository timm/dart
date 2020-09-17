function color(c,s,  i,a) {
  split(s,a,"[ \t]+")
  for(i in a) 
     Swaps["\\w" a[i] "\\w"] = "<span style='color:"c"'>"a[i]"</span>" 
}
function code(s) { for(i  in Swap) gsub(i,Swaps[i],s);return s }
function text(s) { 
  gsub(/[ \t\r\n]*$/,"",s) 
  s=gensub(/_([^-]+)_/,   "<em>\\1</em>","g",s)
  s=gensub(/`([^`]+)s`_/,   "<code>\\1</code>","g",s)
  #s=gensub(/[^\\]\*([^\*]+)\*/,"<bf>\\1</bf>","g",s)
  if (sub(/^# /,"",s)) s= "<h1>"s"</h1>"
  if (sub(/^## /,"",s)) s= "<h2>"s"</h2>"
  if (sub(/^### /,"",s)) s= "<h3>"s"</h3>"
  if (sub(/^#### /,"",s)) s= "<h4>"s"</h4>"
  if (sub(/^##### /,"",s)) s= "<h5>"s"</h5>"
  if (sub(/^###### /,"",s)) s= "<h6>"s"</h6>"
  if (sub(/^####### /,"",s)) s= "<h7>"s"</h7>"
  return s
}
BEGIN { Code=1; Text=2; What=Text }
BEGIN { 
  color("cyan",  "and not or in")
  color("green",  "end function return ") 
  color("purple", "else elseif then  if ") 
  color("red",     "do for repeat until while") 
  color("blue",   "nil true false") 
  color("orange", "local")
}
        { gsub(/[ \t\r\n]*$/,"",$0) }
#/^local[\t ]+Help=/ {next}
#/^\]\]/             {next}

 /^    / { if(What != Code) { print "<pre>"; What=Code }
           while (sub(/^    /,"")) { print  code($0); getline}
           print "</pre>" ; What = Text
         }
 
/^-- /  { #if(What != Text) { print "</pre>"; What=Text }
          while (sub(/^-- /,"")) { print text($0) ; getline}
          #print "<pre>" ; What=Code
        }

function more() {
  getline
  gsub(/[ \t\r\n]*$/,"",$0) 
  return $0
}

/^---/ { while (sub(/^--[-]? /,"")) { print $0; more() } } 

BEGIN { codep=unordp=ordp=parap=0 }

{ gsub(/</,"\<",$0);
  gsub(/>/,"\>",$0);

  if(! match($0,/^    /)) { # close code blocks
      if(codep) { codep=0; printf "</code></pre>\n" } }

  if(! match($0,/^- /)) { # close unordered list
      if(unordp) { unordp=0; printf "</ul>\n" } }

  if(! match($0,/^[0-9]+\. /)) { # close ordered list
      if(ordp) { ordp=0; printf "</ol>\n" } }

  if(match($0,/^#/)) { # display titles
      if(match($0,/^(#+)/)) {
          printf "<h%i>%s</h%i>\n", RLENGTH, substr($0,index($0,$2)), RLENGTH }

  } else if(match($0,/^    /)) { # display code blocks
      if(codep==0) {
          codep=1
          printf "<pre><code>"
          print substr($0,5)
      } else {
          print substr($0,5)
      }

  } else if(match($0,/^- /)) { # display unordered lists
      if(unordp==0) {
          unordp=1
          printf "<ul>\n"
          printf "<li>%s</li>\n", substr($0,3)
      } else {
          printf "<li>%s</li>\n", substr($0,3)
      }

  } else if(match($0,/^[0-9]+\. /)) { # display ordered lists
      n=index($0," ")+1
      if(ordp==0) {
          ordp=1
          printf "<ol>\n"
          printf "<li>%s</li>\n", substr($0,n)
      } else {
          printf "<li>%s</li>\n", substr($0,n)
      }

  } else { # close p if current line is empty
      if(length($0) == 0 && parap == 1 && codep == 0) {
          parap=0
          printf "</p>"
      } # we are still in a paragraph
      if(length($0) != 0 && parap == 1) {
          print
      } # open a p tag if previous line is empty
      if(length(b4)==0 && parap==0) {
          parap=1
          printf "<p>%s\n", $0
      }
  }
  b4 = $0
}

END { if(codep==1)  { printf "</code></pre>\n" }
      if(unordp==1) { printf "</ul>\n" }
      if(ordp==1)   { printf "</ol>\n" }
      if(parap==1)  { printf "</p>\n" }
}

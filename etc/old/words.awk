function more() {
  getline
  gsub(/[ \t\r\n]*$/,"",$0) 
  return $0
}

/^----/ { $1=""; Section    = $0; next}
/^---/  { $1=""; SubSection = $0; next}
/^--/   { while (sub(/^--[ $]/,"")) { print $0; getline } } 

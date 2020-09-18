
su/--\[\[/ {while (!BEGIN {while(!sub(/^\]\].*/,"")) {  getline }; 
       print "\n\n"
       print"```lua"} 
sub(/^-- /,"")    {print"```" 
                   do {print; getline} while (sub(/^-- /,"")) 
                   print "```lua"}
sub(/^--\[\[[ \t]*/,"")  { print"```"
                     while (! sub(/^--\]\][ \t]*/,"") ) {
                        print
                       getline} 
                      
                     print "```lua"
                    }
                  
                   {print}
                   
END {print "```\n"}
'  

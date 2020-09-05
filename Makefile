Files=src/cocomo.lua src/lib.lua src/main.lua src/the.lua  \
      test/testcontrol.lua test/unittests.lua

A='sub(/```.+$$/,"") { In = 1 }  \
     sub(/```/,   "") { In = 0 }   \
                      { print (In?"":com) $$0 }'

all: $(Files)

src/%.lua  : src/%.md; echo awk --source $A 
test/%.lua : src/%.md; echo awk --source $A 

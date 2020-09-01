# Chop

Optimization for discrete and continuous systems = DE + B + BPO + repeat

- [About](#about) 
    - [Install](#install) 
    - [Requirements](#requirements) 
    - [License](#license) 
    - [Citation](#citation) 
    - [Contact](#contact) 

## About

Here, the source code stored in code blocks of a Markdown file.
- The command `sh chop -C` extracts that code to stdout. 
- The command `sh chop -X` extracts, then runs, that code.
- Once extracted, the resulting code code be included elsewhere:

```lua
-- returns a table of services you can use
chop=require("chop")
```

### Install

- Pre-install the  requirements (see below). 
- Download [the zip](https://github.com/timm/chop/archive/master.zip).
- Unzip into a fresh directory. Change into that directory.
- Run `sh chop -I`
- Then test it all worked worked with `sh chop -U` (to run the unit tests).

If that all works you should see one failed test (which tests that the test engine works) and everything else passing.

### Requirements

- Lua >= 5.3
- Gawk >= 5.0
- Bash

### Contribute

My conventions:

- All code in Markdown Lua blocks with a one line comment before it (as a level4 heading)

        #### inc(a) : returns one more than a
        ```lua
        function x(a) return a+1 end
        ```

- All source code in one file.
  - Application specific code at top, general utilities at bottom,
- Using classes to divide the code. 
   - Update the non-class library code rarely (since that is functions global to the module).
   = Update the class code a lot.
- Use classes for polymorphism. Don't use inheritance (adds to debugging effort).
- Instances are created with a lower case function.
- Classes are
- Indent code with 2 characters for tabs.



### License

Copyright 2020, Tim Menzies

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

### Citation

Tim Menzies,  
CHOP: data mining + optimization  
2020  
http://github.com/timm/chop

### Contact

Tim Menzies   
timm@ieee.org  
http://menzies.us



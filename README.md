# Name 
  dart

## Description
  Optimize = cluster plus sample plus contrast;
  i.e. Divide problem space into chunks;
  dart, a little, around the chunks;
  report back anything that jumps you between chunks.

## Usage
  lua dart.lua [Options] [--Group Options]* 

  Options start with "-" and contain 0 or 1 arguments.
  Options belong to different Groups (which start with --).

Options:

    -C           ;; show copyright   
    -h           ;; show help   
    -H           ;; show help (long version) 
    -seed 1      ;; set random number seed   
    -U fun       ;; run unit test 'fun' (and `all` runs everything)
    -id 0        ;; counter for object ids
    --test       ;; system stuff, set up test engine    
       -yes   0  
       -no    0
    --stats
       -cohen       .2
       -cliffsDelta .147
       -bootstrap   256
       -confidence  .95
       -enough      .50
    --some
       -max   256
       -few    64
    --type       ;; when reading csv files, names in row1 have
                 ;; magic symbols telling us their type.
       -klass !  ;; symbolic class
       -less  <  ;; numeric goal to be minimized
       -more  >  ;; numeric goal to be maximized
       -num   :  ;; numeric
       -skip  ?  ;; to be ignored
  

# Details

## Requirements

- Lua >= 5.3

## Install

- Install Lua 5.3
- Download [dart.lua](dart.lua)
- Run and execute the unit tests 

     lua dart.lua -U

If that all works then you see one failing test
(when we test the test engine) and everything else passing.

## Contribute

Please follow these 
_Lua-isa-simple-language-so-lets-keep-it-simple_ c
onventions:

- Source code
  - All source code in one file.
    - All locals listed at top;
    - Application specific code at top;
    - General utilities at bottom,
    - Unit tests under nearly everything  else,  inside the `Eg` variable.
    - Second last is the main function to be called if this code is _not_ included into
      another library:
      - And I test for that using `not pcall(debug.getlocal, 4, 1)`.
    - Finally, there  is a return statement that exports the more useful parts of the code.
  - No globasl (so keep the list of `local`s at top of file up to date).
  - The `the` local handles information and defaults shared across all functions and classes.
    - And this variable is initialized by parsing the [Usage](#usage) section of this help
      text/
  - Minimize use of the `local` keyword (so ugly)
    - Use it once at top of file.
    - Then (usually) define function locals as extra input arguments.
  - Indent code with 2 characters for tabs.
  - Using classes to divide the code. 
    - Update the non-class library code rarely (since that is functions global to the module).
    - Update the class code a lot.
  - Classes:
    - Use classes for polymorphism. 
    - Don't use inheritance (adds to debugging effort).
    - Classes are created by assigning some defaults to a global value;    
      e.g. `Emp={lname="", fname="", add=address() }`
    - Class constructors are lower case functions that call `isa(X)` 
      (where `X` is some class).
      - Typically for some `Klass`, the constrictor is the same name, starting with lower case (e.g. `klass`).
      - Constructors often use the idiom `new.x = y or the.zzz.y` where `y` is a parameter- S
    

## License

Copyright 2020,  
Tim Menzies,   
timm@ieee.org

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject
to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 

- [Miscellaneous Functions](dart.lua#L10) 
    - [Maths](dart.lua#L11) 
        - [from(lo,hi)](dart.lua#L12) : return a number from `lo` to `hi`
        - [round(n,places)](dart.lua#L17) : round `n` to some decimal `places`.
    - [Strings](dart.lua#L25) 
        - [o(t,pre)](dart.lua#L26) : return `t` as a string, with `pre`fix
        - [oo(t,pre)](dart.lua#L35) : print `t` as a string, with `pre`fix
        - [ooo(t,pre)](dart.lua#L40) : return a string representing `t`'s recursive contents.
    - [Meta](dart.lua#L58) 
        - [id(x)](dart.lua#L59) : ensure `x` has a unique if
        - [same(z)](dart.lua#L67) : return z
        - [lt(x,y)](dart.lua#L72) : return `x<y`
        - [fun(x)](dart.lua#L77) : returns true if `x` is a function
        - [map(t,f)](dart.lua#L83) : apply `f` to everything in `t` and return the result
        - [select(t,f)](dart.lua#L101) : return a table of items in `t` that satisfy function `f`
        - [isa(class,has)](dart.lua#L110) : create a new instance of `class`, add the `has` slots 
    - [Lists](dart.lua#L121) 
        - [push(x,a)](dart.lua#L122) : push `x` to end of  `a`. return `x`
        - [any(a)](dart.lua#L127) : sample 1 item from `a`
        - [anys(a,n)](dart.lua#L132) : sample `n` items from `a`
        - [keys(t)](dart.lua#L141) : iterate over key,values (sorted by key)
        - [binChop(t,x)](dart.lua#L154) : return a position very near `x` within `t`
    - [Files](dart.lua#L167) 
        - [trim(str)](dart.lua#L168) : remove leading and trailing blanks
        - [words(s,pat,fun)](dart.lua#L173) : split `str` on `pat` (default=`,`), coerce using `fun` (defaults= `tonumiber`)
        - [csv(file)](dart.lua#L182) : iterate through  non-empty rows, divided on comma, coercing numbers
        - [color(theColor,str)](dart.lua#L199) : print `str` using `theColor`
    - [Stats](dart.lua#L208) 
        - [cuts(t,n)](dart.lua#L246) : chop list of pairs `t` into cuts of size `n`. 
- [`Coc`omo](dart.lua#L303) 
    - [`Coc`.all()](dart.lua#L304) : return a generator of COCOMO projects
    - [`Coc`.all()](dart.lua#L350) : compute effort and risk for one project
    - [`Coc`.Risk](dart.lua#L371) : Cocomo risk model
- [Data](dart.lua#L443) 
    - [Managing single columns of data](dart.lua#L444) 
        - [col(c,txt="",pos=0)](dart.lua#L445) : initialize a column
        - [`Some` Column](dart.lua#L456) : resovoir samplers
            - [`Some`.new(txt,pos)](dart.lua#L461) : make a  new `Some`
            - [`Some`:add(x)](dart.lua#L468) : add `x` to the receiver
            - [`Some`:all()](dart.lua#L483) : return all kept items, sorted
            - [`Some`:few()](dart.lua#L491) : return all kept items, sorted
            - [`Some`:same()](dart.lua#L500) : return all kept items, sorted
        - [`Num`eric Columns](dart.lua#L508) 
            - [`Num`.new(txt,pos)](dart.lua#L514) : make a  new `Num`
            - [`Num`:add(x)](dart.lua#L519) : add `x` to the receiver
            - [`Num`:delta(y) ](dart.lua#L536) 
        - [`Sym`bolic Columns](dart.lua#L544) 
            - [`Sym`.new(txt,pos)](dart.lua#L549) : make a  new `Sym`
            - [`Sym`:add(x)](dart.lua#L554) : add `x` to the receiver
            - [`Sym`:ent()](dart.lua#L567) : return the entropy of the symbols seen in this column
        - [`Sym`:v(goal,all)](dart.lua#L579) 
    - [`Row`](dart.lua#L595) : a place to hold one example
        - [`Row`.new(t)](dart.lua#L600) : initialize a new row
    - [Gernics for all columns](dart.lua#L606) 
        - [adds(t, it)](dart.lua#L610) : all everything in `t` into a column of type `it`
        - [madds(ts, its)](dart.lua#L619) : multiple adds
        - [somed(col)](dart.lua#L630) : include a `Some` into `col`
    - [`Cols`](dart.lua#L635) : place to store lots of columns
        - [`Cols`.new(t)](dart.lua#L645) : return a news `cols` with all the `nums` and `syms` filled in
        - [`Col`umn types (string types)](dart.lua#L666) 
        - [`Cols`:push2(x)](dart.lua#L676) : add a column, to `all`, `nums` and `syms`
        - [`Cols`:row(t)](dart.lua#L677) : return a row containing `cells`, updating the summaries.
    - [`Rows`](dart.lua#L689) : class; a place to store `cols` and `rows`.
        - [`Rows`:clone()](dart.lua#L694) : return a new `Rows` with the same structure as the receiver
        - [`Rows`:read(file)](dart.lua#L701) : read in data from a csv `file`
        - [`Rows`:add(t)](dart.lua#L709) : turn the first row into a columns header, the rest into data rows
- [Unit Tests](dart.lua#L721) 
        - [eg(x)](dart.lua#L726) : run the test function `eg_x` or, if `x` is nil, run all.
        - [within(x,y,z)](dart.lua#L750) 
        - [rogues()](dart.lua#L757) : report escaped local variables
- [Unit Tests](dart.lua#L781) 
- [Command Line](dart.lua#L884) 
    - [options(now,b4)](dart.lua#L885) : return a tree with options from `b4` updated with `now`
    - [cli()](dart.lua#L921) : initialize `the` and run command-line options.
- [start-up](dart.lua#L936) 


<a name=top></a>
<p align=center>
<a href="https://github.com/timm/dart/blob/master/README.md#top">home</a> ::
<a href="https://github.com/timm/dart/blob/master/README.md#contribute">contribute</a> ::
<a href="https://github.com/timm/dart/issues">issues</a> ::
<a href="https://github.com/timm/dart/blob/master/README.md#license">&copy;2020<a> by <a href="http://menzies.us">Tim Menzies</a>
</p>
<h1 align=center> Dart  v0.1<br>cluster and sample and contrast</h1>
<p align=center>
<img width=400 src="https://i0.wp.com/studentwork.prattsi.org/infovis/wp-content/uploads/sites/3/2019/04/image-44.png?w=758&ssl=1"><br>
<img src="https://img.shields.io/badge/purpose-ai%20,%20se-blueviolet"> <a 
href="https://github.com/timm/lump/blob/master/LICENSE.md"> <img  
   alt="License" src="https://img.shields.io/badge/license-mit-red"></a> <a 
  href="https://zenodo.org/badge/latestdoi/289524083"> <img 
  src="https://zenodo.org/badge/289524083.svg" alt="DOI"></a> <img 
alt="Platform" src="https://img.shields.io/badge/platform-osx%20,%20linux-lightgrey"> <img 
alt="lisp" src="https://img.shields.io/badge/language-lua,bash-blue"> <a 
 href="https://travis-ci.org/github/timm/lump"><img alt="tests" 
   src="https://travis-ci.org/timm/lump.svg?branch=master"></a>
</p> 






# About
## Name 
  dart

# Description
 Optimize = cluster plus sample plus contrast;
 i.e. Divide problem space into chunks;
 dart, a little, around the chunks;
 report back anything that jumps you between chunks.

## Usage

      lua dart.lua [Options] [--Group Options]* 

 Options start with "-" and contain 0 or 1 arguments.
 Options belong to different Groups (which start with --).

## Options

    -C           ;; show copyright   
    -h           ;; show help   
    -H           ;; show help (long version) 
    -seed 1      ;; set random number seed   
    -U fun       ;; run unit test 'fun' (and `all` runs everything)
    -R fun       ;; run test function
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

## Requirements
- Lua >= 5.3

## Install

- Install Lua 5.3
- Download [dart.lua](dart.lua)
- Run and execute the unit tests 

     lua dart.lua -U

If that all works then you see one failing test
(when we test the test engine) and everything else passing.

## How to Contribute

Please follow these 
_Lua-isa-simple-language-so-lets-keep-it-simple_ conventions:

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


## Contact

Copyright 2020,  
Tim Menzies,   
timm@ieee.org

## Copyright

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
### Some(i:list0, max:pos) :nil 

Constructor for `Some` objects that keep a random sample of atoms.
- `i.n` is now many things were set to this `Some`
- `i.all` is all the fhings kept (may be less that `i.n`
- `i.max` is the maximum number of things kept (and if we keep more
  than that, then order things (selected at random) will be removed.
- `i.ok` is false when `i.all` has been updated, but not resorted yet.

<u><em>Returns</em></u> fred
#### ok(i:Some) :nil  

Ensure contents are sorted
#### var(i,  lo,hi) 



<a name=top></a>
<p align=center>
<a href="https://github.com/timm/chop/blob/master/README.md#top">home</a> ::
<a href="https://github.com/timm/chop/blob/master/README.md#contribute">contribute</a> ::
<a href="https://github.com/timm/chop/issues">issues</a> ::
<a href="https://github.com/timm/chop/blob/master/README.md#license">&copy;2020<a> by <a href="http://menzies.us">Tim Menzies</a>
</p>
<h1 align=center> CHOP  v0.1<br>cluster and contrast</h1>
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


Optimization for discrete and continuous systems = DE + B + BPO + repeat

Note that the [chop](chop) script is the manager for the source code found in [chop.md](chop.md).
Here, the source code stored in code blocks of a Markdown file.
- The command `sh chop -C` extracts that code to stdout. 
- The command `sh chop -X` extracts, then runs, that code.
- Once extracted, the resulting code code be included elsewhere:

```lua
-- returns a table of services you can use
chop=require("chop")
```

- [Install](#install) 
- [Requirements](#requirements) 
- [Contribute](#contribute) 
- [Citation](#citation) 
- [Contact](#contact) 
- [License](#license) 

---

## Install

- Pre-install the  requirements (see below). 
- Download [the zip](https://github.com/timm/chop/archive/master.zip).
- Unzip into a fresh directory. Change into that directory.
- Run `sh chop -I`
- Then test it all worked worked with `sh chop -U` (to run the unit tests).

If that all works you should see one failed test (which tests that the test engine works) and everything else passing.

## Requirements

- Lua >= 5.3
- Gawk >= 5.0
- Bash

## Contribute

Please follow my _Lua-isa-simple-language-so-lets-keep-it-simple_ conventions:

- All code in Markdown Lua blocks with a one line comment before it (as a level4 heading)

        #### inc(a) : returns one more than a
        ```lua
        function x(a) return a+1 end
        ```
- Support code
  - All support code in its own file that knows to create the followng files (if they do not exist already):
    - `./.travis.yml`
    - `./.gitignore`
    - `$HOME/.tmux.conf`
    - `$HOME/.vimrc`
    - `$HOME/.vim/bundle`
    - `$HOME/.config/htop/htoprc`
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
  - No globals (so keep the list of `local`s at top of file up to date).
  - The `the` local handles information and defaults shared across all functions and classes.
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
    


## Citation

Tim Menzies,  
CHOP: data mining + optimization  
2020  
http://github.com/timm/chop

## Contact

Tim Menzies   
timm@ieee.org  
http://menzies.us

## License

Copyright 2020, Tim Menzies

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



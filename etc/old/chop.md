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

- [Config](#config) 
    - [the](#the--global-with-all-settings) : global with all settings
- [Modelling](#modelling) 
    - [MX](#mx) 
        - [mx(inits)](#mxinits--create-a-new-mx) : create a new `MX`.
        - [MX:_call()](#mxcall---calculate-a-new-value) : calculate a new value.
        - [MX:again()](#mxagain--forget-old-values-compute-a-new-one) : forget old values, compute a new one.
        - [MX:squeeze(lo,hi)](#mxsqueezelohi--restrict-to-lohi-if-hi-missing-set-hi-to-lo) : restrict to `lo,hi` (if `hi` missing, set `hi` to `lo`).
- [Cocomo](#cocomo) 
    - [Coc.project()](#cocproject--return-a-random-project) : return a random project
    - [Coc.Risk](#cocrisk) 
- [Data](#data) 
    - [Columns](#columns) 
        - [Define column types](#define-column-types) 
- [Lib](#lib) 
    - [Maths](#maths) 
        - [from(lo,hi)](#fromlohi--return-a-number-from-lo-to-hi) : return a number from `lo` to `hi`
        - [round(n,places)](#roundnplaces--round-n-to-some-decimal-places) : round `n` to some decimal `places`.
    - [Strings](#strings) 
        - [o(t,pre)](#otpre--return-t-as-a-string-with-prefix) : return `t` as a string, with `pre`fix
        - [oo(t,pre)](#ootpre--print-t-as-a-string-with-prefix) : print `t` as a string, with `pre`fix
        - [ooo(t,pre)](#oootpre--return-a-string-representing-ts-recursive-contents) : return a string representing `t`'s recursive contents.
    - [Meta](#meta) 
        - [id(x)](#idx--ensure-x-has-a-unique-if) : ensure `x` has a unique if
        - [same(z)](#samez--return-z) : return z
        - [map(t,f)](#maptf--apply-f-to-everything-in-t-and-return-the-result) : apply `f` to everything in `t` and return the result
        - [copy(t)](#copyt--return-a-deep-copy-of-t) : return a deep copy of `t`
        - [select(t,f)](#selecttf--return-a-table-of-items-in-t-that-satisfy-function-f) : return a table of items in `t` that satisfy function `f`
        - [ako(class,has)](#akoclasshas--create-a-new-instance-of-class-add-the-has-slides) : create a new instance of `class`, add the `has` slides
    - [Lists](#lists) 
        - [any(a)](#anya--sample-1-item-from-a) : sample 1 item from `a`
        - [anys(a,n)](#anysan--sample-n-items-from-a) : sample `n` items from `a`
        - [keys(t)](#keyst-iterate-over-keyvalues-sorted-by-key) : iterate over key,values (sorted by key)
    - [Files](#files) 
        - [csv(file)](#csvfile--iterate-through--non-empty-rows-divided-on-comma-coercing-numbers) : iterate through  non-empty rows, divided on comma, coercing numbers
- [Testing](#testing) 
    - [Support code](#support-code) 
        - [within(x,y,z)](#withinxyz-y-is-between-x-and-z) : `y` is between `x` and `z`.
        - [rogues()](#rogues-report-escaped-local-variables) : report escaped local variables
        - [eg(x)](#egx-run-the-test-function-egx-or-if-x-is-nil-run-all) : run the test function `eg_x` or, if `x` is nil, run all.
    - [Unit tests](#unit-tests) 
- [Main](#main) 

This is a _one file_ system where all the code
is in a markdown file and extraced using

    sh ell --code

## Config
### the : global with all settings


```lua
local the,c,klass,less,goal,num          = nil,nil,nil,nil,nil
local y,x,sym,xsym,xnum,cols             = nil,nil,nil,nil,nil,nil
local round,o,oo,ooo,id,same             = nil,nil,nil,nil,nil,nil 
local map, copy,select,any,anys,keys,csv = nil,nil,nil,nil,nil,nil
local within,rogues,eg,eg1,Eg,main       = nil,nil,nil,nil,nil,nil
local from,ako,var                       = nil,nil,nil
local Mx,mx,Coc                            = nil,nil

the = {aka={},
      id=0,
      seed=1,
      test= {yes=0,no=0}
}
```


" Vim syntax file
" Language:	Regent; based on regent.vim (2013 Jul 20), bundled with vim 7.3.
" Maintainer:	Wonchan Lee <wonchan 'at' cs stanford edu>
" First Author:	Carlos Augusto Teixeira Mendes <cmendes 'at' inf puc-rio br>
" Last Change:	2017 Feb 10

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

" syncing method
syn sync minlines=100

" Comments
syn keyword regentTodo            contained TODO FIXME XXX
syn match   regentComment         "--.*$" contains=regentTodo,@Spell
" Comments in Lua 5.1: --[[ ... ]], [=[ ... ]=], [===[ ... ]===], etc.
syn region regentComment        matchgroup=regentComment start="--\[\z(=*\)\[" end="\]\z1\]" contains=regentTodo,@Spell

" First line may start with #!
syn match regentComment "\%^#!.*"

" catch errors caused by wrong parenthesis and wrong curly brackets or
" keywords placed outside their respective blocks

syn region regentParen transparent start='(' end=')' contains=TOP,regentParenError
syn match  regentParenError ")"
syn match  regentError "}"
syn match  regentError "\<\%(end\|else\|elseif\|then\|until\|in\)\>"

" Function declaration
syn region regentFunctionBlock transparent matchgroup=regentFunction start="\<function\>" end="\<end\>" contains=TOP
syn region regentterraFunctionBlock transparent matchgroup=regentterraFunction start="\<terra\>" end="\<end\>" contains=TOP

" Task declaration
syn region regentTaskBlock transparent matchgroup=regentTask start="\<task\>" end="\<end\>" contains=TOP

syn region regentPrivilegeBlock transparent matchgroup=regentTask start="\<where\>" end="\<do\>" contains=TOP skipwhite skipempty

syn keyword regentFunc reads
syn keyword regentFunc writes
syn keyword regentFunc reduces
syn keyword regentFunc exclusive
syn keyword regentFunc atomic
syn keyword regentFunc simultaneous
syn keyword regentFunc relaxed
syn keyword regentFunc arrives
syn keyword regentFunc awaits
syn keyword regentFunc no_access_flag

" quote
syn region regentterraQuoteBlock transparent matchgroup=regentterraQuote start="\<quote\>" end="\<end\>" contains=TOP

" regent quote
syn region regentRQuoteBlock transparent matchgroup=regentRQuote start="\<rquote\>" end="\<end\>" contains=TOP

syn region regentRExprBlock transparent matchgroup=regentRExpr start="\<rexpr\>" end="\<end\>" contains=TOP

" else
syn keyword regentCondElse matchgroup=regentCond contained containedin=regentCondEnd else

" then ... end
syn region regentCondEnd contained transparent matchgroup=regentCond start="\<then\>" end="\<end\>" contains=TOP

" elseif ... then
syn region regentCondElseif contained containedin=regentCondEnd transparent matchgroup=regentCond start="\<elseif\>" end="\<then\>" contains=TOP

" if ... then
syn region regentCondStart transparent matchgroup=regentCond start="\<if\>" end="\<then\>"me=e-4 contains=TOP nextgroup=regentCondEnd skipwhite skipempty

" do ... end
syn region regentBlock transparent matchgroup=regentStatement start="\<do\>" end="\<end\>" contains=TOP

" must_epoch ... end
syn region regentMustEpochBlock transparent matchgroup=regentStatement start="\<must_epoch\>" end="\<end\>" contains=TOP

" __parallelize_with ... end
syn region regentHintBlock transparent matchgroup=regentStatement start="\<__parallelize_with\>" end="\<do\>"me=e-2 contains=TOP nextgroup=regentBlock skipwhite skipempty

" repeat ... until
syn region regentRepeatBlock transparent matchgroup=regentRepeat start="\<repeat\>" end="\<until\>" contains=TOP

" while ... do
syn region regentWhile transparent matchgroup=regentRepeat start="\<while\>" end="\<do\>"me=e-2 contains=TOP nextgroup=regentBlock skipwhite skipempty

" for ... do and for ... in ... do
syn region regentFor transparent matchgroup=regentRepeat start="\<for\>" end="\<do\>"me=e-2 contains=TOP nextgroup=regentBlock skipwhite skipempty

syn keyword regentFor contained containedin=regentFor in

" other keywords
syn keyword regentStatement return local break
syn keyword regentStatement goto
syn match regentLabel "::\I\i*::"
syn keyword regentOperator and or not
syn keyword regentOperator min max
syn keyword regentConstant nil null
syn keyword regentConstant true false

" (more) regent keywords
syn keyword regentStruct struct union fspace
syn keyword regentVariable var
syn keyword regentType rawstring niltype double float bool int uint int64 uint64 int32 uint32 int16 uint16 int8 uint8 region ispace partition int1d int2d int3d ptr aliased disjoint equal hdf5 phase_barrier wild
syn keyword regentFunc __demand __forbid __parallel __vectorize __cuda __inline __unroll __trace __spmd

" Strings
syn match  regentSpecial contained #\\[\\abfnrtvz'"]\|\\x[[:xdigit:]]\{2}\|\\[[:digit:]]\{,3}#
syn region regentString2 matchgroup=regentString start="\[\z(=*\)\[" end="\]\z1\]" contains=@Spell
syn region regentString  start=+'+ end=+'+ skip=+\\\\\|\\'+ contains=regentSpecial,@Spell
syn region regentString  start=+"+ end=+"+ skip=+\\\\\|\\"+ contains=regentSpecial,@Spell

" integer number
syn match regentNumber "\<\d\+\>"
" floating point number, with dot, optional exponent
syn match regentNumber  "\<\d\+\.\d*\%([eE][-+]\=\d\+\)\=\>"
" floating point number, starting with a dot, optional exponent
syn match regentNumber  "\.\d\+\%([eE][-+]\=\d\+\)\=\>"
" floating point number, without dot, with exponent
syn match regentNumber  "\<\d\+[eE][-+]\=\d\+\>"

" hex numbers
syn match regentNumber "\<0[xX][[:xdigit:].]\+\%([pP][-+]\=\d\+\)\=\>"

" tables
syn region regentTableBlock transparent matchgroup=regentTable start="{" end="}" contains=TOP,regentStatement

syn keyword regentFunc assert collectgarbage dofile error next
syn keyword regentFunc print rawget rawset tonumber tostring type _VERSION

syn keyword regentFunc getmetatable setmetatable
syn keyword regentFunc ipairs pairs
syn keyword regentFunc pcall xpcall
syn keyword regentFunc _G loadfile rawequal require import
syn keyword regentFunc load select
syn keyword regentFunc colors bounds
syn keyword regentFunc __context __delete __fields __physical __raw __runtime
syn keyword regentFunc acquire allocate_scratch_fields advance arrive await attach
syn keyword regentFunc copy cross_product cross_product_array
syn keyword regentFunc detach dynamic_cast dynamic_collective dynamic_collective_get_result
syn keyword regentFunc fill image isnull list_cross_product list_cross_product_complete list_slice_partition
syn keyword regentFunc list_duplicate_partition list_invert list_phase_barriers list_range list_ispace
syn keyword regentFunc new preimage product release static_cast unsafe_cast with_scratch_fields

syn match regentFunc /\<package\.cpath\>/
syn match regentFunc /\<package\.loaded\>/
syn match regentFunc /\<package\.loadlib\>/
syn match regentFunc /\<package\.path\>/
syn keyword regentFunc _ENV rawlen
syn match regentFunc /\<package\.config\>/
syn match regentFunc /\<package\.preload\>/
syn match regentFunc /\<package\.searchers\>/
syn match regentFunc /\<package\.searchpath\>/
syn match regentFunc /\<bit32\.arshift\>/
syn match regentFunc /\<bit32\.band\>/
syn match regentFunc /\<bit32\.bnot\>/
syn match regentFunc /\<bit32\.bor\>/
syn match regentFunc /\<bit32\.btest\>/
syn match regentFunc /\<bit32\.bxor\>/
syn match regentFunc /\<bit32\.extract\>/
syn match regentFunc /\<bit32\.lrotate\>/
syn match regentFunc /\<bit32\.lshift\>/
syn match regentFunc /\<bit32\.replace\>/
syn match regentFunc /\<bit32\.rrotate\>/
syn match regentFunc /\<bit32\.rshift\>/
syn match regentFunc /\<coroutine\.running\>/
syn match regentFunc /\<coroutine\.create\>/
syn match regentFunc /\<coroutine\.resume\>/
syn match regentFunc /\<coroutine\.status\>/
syn match regentFunc /\<coroutine\.wrap\>/
syn match regentFunc /\<coroutine\.yield\>/
syn match regentFunc /\<string\.byte\>/
syn match regentFunc /\<string\.char\>/
syn match regentFunc /\<string\.dump\>/
syn match regentFunc /\<string\.find\>/
syn match regentFunc /\<string\.format\>/
syn match regentFunc /\<string\.gsub\>/
syn match regentFunc /\<string\.len\>/
syn match regentFunc /\<string\.lower\>/
syn match regentFunc /\<string\.rep\>/
syn match regentFunc /\<string\.sub\>/
syn match regentFunc /\<string\.upper\>/
syn match regentFunc /\<string\.gmatch\>/
syn match regentFunc /\<string\.match\>/
syn match regentFunc /\<string\.reverse\>/
syn match regentFunc /\<table\.pack\>/
syn match regentFunc /\<table\.unpack\>/
syn match regentFunc /\<table\.concat\>/
syn match regentFunc /\<table\.sort\>/
syn match regentFunc /\<table\.insert\>/
syn match regentFunc /\<table\.remove\>/
syn match regentFunc /\<math\.abs\>/
syn match regentFunc /\<math\.acos\>/
syn match regentFunc /\<math\.asin\>/
syn match regentFunc /\<math\.atan\>/
syn match regentFunc /\<math\.atan2\>/
syn match regentFunc /\<math\.ceil\>/
syn match regentFunc /\<math\.sin\>/
syn match regentFunc /\<math\.cos\>/
syn match regentFunc /\<math\.tan\>/
syn match regentFunc /\<math\.deg\>/
syn match regentFunc /\<math\.exp\>/
syn match regentFunc /\<math\.floor\>/
syn match regentFunc /\<math\.log\>/
syn match regentFunc /\<math\.max\>/
syn match regentFunc /\<math\.min\>/
syn match regentFunc /\<math\.huge\>/
syn match regentFunc /\<math\.fmod\>/
syn match regentFunc /\<math\.modf\>/
syn match regentFunc /\<math\.cosh\>/
syn match regentFunc /\<math\.sinh\>/
syn match regentFunc /\<math\.tanh\>/
syn match regentFunc /\<math\.pow\>/
syn match regentFunc /\<math\.rad\>/
syn match regentFunc /\<math\.sqrt\>/
syn match regentFunc /\<math\.frexp\>/
syn match regentFunc /\<math\.ldexp\>/
syn match regentFunc /\<math\.random\>/
syn match regentFunc /\<math\.randomseed\>/
syn match regentFunc /\<math\.pi\>/
syn match regentFunc /\<io\.close\>/
syn match regentFunc /\<io\.flush\>/
syn match regentFunc /\<io\.input\>/
syn match regentFunc /\<io\.lines\>/
syn match regentFunc /\<io\.open\>/
syn match regentFunc /\<io\.output\>/
syn match regentFunc /\<io\.popen\>/
syn match regentFunc /\<io\.read\>/
syn match regentFunc /\<io\.stderr\>/
syn match regentFunc /\<io\.stdin\>/
syn match regentFunc /\<io\.stdout\>/
syn match regentFunc /\<io\.tmpfile\>/
syn match regentFunc /\<io\.type\>/
syn match regentFunc /\<io\.write\>/
syn match regentFunc /\<os\.clock\>/
syn match regentFunc /\<os\.date\>/
syn match regentFunc /\<os\.difftime\>/
syn match regentFunc /\<os\.execute\>/
syn match regentFunc /\<os\.exit\>/
syn match regentFunc /\<os\.getenv\>/
syn match regentFunc /\<os\.remove\>/
syn match regentFunc /\<os\.rename\>/
syn match regentFunc /\<os\.setlocale\>/
syn match regentFunc /\<os\.time\>/
syn match regentFunc /\<os\.tmpname\>/
syn match regentFunc /\<debug\.debug\>/
syn match regentFunc /\<debug\.gethook\>/
syn match regentFunc /\<debug\.getinfo\>/
syn match regentFunc /\<debug\.getlocal\>/
syn match regentFunc /\<debug\.getupvalue\>/
syn match regentFunc /\<debug\.setlocal\>/
syn match regentFunc /\<debug\.setupvalue\>/
syn match regentFunc /\<debug\.sethook\>/
syn match regentFunc /\<debug\.traceback\>/
syn match regentFunc /\<debug\.getmetatable\>/
syn match regentFunc /\<debug\.setmetatable\>/
syn match regentFunc /\<debug\.getregistry\>/
syn match regentFunc /\<debug\.getuservalue\>/
syn match regentFunc /\<debug\.setuservalue\>/
syn match regentFunc /\<debug\.upvalueid\>/
syn match regentFunc /\<debug\.upvaluejoin\>/
syn match regentFunc /\<regentlib\.assert\>/
syn match regentFunc /\<regentlib\.list\>/

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_regent_syntax_inits")
  if version < 508
    let did_regent_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink regentStatement	Statement
  HiLink regentRepeat		Repeat
  HiLink regentFor		Repeat
  HiLink regentString		String
  HiLink regentString2		String
  HiLink regentNumber		Number
  HiLink regentOperator		Operator
  HiLink regentConstant		Constant
  HiLink regentCond		Conditional
  HiLink regentCondElse		Conditional
  HiLink regentFunction		Function
  HiLink regentterraFunction	Function
  HiLink regentTask	        Function
  HiLink regentterraQuote	Function
  HiLink regentRQuote		Function
  HiLink regentRExpr		Function
  HiLink regentComment		Comment
  HiLink regentTodo		Todo
  HiLink regentTable		Structure
  HiLink regentStruct		Structure
  HiLink regentError		Error
  HiLink regentParenError	Error
  HiLink regentSpecial		SpecialChar
  HiLink regentFunc		Identifier
  HiLink regentVariable		Identifier
  HiLink regentType		Type
  HiLink regentLabel		Label

  delcommand HiLink
endif

let b:current_syntax = "regent"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: et ts=8 sw=2

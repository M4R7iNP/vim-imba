" Vim syntax file
"
" Language: Imba
" Language URL: http://imba.io/
"
" Maintainer: Simen Graaten <simeng@gmail.com>
" URL: https://github.com/simeng/vim-imba
"
" Based on work from sublime syntax file
"   https://github.com/somebee/sublime-imba/blob/master/Imba.sublime-syntax
" And coffee script vim syntax
"   https://github.com/kchmck/vim-coffee-script/blob/master/syntax/coffee.vim

if exists("b:current_syn")
	finish
endif

" Group definitions

syn keyword imbaBoolean true false yes no on off
hi def link imbaBoolean Boolean

syn match imbaMethod /\w\+/ display contained
hi def link imbaMethod Function

syn keyword imbaIncludeKeyword import export from await typeof extends super extern
hi def link imbaIncludeKeyword Include

syn keyword imbaKeyword by and or not is isnt isa tagdef expr
syn keyword imbaKeyword def class tag nextgroup=imbaMethod skipwhite
hi def link imbaKeyword Operator

" javascript built-in keywords (https://github.com/pangloss/vim-javascript/blob/dd84369d731bcb8feee0901cbb9b63a2b219bf28/syntax/javascript.vim#L112)
syn keyword jsGlobalObjects      Array Boolean Date Function Iterator Number Object Symbol Map WeakMap Set WeakSet RegExp String Proxy Promise Buffer ParallelArray ArrayBuffer DataView Float32Array Float64Array Int16Array Int32Array Int8Array Uint16Array Uint32Array Uint8Array Uint8ClampedArray JSON Math console document window Intl Collator DateTimeFormat NumberFormat fetch
syn keyword jsGlobalNodeObjects  module exports global process __dirname __filename
syn keyword jsExceptions         Error EvalError InternalError RangeError ReferenceError StopIteration SyntaxError TypeError URIError DOMException
syn keyword jsBuiltins           decodeURI decodeURIComponent encodeURI encodeURIComponent eval isFinite isNaN parseFloat parseInt uneval
syn keyword jsGlobalObjects  DOMImplementation DocumentFragment Document Node NodeList NamedNodeMap CharacterData Attr Element Text Comment CDATASection DocumentType Notation Entity EntityReference ProcessingInstruction
hi def link jsGlobalObjects Constant
hi def link jsGlobalNodeObjects Constant
hi def link jsExceptions Constant
hi def link jsBuiltins Constant

syn keyword Constant require
syn keyword Structure prop let var const

syn keyword imbaConditional if else elif unless switch then when
hi def link imbaConditional Conditional

syn keyword imbaStatement continue break throw return yield debugger
hi def link imbaStatement Statement

syn keyword imbaRepeat do for while until
hi def link imbaRepeat Repeat

syn keyword imbaException try catch finally
hi def link imbaException Exception

syn match imbaNumber "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match imbaNumber /\<\%(Infinity\|NaN\)\>/ display
hi def link imbaNumber Number

syn match imbaFloat /\%(\i\|\$\)\@<![-+]\?\d*\.\@<!\.\d\+\%([eE][+-]\?\d\+\)\?/ display
hi def link imbaFloat Float

syn region imbaStringVar start="{"hs=s+1 end="}"he=e-1 contained
syn region String start=/"/  skip=/\\"/  end=/"/ contains=imbaStringVar,@Spell
syn region String start=/'/  skip=/\\'/  end=/'/ contains=imbaStringVar,@Spell

syn keyword imbaTodo TODO FIXME TBD XXX HACK contained

syn match Comment "//.*" contains=imbaTodo display
syn match Comment "#.*" contains=imbaTodo display
syn region Comment start=/\/\*/ end=/\*\// contains=imbaTodo
syn region Comment start=/###/ end=/###/ contains=imbaTodo
hi def link imbaTodo Todo

syn keyword imbaOperator instanceof typeof delete void new in of
hi def link imbaOperator Operator

" The first case matches symbol operators only if they have an operand before.
syn match imbaExtendedOp /\%(\S\s*\)\@<=[+\-*/%&|\^=!<>?.]\{-1,}\|[-=]>\|--\|++\|:/ display
syn match imbaExtendedOp /\<\%(and\|or\)=/ display
hi def link imbaExtendedOp imbaOperator

" Regex-regex from javascript.vim
syn region imbaRegex start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 oneline
hi def link imbaRegex String

syn match imbaSpecialOp /[,;]/ display
hi def link imbaSpecialOp Delimiter

syn keyword imbaSpecialVar this prototype arguments self Imba
syn match imbaSpecialVar /\$\$/
hi def link imbaSpecialVar Special

syn match imbaSpecialIdent /@\%(\%(\I\|\$\)\%(\i\|\$\)*\)\?/ display
hi def link imbaSpecialIdent Identifier

syn match imbaGlobal /\<\%(null\|undefined\)\>/ display
hi def link imbaGlobal Type

syn match imbaConstant /\<\u[A-Z0-9_]\+\>/ display
hi def link imbaConstant Constant

syn cluster imbaIdentifier contains=imbaSpecialVar,imbaSpecialIdent,imbaObject,imbaConstant

" Tags (html-like markup)
" From http://stackoverflow.com/a/13620967 and html.vim
syn match imbaTagAttributeName /[a-z0-9\-]\+=/he=e-1 contained
syn match imbaTagAttributeWithoutQuotes contained "[a-z0-9\-]\+=[^"> ]\+" contains=imbaTagAttributeName,String,imbaBoolean,Variable,imbaNumber
syn region imbaTagAttribute contained start=+[a-z0-9\-]\+="+ skip=+\\\\\|\\"+ end=+"+ contains=imbaTagAttributeName,String,imbaBoolean,Variable keepend
syn match imbaTagName /<\i\+/ contained contains=imbaTagStart
syn region imbaTag start=/<\w\+/ end=/>/ contains=imbaTagName,imbaTagAttribute,imbaTagAttributeWithoutQuotes
syn match imbaTagStart '<' contained

hi def link imbaTag Function
hi def link imbaTagStart Function
hi def link imbaTagName Statement
hi def link imbaTagAttributeName Type

" Error marking

syn match imbaSemicolonError /;$/ display
hi def link imbaSemicolonError Error

syn match imbaWrongComment /^\s*\/\/.*$/ display
hi def link imbaWrongComment Error

" Cleanup

let b:current_syn = "imba"


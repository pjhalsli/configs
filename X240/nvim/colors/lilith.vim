" Lilith Theme: {{{
"
" https://github.com/szorfein/lilith.vim
"
" Code licensed under the MIT license
"
" @author Szorfein <szorfein@protonmail.com>
scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'lilith'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

let s:fg        = g:lilith#palette.fg

let s:bglighter = g:lilith#palette.bglighter
let s:bglight   = g:lilith#palette.bglight
let s:bg        = g:lilith#palette.bg
let s:bgdark    = g:lilith#palette.bgdark
let s:bgdarker  = g:lilith#palette.bgdarker

let s:comment   = g:lilith#palette.comment
let s:selection = g:lilith#palette.selection
let s:subtle    = g:lilith#palette.subtle

let s:secondary = g:lilith#palette.secondary
let s:green     = g:lilith#palette.green
let s:orange    = g:lilith#palette.orange
let s:primary   = g:lilith#palette.primary
let s:purple    = g:lilith#palette.purple
let s:error     = g:lilith#palette.error
let s:yellow    = g:lilith#palette.yellow

let s:none      = ['NONE', 'NONE']

if has('nvim')
  for s:i in range(16)
    let g:terminal_color_{s:i} = g:lilith#palette['color_' . s:i]
  endfor
endif

if has('terminal')
  let g:terminal_ansi_colors = []
  for s:i in range(16)
    call add(g:terminal_ansi_colors, g:lilith#palette['color_' . s:i])
  endfor
endif

" }}}2
" User Configuration: {{{2

if !exists('g:lilith_bold')
  let g:lilith_bold = 1
endif

if !exists('g:lilith_italic')
  let g:lilith_italic = 1
endif

if !exists('g:lilith_underline')
  let g:lilith_underline = 1
endif

if !exists('g:lilith_undercurl') && g:lilith_underline != 0
  let g:lilith_undercurl = 1
endif

if !exists('g:lilith_inverse')
  let g:lilith_inverse = 1
endif

if !exists('g:lilith_colorterm')
  let g:lilith_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:lilith_bold == 1 ? 'bold' : 0,
      \ 'italic': g:lilith_italic == 1 ? 'italic' : 0,
      \ 'underline': g:lilith_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:lilith_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:lilith_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

"}}}2
" Lilith Highlight Groups: {{{2

call s:h('LilithBgLight', s:none, s:bglight)
call s:h('LilithBgLighter', s:none, s:bglighter)
call s:h('LilithBgDark', s:none, s:bgdark)
call s:h('LilithBgDarker', s:none, s:bgdarker)

call s:h('LilithFg', s:fg)
call s:h('LilithFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('LilithFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('LilithComment', s:comment)
call s:h('LilithCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('LilithSelection', s:none, s:selection)

call s:h('LilithSubtle', s:subtle)

call s:h('LilithSecondary', s:secondary)
call s:h('LilithSecondaryItalic', s:secondary, s:none, [s:attrs.italic])

call s:h('LilithGreen', s:green)
call s:h('LilithGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('LilithGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('LilithGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('LilithOrange', s:orange)
call s:h('LilithOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('LilithOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('LilithOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('LilithOrangeInverse', s:bg, s:orange)

call s:h('LilithPrimary', s:primary)
call s:h('LilithPrimaryItalic', s:primary, s:none, [s:attrs.italic])

call s:h('LilithPurple', s:purple)
call s:h('LilithPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('LilithPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('LilithError', s:error)
call s:h('LilithErrorInverse', s:fg, s:error)

call s:h('LilithYellow', s:yellow)
call s:h('LilithYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('LilithError', s:error, s:none, [], s:error)

call s:h('LilithErrorLine', s:none, s:none, [s:attrs.undercurl], s:error)
call s:h('LilithWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('LilithInfoLine', s:none, s:none, [s:attrs.undercurl], s:secondary)

call s:h('LilithTodo', s:secondary, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('LilithSearch', s:green, s:none, [s:attrs.inverse])
call s:h('LilithBoundary', s:comment, s:bgdark)
call s:h('LilithLink', s:secondary, s:none, [s:attrs.underline])

call s:h('LilithDiffChange', s:orange, s:none)
call s:h('LilithDiffText', s:bg, s:orange)
call s:h('LilithDiffDelete', s:error, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, g:lilith_colorterm || has('gui_running') ? s:bg : s:none )
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('StatusLineTerm', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineTermNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  LilithBgDark
hi! link CursorColumn CursorLine
hi! link CursorLineNr LilithYellow
hi! link DiffAdd      LilithGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   LilithDiffChange
hi! link DiffDelete   LilithDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     LilithDiffText
hi! link Directory    LilithPurpleBold
hi! link ErrorMsg     LilithErrorInverse
hi! link FoldColumn   LilithSubtle
hi! link Folded       LilithBoundary
hi! link IncSearch    LilithOrangeInverse
hi! link LineNr       LilithComment
hi! link MoreMsg      LilithFgBold
hi! link NonText      LilithSubtle
hi! link Pmenu        LilithBgDark
hi! link PmenuSbar    LilithBgDark
hi! link PmenuSel     LilithSelection
hi! link PmenuThumb   LilithSelection
hi! link Question     LilithFgBold
hi! link Search       LilithSearch
hi! link SignColumn   LilithComment
hi! link TabLine      LilithBoundary
hi! link TabLineFill  LilithBgDarker
hi! link TabLineSel   Normal
hi! link Title        LilithGreenBold
hi! link VertSplit    LilithBoundary
hi! link Visual       LilithSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   LilithOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey LilithError
else
  hi! link SpecialKey LilithSubtle
endif

hi! link Comment LilithComment
hi! link Underlined LilithFgUnderline
hi! link Todo LilithTodo

hi! link Error LilithError
hi! link SpellBad LilithErrorLine
hi! link SpellLocal LilithWarnLine
hi! link SpellCap LilithInfoLine
hi! link SpellRare LilithInfoLine

hi! link Constant LilithPurple
hi! link String LilithYellow
hi! link Character LilithPrimary
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier LilithFg
hi! link Function LilithGreen

hi! link Statement LilithPrimary
hi! link Conditional LilithPrimary
hi! link Repeat LilithPrimary
hi! link Label LilithPrimary
hi! link Operator LilithPrimary
hi! link Keyword LilithPrimary
hi! link Exception LilithPrimary

hi! link PreProc LilithPrimary
hi! link Include LilithPrimary
hi! link Define LilithPrimary
hi! link Macro LilithPrimary
hi! link PreCondit LilithPrimary
hi! link StorageClass LilithPrimary
hi! link Structure LilithPrimary
hi! link Typedef LilithPrimary

hi! link Type LilithSecondaryItalic

hi! link Delimiter LilithFg

hi! link Special LilithPrimary
hi! link SpecialComment LilithSecondaryItalic
hi! link Tag LilithSecondary
hi! link helpHyperTextJump LilithLink
hi! link helpCommand LilithPurple
hi! link helpExample LilithGreen
hi! link helpBacktick Special

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0:

" vim: et ts=2 sts=2 sw=2

if !exists('g:airline#extensions#formatting#enabled')
  finish
endif

" Due to some potential rendering issues, the use of the `space` variable is
" recommended.
let s:spc = g:airline_symbols.space

" settings
if !exists('g:airline#extensions#formatting#show_shiftwidth')
  let g:airline#extensions#formatting#show_shiftwidth = 1
endif
if !exists('g:airline#extensions#formatting#space_glyph')
  let g:airline#extensions#formatting#space_glyph = '·'
endif
if !exists('g:airline#extensions#formatting#tab_glyph')
  let g:airline#extensions#formatting#tab_glyph = '→'
endif
if !exists('g:airline#extensions#formatting#text_glyph')
  let g:airline#extensions#formatting#text_glyph = '≡'
endif
if !exists('g:airline#extensions#formatting#wrap_no_pencil')
  let g:airline#extensions#formatting#wrap_no_pencil = '¶'
endif

" -----------------------------------------------------------------------------
" First we define an init function that will be invoked from extensions.vim
function! airline#extensions#formatting#init(ext)

  " Define a new part for the plugin.  This allows users to place this
  " extension in arbitrary locations.
  call airline#parts#define_raw('formatting', '%{airline#extensions#formatting#get_formatting()}')

  " Next up we add a funcref so that we can run some code prior to the
  " statusline getting modifed.
  call a:ext.add_statusline_func('airline#extensions#formatting#apply')

  " You can also add a funcref for inactive statuslines.
  " call a:ext.add_inactive_statusline_func('airline#extensions#formatting#unapply')
endfunction


" -----------------------------------------------------------------------------
" This function will be invoked just prior to the statusline getting modified.
function! airline#extensions#formatting#apply(...)
    let w:airline_section_y = get(w:, 'airline_section_y', g:airline_section_y)
    let w:airline_section_y = '%{airline#extensions#formatting#get_formatting()}'.s:spc.g:airline_right_alt_sep.s:spc.w:airline_section_y
endfunction


" -----------------------------------------------------------------------------
" Finally, this function will be invoked from the statusline.
function! airline#extensions#formatting#get_formatting()
  let sw = &shiftwidth
  let et = &expandtab
  let im = et > 0 ? g:airline#extensions#formatting#space_glyph : g:airline#extensions#formatting#tab_glyph

  let wm = ""
  if exists("*PencilMode")
    let wm = PencilMode()
  else 
    let wm = &wrap > 0 ? "¶" : ""
  endif

  return sw . im . g:airline#extensions#formatting#text_glyph . wm
endfunction


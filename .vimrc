" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

source $VIMRUNTIME/mswin.vim

" Global variables {{{
set nocompatible

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

let mapleader = "\<Space>"
let s:is_windows = has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_nvim = has('nvim')
let s:cache_dir = '~/.vim/.cache'

let s:settings = {}
let s:settings.colorscheme = 'gruvbox'
let s:settings.airline = 'gruvbox'
let s:settings.default_indent = 4
let s:settings.max_column = 120
let s:settings.enable_cursorcolumn = 0
" }}}

" Functions {{{
  function! s:get_cache_dir(suffix)
    return resolve(expand(s:cache_dir . '/' . a:suffix))
  endfunction
"}}}

" General settings {{{
" ====================================================================
  set clipboard=unnamedplus                         "sync with OS clipboard
  set timeoutlen=300                                  "mapping timeout
  set ttimeoutlen=50                                  "keycode timeout

  set mousehide                                       "hide when characters are typed
  set mouseshape=s:udsizing,m:no                      "turn mouse pointer to a up-down sizing arrow
  set history=1000                                    "number of command lines to remember
  set ttyfast                                         "assume fast terminal connection
  set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility
  set encoding=utf-8                                  "set encoding for text
  set fileencodings=utf-8,cp1251                      "encodings considered when starting to edit an existing file

  set hidden                                          "allow buffer switching without saving
  set autoread                                        "auto reload if file saved externally
  set fileformats+=mac                                "add mac to auto-detection of file format line endings
  set nrformats-=octal                                "always assume decimal numbers
  set showcmd
  set tags=tags;/
  set showfulltag
  set modeline
  set modelines=5

  set noshelltemp                                     " use pipes


  set scrolloff=1                                     " always show content after scroll
  set scrolljump=5                                    " minimum number of lines to scroll
  set display+=lastline
  set wildmenu                                        " show list for autocomplete
  set wildmode=list:full
  set wildignorecase

  set splitbelow
  set splitright
  set diffopt=filler,iwhite                           " filler and whitespace

  " disable sounds
  set noerrorbells
  set novisualbell
  set t_vb=

  set number
  set laststatus=2                                    "last window always has a status line
  set noshowmode                                      "useful if using vim-airline as to avoid duplicating
  set foldenable                                      "enable folds by default
  set foldmethod=manual                               "fold via syntax of files
  set foldlevelstart=99                               "open all folds by default
  let xml_syntax_folding=1                            "enable xml folding
  set guicursor=n:blinkon0                            "turn off cursor blinking in normal mode
  set shortmess+=I                                    "don't show the intro message starting Vim
" }}}

" Indentation {{{
" ====================================================================
  set backspace=indent,eol,start                      " allow backspacing everything in insert mode
  set breakindent                                     " this is just awesome (best patch in a long time)
  set expandtab                                       " spaces instead of tabs

  let &softtabstop=s:settings.default_indent          " number of spaces per tab in insert mode
  let &shiftwidth=s:settings.default_indent           " number of spaces when indenting
  set nolist                                          " highlight whitespace
  set listchars=tab:»·,trail:·,eol:¶
  set shiftround
  set linespace=1                                     " number of pixel lines inserted between characters
  set wrap                                            " wrap long lines
  set linebreak                                       " don't break words when wrapping
  let &showbreak='↪ '                                 " show ↪ at the beginning of wrapped lines
" }}}

" Search {{{
" ====================================================================
  set hlsearch                                        " highlight searches
  set incsearch                                       " incremental searching
  set ignorecase                                      " ignore case for searching
  set smartcase                                       " do case-sensitive if there's a capital letter

  set showmatch                                       "automatically highlight matching braces/brackets/etc.
  set matchtime=2                                     "tens of a second to show matching parentheses
" }}}

" Colors and fonts {{{
" ====================================================================
  set cursorline

  if has('conceal')
    set conceallevel=1
    set listchars+=conceal:Δ
  endif

  if has('gui_running')
    set lines=999 columns=9999  " open maximized
    set guioptions-=m           " remove menu bar
    set guioptions-=T           " remove toolbar
    set guioptions-=r           " remove right-hand scroll bar
    set guioptions-=L           " remove left-hand scroll bar
  endif

  if s:is_windows
    set gfn=Meslo_LG_L_DZ_for_Powerline_PNF:h9:cRUSSIAN
    set transparency=2
  endif

  if has('gui_gtk')
      set gfn=Meslo\ LG\ S\ DZ\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Pomicons\ 12
  endif

  if s:is_nvim
      set gfn=Meslo\ LG\ S\ DZ\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Pomicons\ 12
      set t_Co=256
  endif

  " Отображение кириллицы {{{
  if s:is_windows
      lan mes ru_RU.UTF-8
      source $VIMRUNTIME/delmenu.vim
      set langmenu=ru_RU.UTF-8
      source $VIMRUNTIME/menu.vim
  endif
  " }}}
" }}}

" Autoinstall vim-plug {{{
  if s:is_windows
    let s:plug_vim = $VIMRUNTIME . '\autoload\plug.vim'
  else
    let s:plug_vim = $HOME . '/.vim/autoload/plug.vim'
  endif

  if empty(glob(s:plug_vim))
    silent execute "!curl -k -fLo " . s:plug_vim . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall
  endif
" }}}

" Plugins initialization start {{{
  if s:is_windows
      call plug#begin($VIM . '/plugins')
  else
      call plug#begin( '~/.vim/plugins')
  endif
" }}}

" Appearance {{{
" ====================================================================
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
" {{{
      let g:airline_theme = s:settings.airline
      let g:airline#extensions#whitespace#enabled = 1
      let g:airline#extensions#tagbar#enabled = 1
      let g:airline#extensions#bufferline#enabled = 0
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#show_buffers = 1
      let g:airline#extensions#tabline#fnamemod = ':t'
      let g:airline#extensions#tabline#buffer_idx_mode = 1

      nmap <leader>1 <Plug>AirlineSelectTab1
      nmap <leader>2 <Plug>AirlineSelectTab2
      nmap <leader>3 <Plug>AirlineSelectTab3
      nmap <leader>4 <Plug>AirlineSelectTab4
      nmap <leader>5 <Plug>AirlineSelectTab5
      nmap <leader>6 <Plug>AirlineSelectTab6
      nmap <leader>7 <Plug>AirlineSelectTab7
      nmap <leader>8 <Plug>AirlineSelectTab8
      nmap <leader>9 <Plug>AirlineSelectTab9
 " }}}
 Plug 'vim-airline/vim-airline-themes'
 Plug 'majutsushi/tagbar'
 " {{{
      nnoremap <silent> <F9> :TagbarToggle<CR>

      let g:tagbar_type_plsql = {
          \ 'ctagstype' : 'sql',
          \ 'kinds' : [
              \ 'm:macros:0:1',
              \ 'P:packages:1:1',
              \ 'd:prototypes:0:1',
              \ 'c:cursors:0:1',
              \ 'f:functions:0:1',
              \ 'F:record fields:0:1',
              \ 'L:block label:0:1',
              \ 'p:procedures:0:1',
              \ 's:subtypes:0:1',
              \ 't:tables:0:1',
              \ 'T:triggers:0:1',
              \ 'v:variables:0:1',
              \ 'i:indexes:0:1',
              \ 'e:events:0:1',
              \ 'U:publications:0:1',
              \ 'R:services:0:1',
              \ 'D:domains:0:1',
              \ 'V:views:0:1',
              \ 'n:synonyms:0:1',
              \ 'x:MobiLink Table Scripts:0:1',
              \ 'y:MobiLink Conn Scripts:0:1',
              \ 'z:MobiLink Properties:0:1'
          \ ]
      \ }
 " }}}
Plug 'Yggdroot/indentLine'                                  " A vim plugin to display the indention levels with thin vertical lines
" {{{
  let g:indentLine_char='┆'
  let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree*']
" }}}
Plug 'tpope/vim-sleuth'                                     " Heuristically set buffer options
Plug 'junegunn/limelight.vim'                               " Hyperfocus-writing in Vim
" {{{
  let g:limelight_default_coefficient = 0.7
  let g:limelight_conceal_ctermfg = 238

  nmap <silent> gl :Limelight!!<CR>
  xmap gl <Plug>(Limelight)
" }}}
Plug 't9md/vim-choosewin'                                   " Navigate to the window you choose
" {{{
  let g:choosewin_blink_on_land = 0
  let g:choosewin_tabline_replace = 0

  nmap <leader>' <Plug>(choosewin)
" }}}
Plug 'zhaocai/GoldenView.Vim', { 'on': '<Plug>GoldenViewSplit' }
" {{{
  let g:goldenview__enable_default_mapping=0
  let g:goldenview__enable_at_startup=1

  nmap <silent> <C-L>  <Plug>GoldenViewSplit
" }}}
Plug 'arecarn/fold-cycle.vim'                               " Fold Cycling
" }}}
" Completion {{{
" ====================================================================
if s:is_nvim
Plug 'Shougo/deoplete.nvim'
" {{{
  let g:deoplete#enable_at_startup=1
  let g:deoplete#disable_auto_complete=0
  let g:deoplete#omni_patterns = {}
  let g:deoplete#omni_patterns.erlang='\<[[:digit:][:alnum:]_-]\+:[[:digit:][:alnum:]_-]*'
" }}}
endif
if !s:is_nvim
Plug 'Shougo/neocomplete.vim'
" {{{
  let g:neocomplete#enable_at_startup=1
  let g:neocomplete#disable_auto_complete=0
  let g:neocomplete#data_directory=s:get_cache_dir('neocomplete')
  let g:neocomplete#enable_cursor_hold_i=0
  let g:neocomplete#enable_insert_char_pre=1
  let g:neocomplete#enable_auto_select=1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  let g:neocomplete#fallback_mappings = ["\<C-x>\<C-o>", "\<C-x>\<C-n>"]

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.erlang='\<[[:digit:][:alnum:]_-]\+:[[:digit:][:alnum:]_-]*'
" }}}
endif
Plug 'ervandew/supertab'                                    " Perform all your vim insert mode completions with Tab
" {{{
  let g:SuperTabDefaultCompletionType = "context"
  let g:SuperTabContextTextMemberPatterns = ['\.', '>\?::', '->', ':']
  let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
  let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
  let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
" }}}
Plug 'SirVer/ultisnips'                                     " The ultimate snippet solution for Vim
" {{{
  nnoremap <leader>se :UltiSnipsEdit<CR>
  let g:UltiSnipsEditSplit = 'horizontal'

  let g:UltiSnipsListSnippets = '<nop>'
  let g:UltiSnipsExpandTrigger = '<c-l>'
  let g:UltiSnipsJumpForwardTrigger = '<c-l>'
  let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
  let g:ulti_expand_or_jump_res = 0

  function! <SID>ExpandSnippetOrReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return snippet
    else
      return "\<C-Y>"
    endif
  endfunction
  imap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "<Plug>delimitMateCR"
" }}}
Plug 'honza/vim-snippets'                                    " snipMate & UltiSnip Snippets
" }}}
" File Navigation {{{
" ====================================================================
Plug 'scrooloose/nerdtree'                                   " A tree explorer plugin for vim
" {{{
  au VimEnter * NERDTreeToggle | wincmd p

  let NERDTreeDirArrows=1
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'
  let NERDTreeShowHidden=0
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.git','\.hg']
  let NERDTreeBookmarksFile=s:get_cache_dir('NERDTreeBookmarks')

  nnoremap <F2> :NERDTreeToggle<CR>
  nnoremap <F3> :NERDTreeFind<CR>
" }}}
Plug 'mileszs/ack.vim'                                       " Run your favorite search tool from Vim
" {{{
  let g:ackprg = 'ag --vimgrep'
  let g:ack_use_dispatch = 1

  cnoreabbrev ag Ack
  cnoreabbrev aG Ack
  cnoreabbrev Ag Ack
  cnoreabbrev AG Ack

  function! SearchWordWithAg()
    execute 'Ack' expand('<cword>')
  endfunction

  function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ack' selection
  endfunction

  nnoremap <silent> <leader>/ :execute 'Ack ' . input('Ack/')<CR>
  nnoremap <silent> K :call SearchWordWithAg()<CR>
  vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
" }}}
if s:is_nvim
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }                     " A command-line fuzzy finder written in Go
Plug 'junegunn/fzf.vim'
" {{{
  let g:fzf_nvim_statusline = 0 " disable statusline overwriting

  nnoremap <silent> <leader><space> :Files<CR>
  nnoremap <silent> <leader>a :Buffers<CR>
  nnoremap <silent> <leader>A :Windows<CR>
  nnoremap <silent> <leader>; :BLines<CR>
  nnoremap <silent> <leader>. :Lines<CR>
  nnoremap <silent> <leader>o :BTags<CR>
  nnoremap <silent> <leader>O :Tags<CR>
  nnoremap <silent> <leader>? :History<CR>
  nnoremap <silent> <leader>gl :Commits<CR>
  nnoremap <silent> <leader>ga :BCommits<CR>
  nnoremap <silent> <leader>ft :Filetypes<CR>

  imap <C-x><C-f> <plug>(fzf-complete-file-ag)
  imap <C-x><C-l> <plug>(fzf-complete-line)
" }}}
endif
if !s:is_nvim
Plug 'ctrlpvim/ctrlp.vim'                                    " Fuzzy file, buffer, mru, tag, etc finder
" {{{
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
  let g:ctrlp_use_caching = 0

  let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$'
            \ }

  let g:ctrlp_user_command = {
            \ 'types': {
                \ 1: ['.git', 'cd %s && git ls-files'],
            \ },
            \ 'fallback': 'ag %s -l --nocolor -g ""'
        \ }

  nmap \ [ctrlp]
  nnoremap [ctrlp] <nop>
  nnoremap [ctrlp]f :CtrlP<cr>
  nnoremap [ctrlp]t :CtrlPBufTag<cr>
  nnoremap [ctrlp]T :CtrlPTag<cr>
  nnoremap [ctrlp]l :CtrlPLine<cr>
  nnoremap [ctrlp]b :CtrlPBuffer<cr>
" }}}
Plug 'FelikZ/ctrlp-py-matcher'                               " Fast vim CtrlP matcher based on python
endif
Plug 'dyng/ctrlsf.vim'                                       " An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
" {{{
  vmap     <C-F> <Plug>CtrlSFVwordExec
  nmap     <C-F> <Plug>CtrlSFCwordPath
  nnoremap <C-O> :CtrlSFOpen<CR>
" }}}
if !s:is_nvim
Plug 'Shougo/vimshell.vim',  { 'on': ['VimShellExecute','VimShell', 'VimShellPop', 'VimShellInteractive'] }
" {{{
  let g:vimshell_editor_command='vim'
  let g:vimshell_right_prompt='getcwd()'
  let g:vimshell_data_directory=s:get_cache_dir('vimshell')
  let g:vimshell_vimshrc_path='~/.vim/vimshrc'

  nnoremap <leader>c :VimShellPop <cr>
  nnoremap <leader>cc :VimShell <cr>
  nnoremap <leader>ce :VimShellInteractive erl<cr>
" }}}
endif
" }}}
" Text Navigation {{{
" ====================================================================
Plug 'majutsushi/tagbar'
" {{{
  let g:tagbar_type_plsql = {
          \ 'ctagstype' : 'sql',
          \ 'kinds' : [
              \ 'm:macros:0:1',
              \ 'P:packages:1:1',
              \ 'd:prototypes:0:1',
              \ 'c:cursors:0:1',
              \ 'f:functions:0:1',
              \ 'F:record fields:0:1',
              \ 'L:block label:0:1',
              \ 'p:procedures:0:1',
              \ 's:subtypes:0:1',
              \ 't:tables:0:1',
              \ 'T:triggers:0:1',
              \ 'v:variables:0:1',
              \ 'i:indexes:0:1',
              \ 'e:events:0:1',
              \ 'U:publications:0:1',
              \ 'R:services:0:1',
              \ 'D:domains:0:1',
              \ 'V:views:0:1',
              \ 'n:synonyms:0:1',
              \ 'x:MobiLink Table Scripts:0:1',
              \ 'y:MobiLink Conn Scripts:0:1',
              \ 'z:MobiLink Properties:0:1'
          \ ]
      \ }
  nnoremap <silent> <F9> :TagbarToggle<CR>
" }}}
Plug 'haya14busa/incsearch.vim'                              " Improved incremental searching for Vim
" {{{
  let g:incsearch#auto_nohlsearch = 1

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
" }}}
" }}}
" Text Manipulation {{{
" ====================================================================
Plug 'tpope/vim-surround'                                    " quoting/parenthesizing made simple
Plug 'junegunn/vim-easy-align'                               " A simple, easy-to-use Vim alignment plugin
" {{{
  let g:easy_align_ignore_comment = 0 " align comments
  vnoremap <silent> <Enter> :EasyAlign<cr>
" }}}
Plug 'tomtom/tcomment_vim'                                   " An extensible & universal comment vim-plugin that also handles embedded filetypes
Plug 'Raimondi/delimitMate'
" {{{
  let delimitMate_expand_cr = 2
  let delimitMate_expand_space = 1 " {|} => { | }
" }}}
Plug 'vim-scripts/DeleteTrailingWhitespace'
" {{{
  let g:DeleteTrailingWhitespace = 1
  let g:DeleteTrailingWhitespace_Action = 'delete'
" }}}
" }}}
" Languages {{{
" ====================================================================
Plug 'scrooloose/syntastic'
" {{{
  let g:syntastic_error_symbol = '✗'
  let g:syntastic_style_error_symbol = '✠'
  let g:syntastic_warning_symbol = '∆'
  let g:syntastic_style_warning_symbol = '≈'
  let g:syntastic_ignore_files = ['\m\c\.sql$']
  let g:syntastic_always_populate_loc_list = 0
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_reuse_loc_lists = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_erlang_checkers=['syntaxerl']

  function! ToggleErrors()
    if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
      " No location/quickfix list shown, open syntastic error location panel
      Errors
    else
      lclose
    endif
  endfunction

  nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
" }}}
Plug 'vim-erlang/vim-erlang-runtime',      { 'for': 'erlang'}
Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang'}
Plug 'ten0s/syntaxerl',                    { 'for': 'erlang'}
Plug 'fishcakez/vim-rebar'
Plug 'calebsmith/vim-lambdify'
if !s:is_nvim
Plug 'talek/vorax4'
" {{{
  let g:vorax_output_window_default_funnel = 3
  let g:vorax_debug = 0
  let g:vorax_dbexplorer_side = 'right'
  let g:vorax_sql_script_default_extension = 'plsql'
  let g:vorax_plsql_associations = {'FUNCTION'     : 'fnc',
                                 \  'PROCEDURE'    : 'prc*',
                                 \  'TRIGGER'      : 'trg',
                                 \  'PACKAGE_SPEC' : 'pks*',
                                 \  'PACKAGE_BODY' : 'pkb*',
                                 \  'PACKAGE'      : 'pkg',
                                 \  'TYPE_SPEC'    : 'tps*',
                                 \  'TYPE_BODY'    : 'tpb*',
                                 \  'TYPE'         : 'typ*',
                                 \  'JAVA_SOURCE'  : 'jsp'}

  nnoremap <silent> <F12> :VORAXConnectionsToggle<CR>
" }}}
endif
Plug 'vim-scripts/dbext.vim'
" {{{
  let g:dbext_default_buffer_lines = 5
  let g:dbext_default_use_sep_result_buffer = 0
  let g:dbext_default_use_result_buffer = 1
  let g:dbext_default_window_use_horiz = 1
  let g:sql_type_default = 'plsql'
" }}}
Plug 'chrisbra/csv.vim'
" }}}
" Git {{{
" ====================================================================
Plug 'tpope/vim-fugitive'
" {{{
  " Fix broken syntax highlight in gitcommit files
  " (https://github.com/tpope/vim-git/issues/12)
  let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  nnoremap <silent> <leader>gE :Gedit<space>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gR :Gread<space>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>gW :Gwrite!<CR>
  nnoremap <silent> <leader>gq :Gwq<CR>
  nnoremap <silent> <leader>gQ :Gwq!<CR>

  function! ReviewLastCommit()
    if exists('b:git_dir')
      Gtabedit HEAD^{}
      nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
    else
      echo 'No git a git repository:' expand('%:p')
    endif
  endfunction
  nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>

  augroup fugitiveSettings
    autocmd!
    autocmd FileType gitcommit setlocal nolist
    autocmd BufReadPost fugitive://* setlocal bufhidden=delete
  augroup END
" }}}
Plug 'idanarye/vim-merginal'
" {{{
  nnoremap <leader>gm :MerginalToggle<CR>
" }}}
Plug 'airblade/vim-gitgutter'
" {{{
  let g:gitgutter_map_keys = 0
  let g:gitgutter_max_signs = 200
  let g:gitgutter_realtime = 0
  let g:gitgutter_eager = 1
  let g:gitgutter_sign_removed = '–'
  let g:gitgutter_diff_args = '--ignore-space-at-eol'

  nmap <silent> ]h :GitGutterNextHunk<CR>
  nmap <silent> [h :GitGutterPrevHunk<CR>
  nnoremap <silent> <Leader>gu :GitGutterRevertHunk<CR>
  nnoremap <silent> <Leader>gp :GitGutterPreviewHunk<CR><c-w>j
  nnoremap cog :GitGutterToggle<CR>
  nnoremap <Leader>gt :GitGutterAll<CR>
" }}}
" }}}
" Utility {{{
" ====================================================================
if !s:is_nvim
Plug $VIM . '/plugins/vimproc'
endif
Plug 'tpope/vim-dispatch'
Plug 'dbakker/vim-projectroot'
" {{{
  let g:rootmarkers = ['.projectroot','.git','.hg','.svn','rebar.config']

  function! <SID>AutoProjectRootCD() "{{{
    try
      if &ft != 'help'
        ProjectRootCD
      endif
    catch
      " Silently ignore invalid buffers
    endtry
  endfunction "}}}

  augroup projectrootSettings
    autocmd!
    au BufEnter * call <SID>AutoProjectRootCD()
  augroup END
" }}}
Plug 'tpope/vim-obsession'
Plug 'lyokha/vim-xkbswitch'
" {{{
  let g:XkbSwitchEnabled = 1
  let g:XkbSwitchLib = '/usr/lib/libxkbswitch.so'
  let g:XkbSwitchNLayout = 'us'
  let g:XkbSwitchILayout = 'us'

  function! RestoreKeyboardLayout(key)
    call system("xkb-switch -s 'us(rus)'")
    execute 'normal! ' . a:key
  endfunction

  nnoremap <silent> р :call RestoreKeyboardLayout('h')<CR>
  nnoremap <silent> о :call RestoreKeyboardLayout('j')<CR>
  nnoremap <silent> л :call RestoreKeyboardLayout('k')<CR>
  nnoremap <silent> д :call RestoreKeyboardLayout('l')<CR>
" }}}
Plug 'ludovicchabant/vim-gutentags'
" {{{
  let g:gutentags_exclude = [
      \ '*.min.js',
      \ '*html*',
      \ 'jquery*.js',
      \ '*/vendor/*',
      \ '*/node_modules/*',
      \ '*/python2.7/*',
      \ '*/migrate/*.rb'
      \ ]
  let g:gutentags_generate_on_missing = 0
  let g:gutentags_generate_on_write = 0
  let g:gutentags_generate_on_new = 0

  nnoremap <leader>t! :GutentagsUpdate!<CR>
" }}}
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-unimpaired'
Plug 'janko-m/vim-test'
" {{{
  function! TerminalSplitStrategy(cmd) abort
    tabnew | call termopen(a:cmd) | startinsert
  endfunction

  let g:test#custom_strategies = get(g:, 'test#custom_strategies', {})
  let g:test#custom_strategies.terminal_split = function('TerminalSplitStrategy')
  let test#strategy = 'terminal_split'

  nnoremap <silent> <leader>rr :TestFile<CR>
  nnoremap <silent> <leader>rf :TestNearest<CR>
  nnoremap <silent> <leader>rs :TestSuite<CR>
  nnoremap <silent> <leader>ra :TestLast<CR>
  nnoremap <silent> <leader>ro :TestVisit<CR>
" }}}
Plug '907th/vim-auto-save'
" {{{
  let g:auto_save_in_insert_mode = 0
  let g:auto_save_events = ['CursorHold']

  nnoremap coa :AutoSaveToggle<CR>
" }}}
if s:is_windows
Plug 'kkoenig/wimproved.vim'
" {{{
  augroup wimprovedSettings
    autocmd!
    autocmd GUIEnter * silent! WToggleClean
  augroup END
" }}}
endif
" }}}
" Misc {{{
" ====================================================================
Plug 'mhinz/vim-sayonara'                                    " Window killer
" {{{
  nnoremap <leader>q :Sayonara<cr>
  nnoremap <leader>Q :Sayonara!<cr>
" }}}

Plug 'tyru/open-browser.vim'
" {{{
  let g:netrw_nogx = 1

  vmap gx <Plug>(openbrowser-smart-search)
  nmap gx <Plug>(openbrowser-search)
" }}}
Plug 'vim-scripts/ingo-library'
Plug 'MarcWeber/vim-addon-qf-layout'
Plug 'KabbAmine/zeavim.vim'
" {{{
  let g:zv_zeal_executable = 'zeal.exe --query '
" }}}
" }}}
" Finish loading {{{
  call plug#end()
  filetype plugin indent on
  syntax enable
  syntax sync minlines=200 " helps to avoid syntax highlighting bugs

  set background=dark
  exec 'colorscheme '.s:settings.colorscheme
" }}}

" Key Mappings {{{
" ====================================================================

" Buffers
nnoremap <Tab> :bnext<cr>
nnoremap <S-Tab> :bprevious<cr>
nmap <c-w> :bp <bar> bd! #<cr>
nmap <c-n> :enew<cr>

" Shifting blocks visually
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev  :e $VIM\vimrc<CR>
nnoremap <silent> <leader>esv :vsplit<CR><C-w><C-w>:e $VIM\vimrc<CR>
nnoremap <silent> <leader>sv  :so $VIM\vimrc<CR>:nohl<CR>

" Map : to ; (then remap ;) -- massive pinky-saver
noremap ; :
noremap <M-;> ;

" Map escape key to jj -- much faster
inoremap jj <esc>

" Bubble lines
nnoremap <silent> <C-Up>   :move-2<CR>==
nnoremap <silent> <C-Down> :move+<CR>==
xnoremap <silent> <C-Up>   :move-2<CR>gv=gv
xnoremap <silent> <C-Down> :move'>+<CR>gv=gv

" Duplicate lines above and below
inoremap <C-A-down> <esc>Ypk
nnoremap <C-A-down> Ypk
xnoremap <C-A-down> y`>pgv
inoremap <C-A-up> <esc>YPj
nnoremap <C-A-up> YPj
xnoremap <C-A-up> y`<Pgv

" Jump back to last edited buffer
nnoremap <C-b> :e#<CR>
inoremap <C-b> <esc>:e#<CR>

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" If split in given direction exists - jump, else create new split
function! JumpOrOpenNewSplit(key, cmd, fzf) " {{{
  let current_window = winnr()
  execute 'wincmd' a:key
  if current_window == winnr()
    execute a:cmd
    if a:fzf
      Files
    endif
  else
    if a:fzf
      Files
    endif
  endif
endfunction " }}}
nnoremap <silent> <Leader>hh :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 0)<CR>
nnoremap <silent> <Leader>ll :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 0)<CR>
nnoremap <silent> <Leader>kk :call JumpOrOpenNewSplit('k', ':leftabove split', 0)<CR>
nnoremap <silent> <Leader>jj :call JumpOrOpenNewSplit('j', ':rightbelow split', 0)<CR>

" Same as above, except it opens fzf at the end
nnoremap <silent> <Leader>h<Space> :call JumpOrOpenNewSplit('h', ':leftabove vsplit', 1)<CR>
nnoremap <silent> <Leader>l<Space> :call JumpOrOpenNewSplit('l', ':rightbelow vsplit', 1)<CR>
nnoremap <silent> <Leader>k<Space> :call JumpOrOpenNewSplit('k', ':leftabove split', 1)<CR>
nnoremap <silent> <Leader>j<Space> :call JumpOrOpenNewSplit('j', ':rightbelow split', 1)<CR>

" Universal closing behavior
function! CloseWindowOrKillBuffer() "{{{
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  " never bdelete a nerd tree
  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    bdelete
  endif
endfunction

nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>
nnoremap <silent> Й :call CloseWindowOrKillBuffer()<cr>
" }}}

" Autocommands {{{
" ====================================================================

augroup fileTypeSpecific
  autocmd!

  " PL/SQL
  au BufEnter *.pkb.sql setf plsql
  au BufEnter *.pks.sql setf plsql
  au BufEnter *.pkb     setf plsql
  au BufEnter *.pks     setf plsql
  au BufEnter *.tps.sql setf plsql
  au BufEnter *.tpb.sql setf plsql
  au BufEnter *.typ.sql setf plsql

  au BufEnter *.pk* :IndentLinesReset

  au BufEnter *.pkb.sql :IndentLinesReset
  au BufEnter *.pks.sql :IndentLinesReset
  au BufEnter *.pkb     :IndentLinesReset
  au BufEnter *.pks     :IndentLinesReset
  au BufEnter *.tps.sql :IndentLinesReset
  au BufEnter *.tpb.sql :IndentLinesReset
  au BufEnter *.typ.sql :IndentLinesReset

  " Erlang
  autocmd FileType erlang map <buffer> <S-F10> :VimShellExecute --split='split \| resize 10' rebar compile<cr>
  autocmd FileType erlang map <buffer> <S-F11> :VimShellExecute --split='split \| resize 10' rebar eunit skip_deps=true<cr>

  " Java
  autocmd FileType java set omnifunc=javacomplete#Complete

  au Filetype pom compiler mvn
  au Filetype pom no <C-F2> :make clean<CR>

  " CSV
  au! BufRead,BufNewFile *.csv,*.dat  setf csv
augroup END

"}}}

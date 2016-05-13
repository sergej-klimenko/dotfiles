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
"}}}

" Global settings {{{
let g:sql_type_default = 'plsql'

let s:settings = {}
"let s:settings.colorscheme = 'hybrid_reverse'
let s:settings.colorscheme = 'gruvbox'
"let s:settings.airline = 'hybridalt'
let s:settings.airline = 'gruvbox'
let s:settings.default_indent = 4
let s:settings.max_column = 120
let s:settings.enable_cursorcolumn = 0

let s:settings.plugin_groups_exclude = []
let s:settings.plugin_groups = []
call add(s:settings.plugin_groups, 'core')
call add(s:settings.plugin_groups, 'web')
call add(s:settings.plugin_groups, 'python')
call add(s:settings.plugin_groups, 'go')
call add(s:settings.plugin_groups, 'erlang')
call add(s:settings.plugin_groups, 'c')
call add(s:settings.plugin_groups, 'scm')
call add(s:settings.plugin_groups, 'editing')
call add(s:settings.plugin_groups, 'indents')
call add(s:settings.plugin_groups, 'navigation')
call add(s:settings.plugin_groups, 'unite')
call add(s:settings.plugin_groups, 'autocomplete')
call add(s:settings.plugin_groups, 'misc')
call add(s:settings.plugin_groups, 'sql')

for group in s:settings.plugin_groups_exclude
  let i = index(s:settings.plugin_groups, group)
  if i != -1
    call remove(s:settings.plugin_groups, i)
  endif
endfor

"}}}

" Functions {{{
  function! s:get_cache_dir(suffix) "{{{
    return resolve(expand(s:cache_dir . '/' . a:suffix))
  endfunction "}}}
  function! Source(begin, end) "{{{
    let lines = getline(a:begin, a:end)
    for line in lines
      execute line
    endfor
  endfunction "}}}
  function! Preserve(command) "{{{
    " preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    execute a:command
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
  endfunction "}}}
  function! StripTrailingWhitespace() "{{{
    call Preserve("%s/\\s\\+$//e")
  endfunction "}}}
  function! EnsureExists(path) "{{{
    if !isdirectory(expand(a:path))
      call mkdir(expand(a:path))
    endif
  endfunction "}}}
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
  endfunction "}}}

  function! s:SetCursorPosition() "{{{
    if &filetype !~ 'svn\|commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
  endfunction "}}}

  function! ToggleErrors() "{{{
      if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
          " No location/quickfix list shown, open syntastic error location panel
          Errors
      else
          lclose
      endif
  endfunction "}}}
"}}}

" Base configuration {{{
  set timeoutlen=300                                  "mapping timeout
  set ttimeoutlen=50                                  "keycode timeout

  set mousehide                                       "hide when characters are typed
  set mouseshape=s:udsizing,m:no                      "turn mouse pointer to a up-down sizing arrow
  set history=1000                                    "number of command lines to remember
  set ttyfast                                         "assume fast terminal connection
  set viewoptions=folds,options,cursor,unix,slash     "unix/windows compatibility
  set encoding=utf-8                                  "set encoding for text
  set fileencodings=utf-8,cp1251                      "encodings considered when starting to edit an existing file
  if exists('$TMUX')
    set clipboard=
  else
    set clipboard=unnamedplus                         "sync with OS clipboard
  endif
  set hidden                                          "allow buffer switching without saving
  set autoread                                        "auto reload if file saved externally
  set fileformats+=mac                                "add mac to auto-detection of file format line endings
  set nrformats-=octal                                "always assume decimal numbers
  set showcmd
  set tags=tags;/
  set showfulltag
  set modeline
  set modelines=5

  if s:is_windows && !s:is_cygwin
    " ensure correct shell in gvim
    set shell=c:\windows\system32\cmd.exe
  endif

  set noshelltemp                                     " use pipes
  set backspace=indent,eol,start                      " allow backspacing everything in insert mode
  set breakindent                                     " this is just awesome (best patch in a long time)
  set expandtab                                       " spaces instead of tabs
  "set smarttab                                        " use shiftwidth to enter tabs

  let &softtabstop=s:settings.default_indent          " number of spaces per tab in insert mode
  let &shiftwidth=s:settings.default_indent           " number of spaces when indenting
  set nolist                                          " highlight whitespace
  set listchars=tab:»·,trail:·,eol:¶
  set shiftround
  set linespace=1                                     " number of pixel lines inserted between characters
  set wrap                                            " wrap long lines
  set linebreak                                       " don't break words when wrapping
  let &showbreak='↪ '                                 " show ↪ at the beginning of wrapped lines

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

  " searching
  set hlsearch                                        " highlight searches
  set incsearch                                       " incremental searching
  set ignorecase                                      " ignore case for searching
  set smartcase                                       " do case-sensitive if there's a capital letter

"}}}

" UI Configuration {{{
  set showmatch                                       "automatically highlight matching braces/brackets/etc.
  set matchtime=2                                     "tens of a second to show matching parentheses
  set number

  set laststatus=2                                    "last window always has a status line
  set noshowmode                                      "useful if using vim-airline as to avoid duplicating
  set foldenable                                      "enable folds by default
  set foldmethod=syntax                               "fold via syntax of files
  set foldlevelstart=99                               "open all folds by default
  let xml_syntax_folding=1                          "enable xml folding
  set guicursor=n:blinkon0                            "turn off cursor blinking in normal mode
  set shortmess+=I                                    "don't show the intro message starting Vim

  set cursorline
  "autocmd WinLeave * setlocal nocursorline
  "autocmd WinEnter * setlocal cursorline
  "let &colorcolumn=s:settings.max_column
  "if s:settings.enable_cursorcolumn
  "  set cursorcolumn
  "  autocmd WinLeave * setlocal nocursorcolumn
  "  autocmd WinEnter * setlocal cursorcolumn
  "endif
  "let &textwidth=s:settings.max_column                 "maximum width of text that is being inserted

  if has('conceal')
    set conceallevel=1
    set listchars+=conceal:Δ
  endif

  if has('gui_running')
    " open maximized
    set lines=999 columns=9999

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar

    if s:is_windows
       set gfn=Meslo_LG_L_DZ_for_Powerline_PNF:h9:cRUSSIAN
       set transparency=2
    endif
  endif

  if has('gui_gtk')
      set gfn=Meslo\ LG\ S\ DZ\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Pomicons\ 12
  endif

  if s:is_nvim
      set gfn=Meslo\ LG\ S\ DZ\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Pomicons\ 12
      set t_Co=256
  endif
"}}}

" Отображение кириллицы {{{
if s:is_windows
    lan mes ru_RU.UTF-8
    source $VIMRUNTIME/delmenu.vim
    set langmenu=ru_RU.UTF-8
    source $VIMRUNTIME/menu.vim
endif
"}}}

" Plugin configuration {{{

    " Airline {{{
      let g:airline_theme = s:settings.airline
      let g:airline#extensions#whitespace#enabled = 1
      let g:airline#extensions#tagbar#enabled = 1
      let g:airline#extensions#bufferline#enabled = 0
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#show_buffers = 1
      let g:airline#extensions#tabline#fnamemod = ':t'
      let g:airline#extensions#tabline#buffer_idx_mode = 1
    "}}}

    " Ack {{{
      if executable('ag')
        let g:ackprg = "ag --nogroup --column --smart-case --follow"
      endif

      if executable('ack')
        set grepprg=ack\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow\ $*
        set grepformat=%f:%l:%c:%m
      endif

      if executable('ag')
        set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
        set grepformat=%f:%l:%c:%m,%f:%l:%m
      endif
    "}}}

    " CtrlP {{{
      let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$'
            \ }
      let g:ctrlp_extensions=['funky']
      let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
      let g:ctrlp_user_command = 'ag -l --nocolor -g "" %s'
      let g:ctrlp_use_caching = 0
    " }}}

    " NERDTree {{{
      au VimEnter * NERDTreeToggle | wincmd p
      let NERDTreeDirArrows=1
      let NERDTreeShowHidden=0
      let NERDTreeShowBookmarks=1
      let NERDTreeIgnore=['\.git','\.hg']
      let NERDTreeBookmarksFile=s:get_cache_dir('NERDTreeBookmarks')
    "}}}

    " SuperTab {{{
      let g:SuperTabDefaultCompletionType = "context"
      let g:SuperTabContextTextMemberPatterns = ['\.', '>\?::', '->', ':']
      let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
      let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
      let g:SuperTabContextDiscoverDiscovery =
        \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
    "}}}

    " UltiSnips {{{
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
        let g:UltiSnipsSnippetsDir='~/.vim/snippets'
        let g:UltiSnipsExpandTrigger = "<nop>"
        let g:ulti_expand_or_jump_res = 0

        function ExpandSnippetOrCarriageReturn()
          let snippet = UltiSnips#ExpandSnippetOrJump()
          if g:ulti_expand_or_jump_res > 0
            return snippet
          else
            return "\<CR>"
          endif
        endfunction
        inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
   "}}}

   " NeoComplete {{{
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
    "}}}

    " Deoplete {{{
        let g:deoplete#enable_at_startup=1
        let g:deoplete#disable_auto_complete=0
        let g:deoplete#omni_patterns = {}
        let g:deoplete#omni_patterns.erlang='\<[[:digit:][:alnum:]_-]\+:[[:digit:][:alnum:]_-]*'
    " }}}

    " VimShell {{{
      let g:vimshell_editor_command='vim'
      let g:vimshell_right_prompt='getcwd()'
      let g:vimshell_data_directory=s:get_cache_dir('vimshell')
      let g:vimshell_vimshrc_path='~/.vim/vimshrc'
    "}}}

    " GoldenView {{{
      let g:goldenview__enable_default_mapping=0
      let g:goldenview__enable_at_startup=1
    "}}}

    " XkbSwitch {{{
      let g:XkbSwitchEnabled = 1
    "}}}

    " Syntastic {{{
    "
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
    "}}}

    " Tagbar {{{
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

    " Fugitive {{{
      autocmd BufReadPost fugitive://* set bufhidden=delete
    "}}}

    " Vorax {{{
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
    "}}}

    " Dbext {{{
      let g:dbext_default_buffer_lines = 5
      let g:dbext_default_use_sep_result_buffer = 0
      let g:dbext_default_use_result_buffer = 1
      let g:dbext_default_window_use_horiz = 1
    "}}}

    " incsearch {{{
      let g:incsearch#auto_nohlsearch = 1
    "}}}

    " ProSession {{{
      let g:prosession_on_startup = 1
    "}}}

    " Project Root {{{
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
    "}}}

    " DeleteTrailingWhitespace {{{
      let g:DeleteTrailingWhitespace = 1
      let g:DeleteTrailingWhitespace_Action = 'delete'
    " }}}

    " ZeaVim {{{
     let g:zv_zeal_directory = 'zeal'
    " let g:investigate_command_for_erlang = 'zeal --query ^s'
    " }}}

    " Vim-erlang {{{
    " let g:erlang_folding = 1
    " }}}
"}}}

" Mappings {{{

    " Airline
    nmap <leader>1 <Plug>AirlineSelectTab1
    nmap <leader>2 <Plug>AirlineSelectTab2
    nmap <leader>3 <Plug>AirlineSelectTab3
    nmap <leader>4 <Plug>AirlineSelectTab4
    nmap <leader>5 <Plug>AirlineSelectTab5
    nmap <leader>6 <Plug>AirlineSelectTab6
    nmap <leader>7 <Plug>AirlineSelectTab7
    nmap <leader>8 <Plug>AirlineSelectTab8
    nmap <leader>9 <Plug>AirlineSelectTab9

    " CtrlP
    nmap \ [ctrlp]
    nnoremap [ctrlp] <nop>
    nnoremap [ctrlp]f :CtrlP<cr>
    nnoremap [ctrlp]t :CtrlPBufTag<cr>
    nnoremap [ctrlp]T :CtrlPTag<cr>
    nnoremap [ctrlp]l :CtrlPLine<cr>
    nnoremap [ctrlp]o :CtrlPFunky<cr>
    nnoremap [ctrlp]b :CtrlPBuffer<cr>

    " NERDTree
    nnoremap <F2> :NERDTreeToggle<CR>
    nnoremap <F3> :NERDTreeFind<CR>

    " Tagbar
    nnoremap <silent> <F9> :TagbarToggle<CR>

    " VimShell
    nnoremap <leader>c :VimShellPop <cr>
    nnoremap <leader>cc :VimShell <cr>
    nnoremap <leader>ce :VimShellInteractive erl<cr>

    " GoldenView
    nmap <silent> <C-L>  <Plug>GoldenViewSplit

    " Fugitive
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
    nnoremap <silent> <leader>gw :Gwrite<CR>
    nnoremap <silent> <leader>gr :Gremove<CR>

    " GitV
    nnoremap <silent> <leader>gv :Gitv<CR>
    nnoremap <silent> <leader>gV :Gitv!<CR>

    " Vorax
    nnoremap <silent> <F12> :VORAXConnectionsToggle<CR>

    " Ctrl-F
    vmap     <C-F> <Plug>CtrlSFVwordExec
    nmap     <C-F> <Plug>CtrlSFCwordPath
    nnoremap <C-O> :CtrlSFOpen<CR>

    " Show whitespaces
    nmap <leader>l :set list! list?<cr>

    " Window killer
    nnoremap <silent> Q :call CloseWindowOrKillBuffer()<cr>
    nnoremap <leader>q :Sayonara<cr>
    nnoremap <leader>Q :Sayonara!<cr>

    " Buffers
    nnoremap <Tab> :bnext<cr>
    nnoremap <S-Tab> :bprevious<cr>
    nmap <c-w> :bp <bar> bd! #<cr>
    nmap <c-n> :enew<cr>

    " incsearch
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    map n  <Plug>(incsearch-nohl-n)
    map N  <Plug>(incsearch-nohl-N)
    map *  <Plug>(incsearch-nohl-*)
    map #  <Plug>(incsearch-nohl-#)
    map g* <Plug>(incsearch-nohl-g*)
    map g# <Plug>(incsearch-nohl-g#)

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

    nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
"}}}

" Plugins {{{

  if s:is_windows
    let s:plug_vim = $VIMRUNTIME . '\autoload\plug.vim'
  else
    let s:plug_vim = $HOME . '/.vim/autoload/plug.vim'
  endif

  if empty(glob(s:plug_vim))
    silent execute "!curl -k -fLo " . s:plug_vim . ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

    "autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif

  if s:is_windows
      call plug#begin($VIM . '/plugins')
  else
      call plug#begin( '~/.vim/plugins')
  endif

  " Core
  if count(s:settings.plugin_groups, 'core') "{{{
    if !s:is_nvim
        Plug $VIM . '/plugins/vimproc'
    endif
    Plug 'bling/vim-airline'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-obsession'
    Plug 'dhruvasagar/vim-prosession'
  endif "}}}

  " Navigation
  if count(s:settings.plugin_groups, 'navigation') "{{{
    "Plug 'mileszs/ack.vim'
    Plug 'wincent/ferret'
    Plug 'scrooloose/nerdtree'
    Plug 'majutsushi/tagbar'
    Plug 'haya14busa/incsearch.vim'
    Plug 'dyng/ctrlsf.vim'
    Plug 'tacahiroy/ctrlp-funky'
    Plug 'FelikZ/ctrlp-py-matcher'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'vim-scripts/a.vim'
    Plug 'vim-scripts/QuickFixCurrentNumber'
  endif "}}}

  " Autocomplete
  if count(s:settings.plugin_groups, 'autocomplete') "{{{
    if s:is_nvim
        Plug 'Shougo/deoplete.nvim'
    endif
    if !s:is_nvim
        Plug 'Shougo/neocomplete.vim'
    endif
    Plug 'ervandew/supertab'
    Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips'
    Plug 'scrooloose/syntastic'
  endif "}}}

  if count(s:settings.plugin_groups, 'scm') "{{{
   Plug 'airblade/vim-gitgutter'
   Plug 'tpope/vim-fugitive'
   Plug 'low-ghost/nerdtree-fugitive'
   Plug 'Xuyuanp/nerdtree-git-plugin'
   Plug 'gregsexton/gitv'
  endif "}}}

  " Indents
  if count(s:settings.plugin_groups, 'indents') "{{{
    Plug 'Yggdroot/indentLine' "{{{
      let g:indentLine_char='┆'
      let g:indentLine_bufNameExclude = ['_.*', 'NERD_tree*']
    "}}}
    Plug 'arecarn/fold-cycle.vim'
    Plug 'tpope/vim-sleuth'
    Plug 'vim-scripts/DeleteTrailingWhitespace'
  endif "}}}

  " Erlang
  if count(s:settings.plugin_groups, 'erlang') "{{{
    Plug 'vim-erlang/vim-erlang-runtime',      { 'for': 'erlang'}
    Plug 'vim-erlang/vim-erlang-omnicomplete', { 'for': 'erlang'}
    Plug 'ten0s/syntaxerl',                    { 'for': 'erlang'}
    Plug 'fishcakez/vim-rebar'
    Plug 'calebsmith/vim-lambdify'
  endif "}}}

  " Sql
  if count(s:settings.plugin_groups, 'sql') "{{{
    if !s:is_nvim
        Plug 'talek/vorax4'
    endif
    Plug 'vim-scripts/dbext.vim'
  endif "}}}

  " Misc
  if count(s:settings.plugin_groups, 'misc') "{{{
    if !s:is_nvim
        Plug 'Shougo/vimshell.vim',  { 'on': ['VimShellExecute','VimShell', 'VimShellPop', 'VimShellInteractive'] }
        Plug 'lyokha/vim-xkbswitch'
        Plug 'tomtom/shymenu_vim'
    endif
    Plug 'zhaocai/GoldenView.Vim', { 'on': '<Plug>GoldenViewSplit' }
    Plug 'KabbAmine/zeavim.vim'
    Plug 'mhinz/vim-sayonara'
    Plug 'dbakker/vim-projectroot'
    Plug 'KabbAmine/zeavim.vim'
    if s:is_windows
        Plug 'kkoenig/wimproved.vim'
    endif
    Plug 'chrisbra/csv.vim'
    Plug 'vim-scripts/ingo-library'
    Plug 'MarcWeber/vim-addon-qf-layout'
  endif "}}}

  " Color schemes {{{
    Plug 'w0ng/vim-hybrid'
    Plug 'vim-scripts/wombat256.vim'
    Plug 'Wombat'
    Plug 'ShawnHuang/vim-airline-wombat256'
    Plug 'yasuoza/vim-airline-super-hybrid-theme'
    Plug 'daviesjamie/airline-hybrid-alt'
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'vim-erlang/vim-compot'
    Plug 'morhetz/gruvbox'
  "}}}

"}}}


" Autocmd {{{
    augroup general
        " Clear!
        au!

        autocmd GUIEnter * silent! WToggleClean

        au! BufRead,BufNewFile *.csv,*.dat	setf csv

        au BufEnter *.pkb.sql setf plsql
        au BufEnter *.pks.sql setf plsql
        au BufEnter *.pkb     setf plsql
        au BufEnter *.pks     setf plsql
        au BufEnter *.tps.sql setf plsql
        au BufEnter *.tpb.sql setf plsql
        au BufEnter *.typ.sql setf plsql

        autocmd FileType java set omnifunc=javacomplete#Complete

        au Filetype pom compiler mvn
        au Filetype pom no <C-F2> :make clean<CR>

        au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -
        au BufEnter * call <SID>AutoProjectRootCD()

        au BufEnter *.pk* :IndentLinesReset

        au BufEnter *.pkb.sql :IndentLinesReset
        au BufEnter *.pks.sql :IndentLinesReset
        au BufEnter *.pkb     :IndentLinesReset
        au BufEnter *.pks     :IndentLinesReset
        au BufEnter *.tps.sql :IndentLinesReset
        au BufEnter *.tpb.sql :IndentLinesReset
        au BufEnter *.typ.sql :IndentLinesReset

        "Jump to last cursor position when opening a file
        autocmd BufReadPost * call s:SetCursorPosition()

        autocmd FileType erlang map <buffer> <S-F10> :VimShellExecute --split='split \| resize 10' rebar compile<cr>
        autocmd FileType erlang map <buffer> <S-F11> :VimShellExecute --split='split \| resize 10' rebar eunit skip_deps=true<cr>

    augroup END
"}}}


" Finish loading {{{

  call plug#end()

  filetype plugin indent on
  syntax enable
  syntax sync minlines=200 " helps to avoid syntax highlighting bugs

  set background=dark
  exec 'colorscheme '.s:settings.colorscheme

"}}}


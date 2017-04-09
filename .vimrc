"=======プラグインマネージャーdeinの設定======

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

"deinの呼び出し
if dein#load_state(s:dein_dir)
  " プラグインリストを収めた TOML ファイル
  let s:toml      = '~/.dein.toml'
  let s:lazy_toml = '~/.dein_lazy.toml'

  call dein#begin(s:dein_dir, [$MYVIMRC,s:toml])

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールのプラグインがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on

"======deinの設定ここまで======

"======プラグイン固有の設定======"
":NERDTreeToggleをC-eにマッピング
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" C-rで最近編集したファイル一覧を表示
nnoremap <silent><C-r> :MRU<CR>

 " ccでコメントアウト(toggle)
nmap cc <Plug>(caw:hatpos:toggle)
vmap cc <Plug>(caw:hatpos:toggle)

" バッファ移動をリマッピング
nmap <C-n>        : MBEbn<CR>  
nmap <C-p>        : MBEbp<CR>  


"バッファクローズをリマッピング
nmap <C-d>	  : bd<CR>

"======プラグイン固有の設定ここまで======"

" tab で space 4 つ
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

" 文字コード
set encoding=utf-8
" 行番号を表示
set number
" 編集中のファイル名を常に表示(statuslineを常に表示)
set laststatus=2
" ステータスラインに文字コード
set statusline=%F%m%r%h%w%=\ %{fugitive#statusline()}\ [%{&ff}:%{&fileencoding}]\ [%l/%L]

"ステータスラインの色
highlight statusline   term=NONE cterm=NONE guifg=red ctermfg=white ctermbg=green
" シンタックスハイライト
syntax on
" 検索結果文字列のハイライトを有効にする
set hlsearch
"ターミナルで256色表示を使う
set t_Co=256
" コメントの色
highlight Comment ctermfg=blue
" 行の折り返し表示
set wrap
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
" 表示行移動と入れ替えgj gk <-j k
nnoremap k   gk
nnoremap j   gj
vnoremap k   gk
vnoremap j   gj
nnoremap gk  k
nnoremap gj  j
vnoremap gk  k
vnoremap gj  j 
" OSのクリップボードを使う(yankの内容をclipboardに保存する)
set clipboard+=unnamedplus,unnamed
" BSでなんでもけしちゃう
set backspace=indent,eol,start

" 素早く移動キーを入力することでInsertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> kk <ESC>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" O で空行を挿入(コメント無視)
nnoremap O :<C-u>call append(expand('.'), '')<Cr>

" 前回終了時のカーソル位置を復元する
if has("autocmd")
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
       \ endif
endif

" 終了時のセッションを保存
au VimLeave * mks!  ~/vimsession

"引数なし起動の時、前回のsessionを復元
autocmd VimEnter * nested if @% == '' && s:GetBufByte() == 0 | source ~/vimsession | endif
function! s:GetBufByte()
    let byte = line2byte(line('$') + 1)
        if byte == -1
            return 0
         else
            return byte - 1
         endif
endfunction


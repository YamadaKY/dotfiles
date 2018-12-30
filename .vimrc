"-----基本設定--------------------------
"ファイル読み込み時の文字コードの設定
set encoding=utf-8
"Vim Script内でマルチバイト文字を使う場合の設定
scriptencoding utf-8
"文字コードをUTF-8に設定
set fenc=utf-8
"保存時の文字コード
set fileencoding=utf-8
"読み込み時の文字コードの自動判別、左側が優先される
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
"改行コードの自動判別、左側が優先される
set fileformats=unix,dos,mac
"□　や○	が崩れないように表示
set ambiwidth=double
"バックアップファイルを作らない
set nobackup
"スワップファイルを作らない
set noswapfile
"編集中のファイルが変更されたら自動で読み直し
set autoread
"バッファが編集中でもその他のファイルを開けるように
set hidden
"入力中のコマンドをステータスに表示
set showcmd

"------見た目系---------------------------
"行番号を表示
set number
"現在の行を強調
set cursorline
" タブ文字の表示幅
set tabstop=2
" Vimが挿入するインデントの幅
set shiftwidth=2
" カッコの補完３種類
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
" htmlの閉じタグ補完
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END
" 検索結果をハイライト
set hlsearch
" 検索結果ハイライトを挿入モード時に無効
" ノーマルモード時に有効に戻す
autocmd InsertEnter * set nohlsearch
autocmd InsertLeave * set hlsearch
"ハイライトを消す
noremap <silent> <C-l> : <C-u>nohlsearch<CR><C-l>

"-----クリップボード・コピペ-----------------
" ビジュアルモードで選択したテキストが、クリップボードに入るようにする。
" キー操作は 『" + y 』と順に入力『+』も入力する
set clipboard+=autoselect
"ヤンク、カットしたテキストを、 他のアプリケーションで即ペーストできる
set clipboard+=unnamed

"-----プラグイン管理------------------------
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/jordi/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/jordi/.cache/dein')
  call dein#begin('/home/jordi/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/jordi/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " call dein#add('Shougo/neocomplete.vim')
	" 自動補完
	call dein#add('Shougo/deoplete.nvim')
		if !has('nvim')
			call dein#add('roxma/nvim-yarp')
			call dein#add('roxma/vim-hug-neovim-rpc')
		endif
	let g:deoplete#enable_at_startup = 1
	" vimprocのインストール
	call dein#add('Shougo/vimproc.vim' ,{
        \ 'build': {
        \     'mac': 'make -f make_mac.mak',
        \     'linux': 'make',
        \     'unix': 'gmake',
        \    },
        \ })
	" コメント挿入と解除をラクに(crt-shift + _)
  call dein#add('tomtom/tcomment_vim')
	" インデントの深さ表示
  call dein#add('nathanaelkane/vim-indent-guides')
	" カッコの補完	
  call dein#add('cohama/lexima.vim')
	"JavaScript用シンタックスハイライト
  call dein#add('pangloss/vim-javascript')
	" JSONファイル形式を読みやすく
  call dein#add('elzr/vim-json')
	" HTMLを瞬時に作成
  call dein#add('mattn/emmet-vim')
  "call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


"----プラグインの必要設定項目-----
"----------------------------------
" neocomplete・neosnippetの設定項目
"----------------------------------
" Vim起動時にneocompleteを有効にする
let g:neocomplete#enable_at_startup = 1
" smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" 3文字以上の単語に対して補完を有効にする
let g:neocomplete#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1
" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"
" エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
" タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
"
"----------------------------------
" vimIndentGuidesの設定項目
"----------------------------------
" vimを立ち上げてすぐ有効に
let g:indent_guides_enable_on_vim_startup = 1
" 可視化の階層を2列目から開始
let g:indent_guides_start_level = 2
" 色の設定
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=white
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey
" 無視するファイル形式
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']

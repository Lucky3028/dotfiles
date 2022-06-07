" ビープ音を鳴らさない
set belloff=all
" クリップボード連携を有効に
set clipboard=unnamedplus
" 改行時にインデントを揃える
set autoindent

" 検索
" インクリメントサーチ
set incsearch
" 検索語をハイライト表示
set hlsearch

" 外観
" 行番号を表示
set number
" 複数Vimを開いているときだけファイル名を表示
set laststatus=1
" シンタックスをカラー表示
syntax on
" 行・字の位置を表示
set ruler
" 対応する括弧を強調表示
set showmatch
" 現在行を強調表示
set cursorline
" カーソルが行末より後ろに行く
set virtualedit=onemore
" コマンドの自動補完
set wildmode=list:longest
" 折返し文字列を行単位で移動
nnoremap j gj
nnoremap k gk
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" マウスのホイールスクロールを有効化
set mouse=a
set ttymouse=xterm2

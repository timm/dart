#!/usr/bin/env bash
# vim:ft=sh ts=4:

#### CONFIGURATION ###############

Needs="lua awk bash"
Tmux=$(which tmux)

#### end config ##################

for c in $Needs; do
  if [ -z `which $c` ]; then
     >&2 echo "# W: please install $c"
  fi
done

hello() {
  clear
  tput bold; tput setaf 32; cat <<-'EOF'
                                        _____   
              Dart v1                  /\ _ /\  
 github.com/timm/dart      >>>----    / /\ /\ \
        timm@ieee.org    >>>----     |---(*)---| 
             (c) 2020                 \ \/_\/ / 
          MIT license         >>>----  \/___\/

EOF
  tput sgr0
  tput bold; tput setaf 0
  awk '/^alias/ {print $0}'   $Dir/$Sh
  tput sgr0
}

Dir=$(cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
Sh=$(basename ${BASH_SOURCE[0]})
Src=$(basename $Sh).lua 

alias bye="$Tmux kill-session"                  # exit
alias dart="lua $Dir/$Src "                     # run code
alias ga='git add *'                            # add to local repo
alias gg='git pull'                             # update code from web
alias gp='ga;git commit -am saving;git push;gs' # end-of-day actions
alias gs='git status'                           # status 
alias ls='ls -G'                                # ls
alias ok="dart -U "                             # run a unit test
alias oks="dart -U all"                         # run all unit tests
alias okspy="rerun 'lua dart.lua -U all'"       # run tests when files change
alias readme="lua2md $Dir/$Src>$Dir/README.md"  # rebuild README.md
alias reload='. $Dir/$Sh'                       # reload these tools
alias tmux=mytmux                               # 2-pane tmux environment
alias vims="vim +PluginInstall +qall"           # install vim plugins 

color() { awk '
/FAIL/ {print "\033[31m" $0 "\033[0m";next}
/PASS/ {print "\033[32m" $0 "\033[0m";next}
       {print}'
}
here() { cd $1; basename `pwd`; }    
PROMPT_COMMAND='echo -ne "🎯 $(git branch 2>/dev/null | grep '^*' | colrm 1 2):";PS1="$(here ..)/$(here .):\!\e[m ▶ "'     

lua2md() {
F=/tmp/$$
 cat $1 | awk  '
BEGIN {while(!sub(/^\]\].*/,"")) { getline }; 
       print "\n\n"
       print"```lua"} 
sub(/^-- /,"")    {print"```" 
                   do {print; getline} while (sub(/^-- /,"")) 
                   print "```lua"}
sub(/^--\[\[[ \t]*/,"")  { print"```"
                     while (! sub(/^--\]\][ \t]*/,"") ) {
                        print
                       getline} 
                      
                     print "```lua"
                    }
                  
                   {print}
                   
END {print "```\n"}
'  > ${F}2code
  [ -f "$Dir/etc/header.md" ] && (cat $Dir/etc/header.md > ${F}1head)
  lua $Dir/$Src -H >> ${F}1head
  cat  ${F}2code | toc > ${F}2toc
  cat ${F}1head ${F}2toc ${F}2code 
}
toc() {  awk '
function ns(n,    s) {
   while(n-- > 0) s= s "    "
   return s
}
function trim(s) {
  gsub(/^[ \t]*/,"",s)
  gsub(/[ \t]*$/,"",s)
  return s
}
/^#[#]*[ \t]/ { 
     new = split($1,a,"#") - 2
     s = $0
     gsub(/^[#]+[ \t]*/,"",s) #asada() : asdadsa
     s = trim(s)
     link = s
     gsub(/[^a-zA-Z0-9\- ]/,"",link)
     gsub(/[ \t]/,"-",link)
     split(s,a,/[ \t]*:[ \t]/)
     a[1] = trim( a[1] )
     a[2] = trim( a[2] )
     if (length(a) == 1 || ! a[2] )
          print ns(new) "- [" s    "](#" tolower(link) ") " 
     else print ns(new) "- [" a[1] "](#" tolower(link) ") : " a[2] 
}
END {print ""}'
}
tests() {
  local LAST=`ls -l "$Dir/$Src"`
  echo "Control-C to exit "
  lua $Dir/$Src -U all
  while true; do
    sleep 1
    local NEW=`ls -l "$Dir/$Src"`
    if [ "$NEW" != "$LAST" ]; then 
      lua $Dir/$Src -U all
      LAST="$NEW"
    fi
  done
}
mytmux() {
  session=$RANDOM
  $Tmux start-server
  sleep 1
  $Tmux new-session -d -s $session  
  $Tmux send-keys ". $Dir/$Sh"  C-m  "sleep 1; vi dart.lua" C-m

  $Tmux splitw -h -p 30
  $Tmux selectp -t 1
  $Tmux send-keys ".  $Dir/$Sh"  C-m  "clear; hello" C-m

  $Tmux splitw -v  -p 10
  $Tmux selectp -t 2
  $Tmux send-keys ".  $Dir/$Sh"  C-m  "htop"  C-m

  $Tmux attach-session -t $session
}

want=$HOME/.config/htop/htoprc
mkdir -p $(dirname $want)
[ -f "$want" ] || cat<<-'EOF'>$want
	# Beware! This file is rewritten by htop when settings are changed in the interface.
	# The parser is also very primitive, and not human-friendly.
	fields=0 48 17 18 38 39 2 46 47 49 1
	sort_key=46
	sort_direction=1
	hide_threads=0
	hide_kernel_threads=1
	hide_userland_threads=0
	shadow_other_users=0
	show_thread_names=0
	show_program_path=1
	highlight_base_name=0
	highlight_megabytes=1
	highlight_threads=1
	tree_view=0
	header_margin=1
	detailed_cpu_time=0
	cpu_count_from_zero=0
	update_process_names=0
	account_guest_in_cpu_meter=0
	color_scheme=0
	delay=15
	left_meters=AllCPUs Memory
	left_meter_modes=1 1
	right_meters=Clock Memory Swap
	right_meter_modes=4 1 1
EOF
	 
want=$Dir/.travis.yml
[ -f "$want" ] || cat<<-'EOF'>$want
	language: C
	
	sudo: true
	
	install:
	  - curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
	  - tar zxf lua-5.3.5.tar.gz
	  - cd lua-5.3.5
	  - make linux test
	
	script:
	  - pwd
	  - lua dart.lua -U all
EOF
	 
want=$HOME/.vimrc
[ -f "$want" ] || cat<<-'EOF'>$want
	set list
	set listchars=tab:>-
	set backupdir-=.
	set backupdir^=~/tmp,/tmp
	set nocompatible
	"filetype plugin indent on
	set modelines=3
	set scrolloff=3
	set autoindent
	set hidden "remember ls
	set wildmenu
	set wildmode=list:longest
	set visualbell
	set ttyfast
	set backspace=indent,eol,start
	set laststatus=2
	set splitbelow
	set paste
	set mouse=a
	set title
	set number
	set relativenumber
	autocmd BufEnter * cd %:p:h
	set showmatch
	set matchtime=15
	set background=light
	set syntax=on
	syntax enable
	set ignorecase
	set incsearch
	set smartcase
	set showmatch
	set hlsearch
	set nofoldenable    " disable folding
	set ruler
	set laststatus=2
	set statusline=
	set statusline+=%F
	set statusline+=\ 
	set statusline+=%m
	set statusline+=%=
	set statusline+=%y
	set statusline+=\ 
	set statusline+=%c
	set statusline+=:
	set statusline+=%l
	set statusline+=\ 
	set lispwords+=until
	set path+=../**
	if has("mouse_sgr")
	    set ttymouse=sgr
	else
	    set ttymouse=xterm2
	end
	colorscheme default
	set termguicolors
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	map Z 1z=
	set spell spelllang=en_us
	set spellsuggest=fast,20 "Don't show too much suggestion for spell check
	nn <F7> :setlocal spell! spell?<CR>
	let g:vim_markdown_fenced_languages = ['awk=awk']
	set nocompatible              " be iMproved, required
	filetype off                  " required
	
	" set the runtime path to include Vundle and initialize
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')
	
	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'tpope/vim-fugitive'
	Plugin 'scrooloose/nerdtree'
	Plugin 'tbastos/vim-lua'
	Plugin 'airblade/vim-gitgutter'
	"Plugin 'itchyny/lightline.vim'
	Plugin 'junegunn/fzf'
	"  Plugin 'humiaozuzu/tabbar'
	"  Plugin 'drmingdrmer/vim-tabbar'
	Plugin 'tomtom/tcomment_vim'
	Plugin 'ap/vim-buftabline'
	Plugin 'junegunn/fzf.vim'
	Plugin 'jnurmine/Zenburn'
	Plugin 'altercation/vim-colors-solarized'
	Plugin 'nvie/vim-flake8'
	Plugin 'seebi/dircolors-solarized'
	Plugin 'nequo/vim-allomancer'
	Plugin 'nanotech/jellybeans.vim'
	Plugin 'tell-k/vim-autopep8'
	Plugin 'vimwiki/vimwiki'
	Plugin 'kchmck/vim-coffee-script'
	Plugin 'tpope/vim-markdown'
	" All of your Plugins must be added before the following line
	call vundle#end()            " required
	filetype plugin indent on    " required
	" To ignore plugin indent changes, instead use:
	"filetype plugin on
	let g:autopep8_indent_size=2
	let g:autopep8_max_line_length=70
	let g:autopep8_on_save = 1
	let g:autopep8_disable_show_diff=1
	autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
	colorscheme jellybeans
	map <C-o> :NERDTreeToggle<CR>
	nnoremap <Leader><space> :noh<cr>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
	set titlestring=%{expand(\"%:p:h\")}
	hi Normal guibg=NONE ctermbg=NONE
	hi NonText guibg=NONE ctermbg=NONE
	set fillchars=vert:\|
	hi VertSplit cterm=NONE
	set ts=2
	set sw=2
	set sts=2
	set et
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
	set hidden
	nnoremap <C-N> :bnext<CR>
	nnoremap <C-P> :bprev<CR>
	set formatoptions-=t
	set nowrap
	" Markdown
	let g:markdown_fenced_languages = ['lua','awk','py=python']
EOF

want=$Dir/.gitignore
[ -f "$want" ] || cat<<-'EOF'>$want
	# Swap
	[._]*.s[a-v][a-z]
	!*.svg  # comment out if you don't need vector files
	[._]*.sw[a-p]
	[._]s[a-rt-v][a-z]
	[._]ss[a-gi-z]
	[._]sw[a-p]
	
	# Session
	Session.vim
	Sessionx.vim
	
	# Temporary
	.netrwhist
	*~
	# Auto-generated tag files
	tags
	# Persistent undo
	[._]*.un~
	
	### Macos ###
	
	# General
	.DS_Store
	.AppleDouble
	.LSOverride
	
	# Icon must end with two \r
	Icon
	
	# Thumbnails
	._*
	
	# Files that might appear in the root of a volume
	.DocumentRevisions-V100
	.fseventsd
	.Spotlight-V100
	.TemporaryItems
	.Trashes
	.VolumeIcon.icns
	.com.apple.timemachine.donotpresent
	
	# Directories potentially created on remote AFP share
	.AppleDB
	.AppleDesktop
	Network Trash Folder
	Temporary Items
	.apdisk
EOF
	
want=$HOME/.tmux.conf
[ -f "$want" ] ||  cat<<-'EOF'> $want
	set -g aggressive-resize on
	unbind C-b
	set -g prefix C-Space
	bind C-Space send-prefix
	set -g base-index 1
	# start with pane 1
	bind | split-window -h -c "#{pane_current_path}"
	bind - split-window -v -c "#{pane_current_path}"
	unbind '"'
	unbind %
	# open new windows in the current path
	bind c new-window -c "#{pane_current_path}"
	# reload config file
	bind r source-file $Tnix/.config/dottmux
	unbind p
	bind p previous-window
	# shorten command delay
	set -sg escape-time 1
	# don't rename windows automatically
	set-option -g allow-rename off
	# mouse control (clickable windows, panes, resizable panes)
	set -g mouse on
	# Use Alt-arrow keys without prefix key to switch panes
	bind -n M-Left select-pane -L
	bind -n M-Right select-pane -R
	bind -n M-Up select-pane -U
	bind -n M-Down select-pane -D
	# enable vi mode keys
	set-window-option -g mode-keys vi
	# set default terminal mode to 256 colors
	set -g default-terminal "screen-256color"
	bind-key u capture-pane \;\
	    save-buffer /tmp/tmux-buffer \;\
	    split-window -l 10 "urlview /tmp/tmux-buffer"
	bind P paste-buffer
	bind-key -T copy-mode-vi v send-keys -X begin-selection
	bind-key -T copy-mode-vi y send-keys -X copy-selection
	bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
	# loud or quiet?
	set-option -g visual-activity off
	set-option -g visual-bell off
	set-option -g visual-silence off
	set-window-option -g monitor-activity off
	set-option -g bell-action none
	#  modes
	setw -g clock-mode-colour colour5
	# panes
	# statusbar
	set -g status-position top
	set -g status-justify left
	set -g status-bg colour232
	set -g status-fg colour137
	###set -g status-attr dim
	set -g status-left ''
	set -g status-right '#{?window_zoomed_flag,🔍,} #[fg=colour255,bold]#H #[fg=colour255,bg=colour19,bold] %b %d #[fg=colour255,bg=colour8,bold] %H:%M '
	set -g status-right '#{?window_zoomed_flag,🔍,} #[fg=colour255,bold]#H %H:%M '
	set -g status-right-length 50
	set -g status-left-length 20
	setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '
	setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '
	# messages
	# layouts
	bind S source-file $Tnix/.config/tmux-session1
	setw -g monitor-activity on
	set -g visual-activity on
EOF

if [ ! -d "$HOME/.vim/bundle" ]; then
   git clone https://github.com/VundleVim/Vundle.vim.git \
         ~/.vim/bundle/Vundle.vim
   vims
fi

[ -z "$TMUX" ] && mytmux

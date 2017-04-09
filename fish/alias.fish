# alias
alias rm='rm -i'
alias vi='vim'
alias ll='ls -alF'
alias la='ls -A'
alias tree="find . | grep -v ".git" |sort|sed -ne'1b;s/[^\/]*\//+--/g;s/+--+/| +/g;s/+--+/| +/g;s/+--|/| |/g;p'"
alias ffind='find ./ -name'
alias hist='peco_select_history'
alias gs='git status'
alias gd='git diff .'


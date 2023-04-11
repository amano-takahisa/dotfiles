# Aliases

# use neovim instead of vim
alias vimvim='/usr/bin/vim.tiny'
alias vim='/home/takahisa/bin/nvim'


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -ahlFv --time-style=long-iso --group-directories-first'
alias llt='ls -ahlFrt --time-style=long-iso'
alias la='ls -A'
alias l='ls -CF'

# tree with ignore some patterns
alias treee="tree -ahv --dirsfirst  --du -I '.git|__pycache__|.mypy_cache|.eggs|*.egg-info|.virtual_documents'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# clipboard to system too
# https://gist.github.com/Brainiarc7/f5eb9a91973b62a0f71b4c4c6fbb9e03
alias ccc='xclip -sel clip'

# rm comfirmation prompt by default
alias rm='rm -I'

# auto pwd ls after cd
function cdd() {
     cd "$1" && pwd && ls -aFv --group-directories-first ;
}
export -f cdd

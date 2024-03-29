#!/usr/bin/zsh

# some more ls aliases
alias ll='ls -ahlFv --time-style=long-iso --group-directories-first'
alias llt='ls -ahlFrt --time-style=long-iso'
alias la='ls -A'
alias l='ls -CF'

# tree with ignore some patterns
alias treee="tree -ahv --dirsfirst  --du \
    -I '.git|__pycache__|.mypy_cache|.eggs|*.egg-info|.virtual_documents|venv'"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# rm comfirmation prompt by default
alias rm='rm -I'

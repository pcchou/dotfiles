# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#export HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=2000000
HISTCONTROL=erasedups
export PROMPT_COMMAND="\history -a; \history -c; \history -r; $PROMPT_COMMAND"


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

prompt() {
  powerline_status=''
  if [[ $EUID -eq 0 ]]; then
    PS1='\[\e[0;31m\]$(whoami)\[\e[m\]: \[\e[00;38;5;244m\]\w\[\e[m\]\[\e[0;36m\]$(parse_git_branch)\[\e[m\] $ '
  else
    if [[ -n "$SSH_CLIENT" ]]; then
      PS1='\[\e[1;32m\]$(whoami)@$(hostname -s)\[\e[m\]: \[\e[00;38;5;244m\]\w\[\e[m\]\[\e[0;36m\]$(parse_git_branch)\[\e[m\] $ '
    else
      PS1='\[\e[0;36m\]$(whoami)\[\e[m\]: \[\e[00;38;5;244m\]\w\[\e[m\]\[\e[0;36m\]$(parse_git_branch)\[\e[m\] $ '
    fi
  fi
  alias _powerline_set_prompt="#"
  alias _powerline_tmux_set_pwd="#"
}

TERM=xterm-256color

if [[ ( -n "$toggle_powerline" && -a $HOME/.npl ) || ( -z "$toggle_powerline" && ! -a $HOME/.npl ) ]] ; then
  if python -c "import powerline" 2>/dev/null; then
    powerline_status="true"
    . $(python -c "import os, powerline; print(os.path.dirname(powerline.__file__))")/bindings/bash/powerline.sh
  else
    prompt
  fi
else
  prompt
fi


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"

# enable color support of ls and also add handy aliases
if which dircolors >/dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.environment ]; then
    source ~/.environment
fi

if [ -f ~/.localenv ]; then
    source ~/.localenv
fi

if [ -f ~/.others ]; then
    source ~/.others
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\el": "ls\n"'
#bind 'TAB: menu-complete'

export NVM_DIR="/home/pcchou/.nvm"
[ -s "$NVM_DIR/nvm.sh"  ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# alias
alias lslisten="sudo lsof -i -P | grep LISTEN | grep :$PORT"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pcchou/opt/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pcchou/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pcchou/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pcchou/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ -d ~/.cargo ]; then
    . "$HOME/.cargo/env"
fi

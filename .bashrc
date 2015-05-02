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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    export PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/scripts" ] ; then
    export PATH="$PATH:$HOME/scripts"
fi

if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# Go
if [ -d "$HOME/Go" ]; then
    export GOPATH=$HOME/Go
fi
if [ -d "$GOPATH/bin" ] || [ -d "$GOROOT/bin" ]; then
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"

# enable color support of ls and also add handy aliases
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.aliases ]; then
    source ~/.aliases
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


# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

nplprompt() {
  if [ -n "$SSH_CLIENT" ]; then
    PS1='\[\e[0;33m\]\u@\h\[\e[m\]: \[\e[1;34m\]\w\[\e[m\]\[\e[1;36m\]$(parse_git_branch)\[\e[m\] $ '
  else
    PS1='\[\e[0;33m\]\u\[\e[m\]: \[\e[1;34m\]\w\[\e[m\]\[\e[1;36m\]$(parse_git_branch)\[\e[m\] $ '
  fi
  alias _powerline_set_prompt='#'
  alias _powerline_tmux_set_pwd='#'
}

TERM=xterm-256color

if ! [ -n "$npl" ]; then
  if [ -f ~/.local/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source ~/.local/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh
  else
    nplprompt
  fi
else
  nplprompt
fi

# GitHub Hub
hub >/dev/null 2>&1 && hub-completion && eval "$(hub alias -s)"

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind 'TAB: menu-complete'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

PATH=`perl -e '@A=split(/:/,$ENV{PATH});%H=map {$A[$#A-$_]=>$#A-$_} (0..$#A);@A=join(":",sort{$H{$a} <=> $H{$b} }keys %H);print "@A"'`
export PATH

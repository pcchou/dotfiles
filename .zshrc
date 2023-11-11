export TERM="xterm-256color"
autoload -U colors && colors
setopt prompt_subst

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt INC_APPEND_HISTORY_TIME

# zsh completion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# bash incremental search
bindkey -e
# disable r
disable r

# Keybinds
bindkey "^[b" backward-word
bindkey "^[f" forward-word
bindkey "^j" down-line-or-history
bindkey "^K" up-line-or-history
bindkey "^[[5~" beginning-of-buffer-or-history
bindkey "^[[6~" end-of-buffer-or-history
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '[A' up-line-or-beginning-search
bindkey '[B' down-line-or-beginning-search
bindkey '[C' forward-word
bindkey '[D' backward-word

# Prevent "no matches found"
unsetopt nomatch

alias vim="/opt/local/bin/vim"
export EDITOR="/opt/local/bin/vim"
alias curlw='curl -w "\n"'
alias git='LANG=en_GB /opt/local/bin/git'
alias combinepdf='"/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py" '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# bash-completion
if [ -f /opt/local/etc/profile.d/bash_completion.sh  ]; then
  . /opt/local/etc/profile.d/bash_completion.sh
fi

#export CFLAGS="-D_DARWIN_C_SOURCE -I/opt/local/include -L/opt/local/lib -lreadline"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/pcchou/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pcchou/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/pcchou/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pcchou/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
  # Init pyenv-virtualenv, but
  # unload precmd hook _pyenv_virtualenv_hook
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# Warning: unloading the following hook breaks command
# `pyenv activate/deactivate`. Please switch to
# `pyenv shell env_name`, `pyenv shell --unset` instead.
if [[ -n $ZSH_VERSION ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook -D precmd _pyenv_virtualenv_hook
fi
if [[ -n $BASH_VERSION ]]; then
  PROMPT_COMMAND="${PROMPT_COMMAND/_pyenv_virtualenv_hook;/}"
fi



export PATH="/Users/pcchou/.local/bin:$PATH"

function swap()
{
  tmpfile=$(mktemp $(dirname "$1")/XXXXXX)
  mv "$1" "$tmpfile" && mv "$2" "$1" &&  mv "$tmpfile" "$2"
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/pcchou/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/pcchou/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/pcchou/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/pcchou/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# Load version control information
autoload -Uz vcs_info
# Enabling and setting git info var to be used in prompt config.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
# This line obtains information from the vcs.
zstyle ':vcs_info:git*' formats "(%b) "
precmd() { vcs_info }

prompt() {
  powerline_status=""

  ZSH_THEME_GIT_PROMPT_PREFIX="[ "
  ZSH_THEME_GIT_PROMPT_SUFFIX="]"
  ZSH_THEME_GIT_PROMPT_SEPARATOR=" |"
  ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
  ZSH_THEME_GIT_PROMPT_STAGED=" %{$fg[red]%}%{●%G%} "
  ZSH_THEME_GIT_PROMPT_CONFLICTS=" %{$fg[red]%}%{✖%G%} "
  ZSH_THEME_GIT_PROMPT_CHANGED=" %{$fg[blue]%}%{✚%G%} "
  ZSH_THEME_GIT_PROMPT_BEHIND=" %{↓%G%} "
  ZSH_THEME_GIT_PROMPT_AHEAD=" %{↑%G%} "
  ZSH_THEME_GIT_PROMPT_UNTRACKED=" %{…%G%} "
  ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg_bold[green]%}%{✔%G%} "

  if [[ "$EUID" -eq 0 ]]; then
    PS1='%{$fg[red]%}!!!$USER!!!@$HOST%{$reset_color%}: %{[00;38;5;244m%}${PWD/$HOME/~}%{$reset_color%} $ '
  else
    if [[ -n "$SSH_CLIENT" ]]; then
      PS1='%{$fg_bold[green]%}$USER@$HOST%{$reset_color%}: %{[00;38;5;244m%}${PWD/$HOME/~}%{$reset_color%} $ '
    else
      PS1='%{$fg[cyan]%}$USER%{$reset_color%}: %{[00;38;5;244m%}${PWD/$HOME/~}%{$reset_color%} $ '
    fi
  fi

  RPS1='%{$fg_bold[cyan]%}${vcs_info_msg_0_}%{$reset_color%}'
  RPS1=$'%{\e]0;${PWD/$HOME/~}\a%}'$RPS1


}

prompt

# kill word
WORDCHARS=${WORDCHARS/\//-}
WORDCHARS=${WORDCHARS/-}
WORDCHARS=${WORDCHARS/-}
WORDCHARS=${WORDCHARS/=}
WORDCHARS=${WORDCHARS/.}
WORDCHARS=${WORDCHARS/.}
bindkey '^[^?' backward-kill-word

sprunge() {
  if [[ $1  ]]; then
    curl -F 'sprunge=<-' "http://sprunge.us" <"$1"
  else
    curl -F 'sprunge=<-' "http://sprunge.us"
  fi
}

export PATH="/opt/local/libexec/gnubin/:$PATH"

# enable color support of ls and also add handy aliases
#source ~/.zsh/zsh-dircolors-solarized/zsh-dircolors-solarized.zsh
#test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if command -v dircolors >/dev/null 2>&1 && [[ -d $HOME/.zsh/dircolors-solarized ]]; then
  eval `dircolors $HOME/.zsh/dircolors-solarized/dircolors.256dark`
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

# alias
alias lslisten="sudo lsof -i -P | grep LISTEN | grep :$PORT"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

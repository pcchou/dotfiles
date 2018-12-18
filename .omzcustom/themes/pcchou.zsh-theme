# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

TERM=xterm-256color

# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

eval `dircolors $HOME/.omzcustom/gitrepo/dircolors-solarized/dircolors.256dark`

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
    PS1='%{$fg[red]%}!!!$(whoami)!!!@$(hostname -s)%{$reset_color%}: %{[00;38;5;244m%}${PWD/$HOME/~}%{$reset_color%} $ '
    RPS1='$(git_super_status)'
  else
    if [[ -n "$SSH_CLIENT" ]]; then
      PS1='%{$fg_bold[green]%}$(whoami)@$(hostname -s)%{$reset_color%}: %{[00;38;5;244m%}${PWD/$HOME/~}%{$reset_color%} $ '
      RPS1='$(git_super_status)'
    else
      PS1='%{$fg[cyan]%}$(whoami)%{$reset_color%}: %{[00;38;5;244m%}${PWD/$HOME/~}%{$reset_color%} $ '
      RPS1='$(git_super_status)'
    fi
  fi
}

if [[ ( -n "$toggle_powerline" && -a $HOME/.npl ) || ( -z "$toggle_powerline" && ! -a $HOME/.npl ) ]] ; then
  if python -c "import powerline" 2>/dev/null; then
    powerline_status="true"
    . $(python -c "import os, powerline; print(os.path.dirname(powerline.__file__))")/bindings/zsh/powerline.zsh
  else
    prompt
  fi
else
  prompt
fi

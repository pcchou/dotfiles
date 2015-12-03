# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

TERM=xterm-256color

# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

source "$HOME/.omzcustom/gitrepo/zsh-git-prompt/zshrc.sh"

eval `dircolors $HOME/.omzcustom/gitrepo/dircolors-solarized/dircolors.256dark`

prompt() {
  powerline_status=""
  if [[ "$EUID" -eq 0 ]]; then
    PS1='%{$fg[red]%}!!!$(whoami)!!!@$(hostname -s)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
    RPS1='$(git_super_status)'
  else
    if [[ -n "$SSH_CLIENT" ]]; then
      PS1='%{$fg[yellow]%}$(whoami)@$(hostname -s)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
      RPS1='$(git_super_status)'
    else
      PS1='%{$fg[cyan]%}$(whoami)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
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

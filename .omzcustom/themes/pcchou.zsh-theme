# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

TERM=xterm-256color

# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

source "$HOME/.omzcustom/gitrepo/zsh-git-prompt/zshrc.sh"

eval `dircolors $HOME/.omzcustom/gitrepo/dircolors-solarized/dircolors.256dark`

#powerline
nplprompt() {
  if [ -n "$SSH_CLIENT" ]; then
    PS1='%{$fg[yellow]%}$(whoami)@$(hostname)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
    RPS1='$(git_super_status)'
  else
    PS1='%{$fg[yellow]%}$(whoami)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
    RPS1='$(git_super_status)'
  fi
}

if ! [ -n "$npl" ]; then
  if [ -f /usr/local/lib/python3.4/dist-packages/powerline/bindings/zsh/powerline.zsh ]; then
    . /usr/local/lib/python3.4/dist-packages/powerline/bindings/zsh/powerline.zsh
    #if [[ -n "$(git_super_status)" ]]; then
    #  RPS1='$(parse_git_branch)'
    #else
    #  RPS1=''
    #fi
  else
    nplprompt
  fi
else
  nplprompt
fi

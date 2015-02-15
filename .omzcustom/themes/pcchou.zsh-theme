# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

TERM=xterm-256color

# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

eval `dircolors /home/pcchou/.omzcustom/themes/dircolors-solarized/dircolors.256dark`

#powerline
nplprompt() {
  if [ -n "$SSH_CLIENT" ]; then
    PS1='%{$fg[yellow]%}$(whoami)@$(hostname)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
    RPS1='%{$fg[cyan]%}$(parse_git_branch)%{$reset_color%}'
  else
    PS1='%{$fg[yellow]%}$(whoami)%{$reset_color%}: %{$fg[blue]%}${PWD/$HOME/~}%{$reset_color%} $ '
    RPS1='%{$fg[cyan]%}$(parse_git_branch)%{$reset_color%}'
  fi
}

if ! [ -n "$npl" ]; then
  if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
    . ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
  else
    nplprompt
  fi
else
  nplprompt
fi

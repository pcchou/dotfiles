# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

#powerline
nplprompt() {
  if [ -n "$SSH_CLIENT" ]; then
    #PS1='\[\e[0;33m\]\u@\h\[\e[m\]: \[\e[1;34m\]\w\[\e[m\]\[\e[1;36m\]$(parse_git_branch)\[\e[m\] $ '
  else
    #PS1='\[\e[0;33m\]\u\[\e[m\]: \[\e[1;34m\]\w\[\e[m\]\[\e[1;36m\]$(parse_git_branch)\[\e[m\] $ '
  fi
}

TERM=xterm-256color

if ! [ -n "$npl" ]; then
  if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
    . ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
  else
    nplprompt
  fi
else
  nplprompt
fi

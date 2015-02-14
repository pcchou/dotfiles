# Add your own custom plugins in the custom/plugins directory. Plugins placed
# here will override ones with the same name in the main plugins directory.

TERM=xterm-256color

# show git branch
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

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

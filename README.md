My dotfiles.
============

Included:
* `.local/bin` utilities
  * `seadogbot`, a script written by me, licensed under the MIT License.
    * `seadogbot` used a public domain code [SHIC](http://github.com/halhen/shic).
  * `waittillup`, a script improved from [an answer on ServerFault](http://serverfault.com/a/545408)
  * `sortpics`, a script improved by me, originally by [Mike Beach](http://mikebeach.org/?p=4729).
  * Others are tools downloaded from the internet
    * `imgur`, a tool by [Simon Eskildsen](http://sirupsen.com/a-simple-imgur-bash-screenshot-utility/)
    * `git update-all`, a tool by michael_n, in [a answer on StackOverflow](http://stackoverflow.com/a/17180894/4537037)
    * `git-cal`, a tool by @k4rthik, in [k4rthik/git-cal](https://github.com/k4rthik/git-cal)
* shell environment configurations
  * `.zshrc`, `.zshenv`, `.omzcustom`, `.oh-my-zsh` (using [robbyrussell/oh-my-zsh](robbyrussell/oh-my-zsh/))
  * `.bashrc`, `.bash_profile`
  * `.inputrc`, `.profile`
  * `.aliases` (all of my universal aliases)
* utilities configurations
  * `.screerc`
  * `.gitconfig`
  * (`.tmux`, `.vim`, and `.config/powerline` are in separate repositories)
    * [pcchou/.tmux](https://github.com/pcchou/.tmux)
    * [pcchou/.vim](https://github.com/pcchou/.vim)
    * [pcchou/powerline-config](https://github.com/pcchou/powerline-config)
* addons
  * `.pyenv`
* miscellaneous files
  * `.tmuxresurrect` to keep my tmux workspace (used by tmux-resurrect), it's symlinked to `~/.tmux/resurrect/`.
  * `.pcc` to keep some config files which will change depending on the environment.
    * rename `.example` files, in order for them to work
    * current list of files
      * `gituser`, is `.gitconfig` format, used to keep Git user settings.

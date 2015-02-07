# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

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

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

PATH=`perl -e '@A=split(/:/,$ENV{PATH});%H=map {$A[$#A-$_]=>$#A-$_} (0..$#A);@A=join(":",sort{$H{$a} <=> $H{$b} }keys %H);print "@A"'`
export PATH

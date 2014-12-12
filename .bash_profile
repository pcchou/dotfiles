# ??????????????


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
if [ -d "$GOPATH/bin" || -d "$GOROOT/bin" ]; then
    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
. "$HOME/.bashrc"
fi

PATH=`perl -e '@A=split(/:/,$ENV{PATH});%H=map {$A[$#A-$_]=>$#A-$_} (0..$#A);@A=join(":",sort{$H{$a} <=> $H{$b} }keys %H);print "@A"'`
export PATH

# Ghislain's .bashrc

set -o emacs

if [[ x$TERM = xdumb ]] ; then
    export PS1="\W $"
else
    if [[ ${EUID} == 0 ]] ; then
	export PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
    else
	export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
    fi
fi

alias ls='ls --color'
alias vi='vim'
alias bashrc='vi ~/.bashrc ; source ~/.bashrc'

if [ -e ~/.local_bashrc ]
then
	source ~/.local_bashrc
fi

function su() {
	if [ $# -eq 0 ]
	then
		`which su` root -c "bash --rcfile ${HOME}/.bashrc"
	else
		`which su` "$@"
	fi
}

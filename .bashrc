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

hostname=`hostname`

alias vi='vim'
alias servers='vi ~/.servers'
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

function s() {
	name=`grep "$2:" ~/.servers | cut -f1 -d":"`
	ip=`grep "$2:" ~/.servers | cut -f2 -d":"`
	user=`grep "$2:" ~/.servers | cut -f3 -d":"`
	if [ "${ip:-x}" != x -a "${name:-x}" != x ]
	then
		ssh -X -l $1 $ip
	fi
}

function ss() {
	name=`grep "$1:" ~/.servers | cut -f1 -d":"`
	ip=`grep "$1:" ~/.servers | cut -f2 -d":"`
	user=`grep "$1:" ~/.servers | cut -f3 -d":"`
	if [ "${ip:-x}" != x -a "${name:-x}" != x ]
	then
		#pc $name
		ssh -X -l $user $ip
	fi
}

function sf() {
	name=`grep "$1:" ~/.servers | cut -f1 -d":"`
	ip=`grep "$1:" ~/.servers | cut -f2 -d":"`
	user=`grep "$1:" ~/.servers | cut -f3 -d":"`
	if [ "${ip:-x}" != x -a "${name:-x}" != x ]
	then
#		pc $name
		sftp ${user}@$ip
	fi
}

function put() {
	ip=`grep "$2:" ~/.servers | cut -f2 -d":"`
	user=`grep "$2:" ~/.servers | cut -f3 -d":"`

	if [ "${3:-x}" != x ]
	then
		home=$3
	else
		home=`grep "$2:" ~/.servers | cut -f4 -d":"`
	fi

	if [ "${ip:-x}" != x ]
	then
		scp $1 ${user}@${ip}:${home}
	fi
}
		
function pc() {
	name=`grep "$1:" ~/.servers | cut -f1 -d":"`
	ip=`grep "$1:" ~/.servers | cut -f2 -d":"`
	user=`grep "$1:" ~/.servers | cut -f3 -d":"`
	home=`grep "$1:" ~/.servers | cut -f4 -d":"`
	
	ssh -l ${user} ${ip} "mkdir -p ${home}/.ssh; exit"
	scp -p ~/.ssh/authorized_keys ${user}@${ip}:${home}/.ssh/authorized_keys 
	scp -p ~/.bash_profile ${user}@${ip}:${home} 
	scp -p ~/completion ${user}@${ip}:${home} 
	scp -p ~/.bashrc ${user}@${ip}:${home} 
	scp -p ~/.vimrc ${user}@${ip}:${home} 
	scp -p ~/.screenrc ${user}@${ip}:${home} 
	scp -p ~/.servers ${user}@${ip}:${home} 
}

source ~/completion

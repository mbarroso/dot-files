# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias ll='ls -lha'
    alias conecthome='rdesktop 192.168.1.100 -u Administrador -p ADMIN'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias cd..='cd ..'
alias gsynch='sh ~/bin/gsynch.sh'
alias ec2server='ssh -i /home/dnoseda/soft/amazon/meli.arquitectura.mati.pem root@ec2-184-72-182-133.compute-1.amazonaws.com'
alias ec2metric='ssh -i /home/dnoseda/soft/amazon/meli.arquitectura.mati.pem root@ec2-75-101-234-178.compute-1.amazonaws.com'
alias stg-run-war='rm -rf target/ && grails clean && grails -Dgrails.env=stg run-war'
alias ui-run-war='rm -rf target/ && grails clean && grails -Dgrails.env=uiperf run-war'
alias test-port='export JAVA_OPTS="$JAVA_OPTS -Dserver.port=8081 -Dgrails.server.port.http=8081 "'
alias clean-orig='rm -rf `find . -regex .+\.orig`'
alias clean-svn='rm -rf `find . -type d -name .svn`'
alias v='gvim --remote-silent'
alias jsonpretty='python -mjson.tool'
alias rpl='sh ~/bin/rpl.sh'
alias rr='echo "restoring resolv.conf"; sudo cp ~/bkpapt/resolv.conf /etc/resolv.conf'

# ORACLE_HOME=/usr/lib/oracle/xe/app/oracle/product/10.2.0/server
# export ORACLE_HOME
# export ORACLE_SID=XE
# export PATH=$PATH:$ORACLE_HOME/bin
export GAE_HOME=~/soft/appengine/google_appengine/
export PATH=~/soft/play-1.0.3.3/:$PATH:/home/dnoseda/dev/labs/other
export PATH=/home/dnoseda/soft/node-v0.6.1/out/Release/:$PATH
export JAVA_OPTS="$JAVA_OPTS -Dwt.headless=true "
export REDIS_HOME=~/soft/redis

# para historico
export HISTCONTROL=erasedups
export HISTSIZE=10000
shopt -s histappend

# para app-engine
export APPENGINE_HOME=/home/dnoseda/soft/appengine/google_appengine

# para grails bash completion
# fuente: http://pastebin.com/f52475980
export GRAILS_VERSION="$(ls -lhr $HOME/.grails | egrep -i '1\.' | head -1 | gawk '{print $9 }')"

sed_option="-E"

[ "$(uname)" == "Linux" ] && sed_option="-r"

_get_domain_classes(){
	find ./grails-app/domain -iname *.groovy 2> /dev/null | tr \\n ' ' | sed 's/\.groovy//g' | sed 's/\.\/grails-app\/domain\///g' | tr '/' \.
}

_get_tests(){
	find ./test -iname *.groovy 2> /dev/null | sed 's/\.\/test\/integration\///g' | sed 's/\Tests.groovy//g' | tr '/' \.
}

_get_scripts(){
	for D in $SCRIPT_DIRS; do
		if [ -d $D ]
			then ls -1 $D/*.groovy 2> /dev/null | sed $sed_option 's/(.*)\/(.*)\.groovy/\2/' | sed $sed_option 's/([A-Z])/-\1/g' | sed $sed_option 's/^-//' | tr "[:upper:]" "[:lower:]"
		fi
	done | sort | uniq | grep -vE "^_"
}

_grails_comp(){
	local cur prev opts base
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	if [ -r ./grails-app ]; then
		SCRIPT_DIRS="$GRAILS_HOME/scripts ./scripts $HOME/.grails/scripts"
		if [ -d plugins ]
			then for PLUGIN_DIR in $(ls -d plugins/*/scripts 2> /dev/null); do
			SCRIPT_DIRS="$SCRIPT_DIRS $PLUGIN_DIR"
			done
		fi
 
		opts=$(_get_scripts)
	
		case "${prev}" in
			generate-all)
				local classes=$(_get_domain_classes)
				COMPREPLY=( $(compgen -W "${classes}" -- ${cur}) )
				return 0
				;;
			generate-views)
				local classes=$(_get_domain_classes)
				COMPREPLY=( $(compgen -W "${classes}" -- ${cur}) )
				return 0
				;;
			generate-controller)
				local classes=$(_get_domain_classes)
				COMPREPLY=( $(compgen -W "${classes}" -- ${cur}) )
				return 0
				;;
			test-app)
				local test_classes=$(_get_tests)
				COMPREPLY=( $(compgen -W "${test_classes}" -- ${cur}) )
				return 0
				;;
			install-plugin)
				_filedir
				return 0
				;;
			package-plugin)
				COMPREPLY=( $(compgen -f) )
				return 0
				;;
			plugin-info)
				local plugins=$(opts)
				COMPREPLY=( $(compgen -W "${plugins}" -- ${cur}) )
				return 0
				;;
			help)
				local opts=$(_get_scripts)
				COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
				return 0
				;;
			*)
			;;
		esac
	
		if [[ "${opts}" =~ "${prev}" ]]; then
			COMPREPLY=( $(compgen -f) )
			return 0
		fi
	
		COMPREPLY=($(compgen -W "${opts}" -- ${cur})) 
		return 0
	else
		opts="create-app create-plugin help list-plugins package-plugin plugin-info set-proxy"
		case "${prev}" in
			create-app)
				COMPREPLY=( $(compgen -f) )
				return 0
				;;
			create-plugin)
				COMPREPLY=( $(compgen -f) )
				return 0
				;;
			package-plugin)
				COMPREPLY=( $(compgen -f) )
				return 0
				;;
			plugin-info)
				local plugins=$(_get_plugins)
				COMPREPLY=( $(compgen -W "${plugins}" -- ${cur}) )
				return 0
				;;
			*)
				;;
		esac
		COMPREPLY=($(compgen -W "${opts}" -- ${cur})) 
		return 0
	fi
}
 
complete -F _grails_comp grails

### branch de git en promp
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

PS1="${TITLEBAR}\
$BLUE[$RED\$(date +%H:%M)$BLUE]\
$BLUE[$RED\u@\h:\w$GREEN\$(parse_git_branch)$BLUE]\
$WHITE\$ "
PS2='> '
PS4='+ '
}
proml


export http_proxy=
export ftp_proxy=
export https_proxy=
export JAVA_OPTS=

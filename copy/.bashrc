# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


export PATH=~/bin:$PATH
export LANG=en_US.UTF-8

export PROMPT_DIRTRIM=8
export PS1="\[\e]0;\w\a\][\e[32m\]\u@\h \[\e[35m\]\[\e[0m\] \[\e[33m\]\w\[\e[0m\]]\$ "

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias so='source ~/.bashrc'
alias rm='rm -i'

#findn() {
#  find 2>/dev/null -L -iname "$1" ${@:2}
#}
alias findn='find . -name $1  2>/dev/null'

alias cgrep='find . -name "*.c" -o -name "*.cpp" -o -name "*.cc"  | xargs grep $1 -n --color -s'
alias bgrep='find . -type f  | xargs grep $1 -ali -n --color -s'
alias xgrep='find . -name "*.xml" | xargs grep $1 -n --color -s'
alias jgrep='find . -name "*.java" | xargs grep $1 -n --color -s'
#alias cgrep='findn "*.c" | xargs grep $1 -n --color -s'


alias agrep='find . ! \( -name "*tags*" -o -name "*cscope*" -o -name "*.cmd" \) -not -path ".git/*" -not -path "out" | xargs grep $1 -n --color -s'
alias aagrep='find . ! \( -name "*tags*" -o -name "*cscope*"  \) | xargs grep $1 -n --color -s'
alias sgrep='find . -name "*.[sS]" | xargs grep $1 -n --color -s'
alias kgrep='find . -name "Kconfig" -o -name "Kconfig.*" | xargs grep $1 -n --color'
#alias xxgrep='find . -name "*" -type f | xargs  -i sh -c "echo {} &&  xxd -p {} | tr -d '\n' | grep -c $1"'
function xxgrep() {
        find . -name "*" -type f | xargs  -i sh -c "echo {} &&  xxd -p {} |  grep -c $1"
}

function xxxgrep() {
        find . -name "*" -type f | xargs  -i sh -c "echo {} &&  xxd -p {} | tr -d '\n' | grep -c $1"
}

alias defgrep='find . -name "*defconfig" | xargs grep $1 -n --color -s'
alias ogrep='find . -name "*.o" -o -name "*.a" | xargs grep $1 -n --color -s'
alias hgrep='find . -name "*.h" -o -name "*.hh" -o -name "*.hpp" | xargs grep $1 -n --color -s'
alias dtsgrep='find . -name "*.dts" -o -name "*.dtsi"  | xargs grep $1 -n --color -s'
alias shgrep='find . -name "*.sh" | xargs grep $1 -n --color -s'
alias mgrep='find . -name Makefile -o -name "*.mk" -o -name "*.make" -o -name makefile -o -name "Makefile.*" | xargs grep $1 -n --color -s'
alias mapgrep='find . -name "*.map" | xargs grep $1 -n --color -s'
alias ocgrep="find . -name '*.o' | sed -e 's/o$/c/g' | xargs grep $1 -n --color -s"
alias osgrep="find . -name '*.o' | sed -e 's/o$/S/g' | xargs grep $1 -n --color -s"
alias cssgrep="find . -name '*.css' |  xargs grep $1 -n --color -s"
alias confgrep="find . -name '*.conf' |  xargs grep $1 -n --color -s"
alias bbgrep="find . -name '*.bb*' |  xargs grep $1 -n --color -s"
alias d2h="printf '%x\n' $1"

alias rmo='find . -name "*.o" | xargs rm $1'
# User specific aliases and functions

alias vi='vim'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# for cygwin
alias ls="ls -F --color=auto"
alias makej="make -j12"
#alias make="make -j1"
alias makeu="make -j12 && ./up.sh"

alias mkcscope="find . \( -name '*.c' -o -name '*.h' -o -name '*.s' -o -name '*.S' \) -print > cscope.files && cscope -i cscope.files"

alias ll='ls -alF'


RCST_PATH="/home/turbox/workspace/rcst"
alias cd.rcst='cd $RCST_PATH'
alias cd.ke='cd $RCST_PATH/QCS610/kernel/'
alias cd.dts='cd $RCST_PATH/QCS610/kernel/linux/arch/arm64/boot/dts/qcom'
alias cd.fs='cd $RCST_PATH/QCS610/rootfs/fs'
alias cd.bin='cd $RCST_PATH/bin'
alias cd.edk='cd $RCST_PATH/QCS610/bios/edk2/QcomModulePkg/Application/LinuxLoader'
alias pnx.fs='cd $RCST_PATH/SC606T/rootfs/fs'



alias cd.open='cd ~/workspace/open'

SOT1000_YOCTO=~/workspace/sourcecode/TurboX_C610_C410/turbox-c610-le1.0-v2-dev.release.Post-CS1.r002008
alias cd.sot1000='cd $SOT1000_YOCTO'
alias cd.poky='cd $SOT1000_YOCTO/apps_proc/poky'
alias cd.work='cd $SOT1000_YOCTO/apps_proc/build-qti-distro-fullstack-virtualization-debug/tmp-glibc/work'
export MACHINE=qcs610-odk-64
export DISTRO=qti-distro-fullstack-virtualization-debug
export SHELL=/bin/bash


alias so.sot='cd $SOT1000_YOCTO/apps_proc && source poky/qti-conf/set_bb_env.sh && echo PREBUILT_SRC_DIR=\"$SOT1000_YOCTO/apps_proc/prebuilt_HY11\" >> conf/local.conf'
alias bi.sot="bitbake qti-multimedia-image"


PATH="/home/yseo/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/yseo/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/yseo/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/yseo/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/yseo/perl5"; export PERL_MM_OPT;

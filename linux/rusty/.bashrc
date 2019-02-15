#     dBBBBBb    dBP dB.dBBBBP dBBBBBBP dBP   dBP " .dBBBBP
#         dBP   dBP dB BP        dBP     dP  dP  ' dBP
#     dBBBBK'  dBP dBP `BBBBb   dBP      dBBP      BP`BBBBb
#    dBP  BB  dBP_dBP     dBP  dBP      dBBP           dBP
#   dBP  dB' dBBBBBP dBBBBP'  dBP      dBBP       dBBBBP'
#
#     dBBBb dBBBBBb .dBBBBP   dBP  dBP
#    d   BP    B BP dP       dBP  dBP
#   dBBBK'   dBP BB `BBBBb  dBBBBBBP
#  dB' db   dBP  BB    dBP dBP  dBP
# dBBBBP'  dBBBBBBdBBBBP' dBP  dBP

################
# Startup/Misc #
################

# Windows setup for cygwin to honor line endings and such.
if [[ "$TERM" == 'cygwin' ]]; then
    export SHELLOPTS
    set -o igncr
fi

# If not running interactively then don't do anything else but pathzz.
[[ $- == *i* ]] || return

# Enable Bash Completion if script is present.
if [[ -e /etc/bash_completion ]];then
    . /etc/bash_completion
fi
if [[ -e /usr/local/bin/brew ]];then
    BREW_PREFIX="$(brew --prefix)"
fi
if [[ -f "$BREW_PREFIX/etc/bash_completion" ]];then
    . "$BREW_PREFIX/etc/bash_completion"
fi
if [[ -e "$HOME/.local/git-completion.bash" ]];then
    . "$HOME/.local/git-completion.bash"
fi

# Checks to see if on FreeBSD or linux
KERNEL=$(uname)
if [[ "$KERNEL" == 'Linux' ]] || [[ "$KERNEL" == *"NT"* ]] ; then
    PLATFORM='linux'
elif [[ "$KERNEL" == 'FreeBSD' ]] ; then
    PLATFORM='freebsd'
elif [[ "$KERNEL" == 'OpenBSD' ]] ; then
    PLATFORM='openbsd'
elif [[ "$KERNEL" == 'Darwin' ]] ; then
    PLATFORM='freebsd' # Treat it the same way
fi

########
# Path #
########

export PATH=$PATH:/usr/sbin:/sbin:
if [[ -e "$HOME/.rbenv/bin" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi
if [[ -e "~/.passwdrc" ]]; then
    source ~/.passwdrc
fi
if [[ -d "$HOME/apps/.bin" ]]; then
    export PATH="$HOME/apps/.bin:$PATH"
fi

###########
# Aliases #
###########

# Alias for rebooting.
alias reboots="sudo reboot"

# Alias for stupid ssh bullshit.
alias grr='eval `ssh-agent -s`;'

# Add color to grep and line numbers.
alias grep='grep --color -n'

# Alias for rdesktop to not be lame.
alias rdesktop13='rdesktop -g 1366x768 -a 16 -x b -0'
alias rdesktop14='rdesktop -g 1440x900 -a 16 -x b -0'
alias rdesktop17='rdesktop -g 1768x1000 -a 16 -x b -0'
alias rdesktop-tall='rdesktop -g 1000x1500 -a 16 -x b -0'

# Set alias for WiFi ssh on them macbooks.
alias sshw="ssh -b \$(ipconfig getifaddr en0)"

# Wake Ilos!
alias yoIlos="wakeonlan -f /rusty/.wakeonlan/ilos.mac"

# Fix ls.
if [[ $PLATFORM == 'linux' ]] ; then
    alias ll='ls -l --color=auto'
    alias ls='ls --color=auto'
elif [[ $PLATFORM == 'freebsd' ]]; then
    alias ll='ls -G -l'
    alias ls='ls -G'
elif [[ $PLATFORM == 'openbsd' ]]; then
    alias ll='ls -l'
fi

#############
# Functions #
#############

# Function for displaying git branch in PS1
function parse_git_branch {
  if [ ! -d . ]; then
    return '';
  fi
            # We pass in the magic token bash makes from \[ and \] (^A and ^B probably)
            # so we can use them in our echo statement.
            RED="$1\e[0;31m$2"
         YELLOW="$1\e[33m$2"
          GREEN="$1\e[32m$2"
           BLUE="$1\e[34m$2"
      LIGHT_RED="$1\e[31m$2"
           CYAN="$1\e[36m$2"
     LIGHT_CYAN="$1\e[1;36m$2"
    LIGHT_GREEN="$1\e[1;32m$2"
          WHITE="$1\e[1;37m$2"
     LIGHT_GRAY="$1\e[0;37m$2"
     COLOR_NONE="$1\e[0m$2"

  if git rev-parse --git-dir &> /dev/null; then
    branch=$(git branch | grep '*' | sed 's/\* //')
    echo -e "${CYAN}[${LIGHT_GRAY}${branch}${CYAN}] "
  fi

}

function rmdc {
    for c in $(docker ps -a | awk 'NR>1 {print $1}'); do
        docker rm $@ ${c}
    done
}


############
# PS1      #
############

if [ "$PS1" ]; then
   if [ $UID -eq "0" ]; then
      case "$TERM" in
      xterm*|rxvt*|cygwin)
        PS1='\n\[\e]2;\u@\h:\w\a\e[1m\e[31m\]\[\e[31m\]\u\[\e[37m\]@\[\e[35m\]\h\[\e[37m\]:\[\e[32m\]\w\[\e[33m\]\[\e[31m\] #\[\e[0m\] '
        ;;
      *)
        PS1='[\!]\u@\h \w# '
        ;;
      esac
   else
      case "$TERM" in
      xterm*|rxvt*|cygwin)
        PS1='[\!]\[\e[1;32m\]\u\[\e[37m\]@\[\e[35m\]\h\[\e[37m\]:\[\e[36m\]\w\[\e[33m\]\[\e[33m\]>\[\e[0m\] \[\e[37m\]\[\e[0m\]'
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        ;;
      *f)TH
        PS1='[\!]\u@\h \w> '
        ;;
      esac
   fi
fi
export PS1


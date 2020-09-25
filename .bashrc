# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# replacement
alias vi=vim

# convenience/fun
alias h='history | grep $1'
alias top-commands='history | awk "{print $2}" | awk "BEGIN {FS="|"} {print $1}" |sort|uniq -c | sort -rn | head -10'
alias addr="ifconfig|perl -nle's/dr:(\S+)/print$1/e'"
alias c="clear"
alias cdc="cd; clear"
alias ports="netstat -tulanp"

# git
function gitclone { 
	git clone git@github.com:bgoodfriend/$1.git $2
}

function push-key {
  ssh-copy-id -i ~/.ssh/id_rsa.pub bgoodfriend@$1
}
function bashrc {
  scp $HOME/.bashrc $1:$HOME/.bashrc
}
export -f push-key bashrc


# typos
alias mroe="more"
alias sl="ls"
alias mr="rm"

# disk space; directory stuff
alias diskspace="du -S | sort -n -r |more"
alias folders="find . -maxdepth 1 -type d -print | xargs du -sk | sort -rn"
alias lk='ls -lSr'                      # sort by size
alias l.='ls -d .* --color=auto'        # show hidden files
alias mount="mount | column -t"

# move about
alias p="cd .."
alias pp="cd ../.."
alias ppp="cd ../../.."
alias pppp="cd ../../../.."

# performance stuff
alias meminfo='free -m -l -t'                           # show free memory
alias psmem='ps auxf | sort -nr -k 4'                   # Top memory proc
alias psmem10='ps auxf | sort -nr -k 4 | head -10'      # Top 10
alias pscpu='ps auxf | sort -nr -k 3'                   # top CPU proc
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'      # top 10
alias cpuinfo='lscpu'                                   # show CPU info

# Functions start here.
function extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# perl things!
function perlinc() { perl -e 'print join "\n", @INC'; }
function find_perlmod() { perl -M$1 -e 'use Data::Dumper; print Dumper \%INC' | grep `echo "$1" | sed s/.*:://`; }
function perlenv() { perl -MData::Dumper -e "print Dumper \%ENV"; }

export -f find_perlmod perlenv extract perlinc

# python things!
alias mkenv='python3 -m venv env'
alias startenv='source env/bin/activate && which python3'
alias stopenv='deactivate'

# Colour codes are cumbersome, so let's name them
txtcyn='\[\e[0;96m\]' # Cyan
txtpur='\[\e[0;35m\]' # Purple
txtwht='\[\e[0;37m\]' # White
txtrst='\[\e[0m\]'    # Text Reset

# Which (C)olour for what part of the prompt?
pathC="${txtcyn}"
gitC="${txtpur}"
pointerC="${txtwht}"
normalC="${txtrst}"

# Get the name of our branch and put parenthesis around it
gitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Build the prompt
export PS1="${pathC}\w ${gitC}\$(gitBranch) ${pointerC}\$${normalC} "
export PATH=$PATH:$HOME/bin

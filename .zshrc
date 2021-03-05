# Lines configured by zsh-newuser-install
. ~/.profile

HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ByteWaiser/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

alias JN="jupyter-notebook"
alias ML="conda activate DL"
alias ls="ls --color=always"
alias ll="ls -l"
alias feh="~/Git/devour/devour.sh feh"
alias zathura="~/Git/devour/devour.sh zathura"
alias mpv="~/Git/devour/devour.sh mpv"
alias p="cd ~/Programming/Projects/DL"
export VISUAL=nvim
export EDITOR=nvim
alias vim="nvim"
# export VIMINIT="source ~/.config/vim/vimrc"
export TERMINAL=alacritty

alias monitor2="xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output DP1 --mode 1366x768 --rotate normal --left-of eDP1"
alias connectcomdata="rdesktop -g 1366x768 -P -z -x l -p DSFCdx+cmsd\!.95 -r disk:linux=/home/ByteWaiser/Share -u Hasan.Yurdagul 10.0.0.1"
alias ccomdata="xfreerdp /u:\"Hasan.Yurdagul\" /v:10.0.0.1 /p:DSFCdx+cmsd\!.95 /w:1366"
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;      
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ByteWaiser/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ByteWaiser/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ByteWaiser/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ByteWaiser/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

PROMPT='%F{blue}[%1~]%f%F{red}%#%f '


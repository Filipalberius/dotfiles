export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias vim=nvim
EDITOR=/home/filipa/bin/nvim

PATH="$PATH":"$HOME/.local/scripts/"
bindkey -s '^f' "tmux-sessionizer\n"

. /usr/share/oe-setup/oe-setup.sh

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
fpath+=${ZDOTDIR:-~}/.zsh_functions

export PATH="$HOME/.cargo/bin:$PATH"

alias py=python3

# gc
unalias gc

gc() {  # gerrit clone
  if [ $# -eq 1 ]; then
    git clone ssh://gittools.se.axis.com:29418/"$1"
  elif [ $# -eq 2 ]; then
    git clone ssh://gittools.se.axis.com:29418/"$1" "$2"
  else
    echo "ERROR: Please provide the repository to clone"
  fi
}


_fzf_complete_gc() {
  _fzf_complete -- "$@" < <(ssh -p 29418 gittools.se.axis.com gerrit \
                            ls-projects)
}

_fzf_complete_oe-initenv() {
  _fzf_complete -- "$@" < <(ls ~/repos/meta-axis-bsp/conf/machine/*.conf | \
                            sed -E 's,.*/(.*).conf,\1,')
}

########################################

ATF_INSTALL=yes source ~/.atf
export ATF_VIRTUAL_ENV="/mnt/build/repos/benchpark/venv"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

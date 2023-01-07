alias valgrind="valgrind --leak-check=full --show-leak-kinds=all"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# Load version control information
autoload -Uz vcs_info

precmd() {
    psvar=()

    vcs_info
    [[ -n $vcs_info_msg_0_ ]] && print -v 'psvar[1]' -Pr -- "$vcs_info_msg_0_"
}

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='T'
    fi
}

zstyle -e ':vcs_info:git*' check-for-changes
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PS1='%F{green}%B%n % ➥ %f%F{blue}%m %F{093}%3~ %f%b${vcs_info_msg_0_}'
RPROMPT='%(?.%F{green}✓%f.%F{red}✗ %?%f) %F{yellow}%*%f'

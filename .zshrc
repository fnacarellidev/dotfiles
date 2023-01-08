+vi-git-untracked-or-uptodate(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='?'
	elif [[ -n $(git status | grep "nothing to commit") ]]; then
		hook_com[misc]+='🔥'
    fi
}

alias valgrind="valgrind --leak-check=full --show-leak-kinds=all"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export GIT_EDITOR="nvim"

plugins=(
	git
	colored-man-pages
)

source $ZSH/oh-my-zsh.sh

autoload -Uz vcs_info
# Autocompletion for git
autoload -Uz compinit && compinit

precmd() { 
	vcs_info 
	if [[ -z ${vcs_info_msg_0_} ]]; then
		PS1='%F{green}╭─%B%n ➥ %f%F{blue}%m %F{093}%3~ %f%b
%F{green}╰─❯%f '
	else
		PS1='%F{green}╭─%B%n ➥ %f%b${vcs_info_msg_0_}
%F{green}╰─❯%f '
	fi
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked-or-uptodate
zstyle ':vcs_info:git:*' formats '%B%F{blue}%r/%S%f%%b %F{153}❴%b❵%f %B%F{226}[%c%u%m]%f%%b'
setopt PROMPT_SUBST

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
RPROMPT='%(?.%F{green}✓%f.%F{red}✗ %?%f) %F{white}%*%f '

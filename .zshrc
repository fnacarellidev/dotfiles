function +vi-git-untracked()
{
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+='?'
    fi
}

function +vi-git-updated()
{
	if [[ -n $(git status | grep "nothing to commit") && 
		-z $(git status | grep "publish") ]]; then
		hook_com[misc]+='🔥'
	fi
}

function +vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "⇡${ahead}" )
    (( $behind )) && gitstatus+=( "⇣${behind}" )

    hook_com[misc]+=${(j:/:)gitstatus}
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
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-st git-updated
zstyle ':vcs_info:git:*' formats '%B%F{blue}%r/%S%f%%b %F{153}❴%b❵%f %B%F{226}[%c%u%m]%f%%b'
setopt PROMPT_SUBST

RPROMPT='%(?.%F{green}✓%f.%F{red}✗ %?%f) %F{white}%*%f '

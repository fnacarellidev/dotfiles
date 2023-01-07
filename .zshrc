alias valgrind="valgrind --leak-check=full --show-leak-kinds=all"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	colored-man-pages
)

source $ZSH/oh-my-zsh.sh

autoload -Uz vcs_info
autoload -Uz compinit && compinit

precmd() { 
	vcs_info 
	if [[ -z ${vcs_info_msg_0_} ]]; then
		PS1='%F{green}%B%n % ➥ %f%F{blue}%m %F{093}%3~ %f%b'
	else
		PS1='%F{069}%B%n%f%b ${vcs_info_msg_0_} '
	fi
}

zstyle ':vcs_info:git:*' formats '%r/%S (%F{153}%b%f)'
setopt PROMPT_SUBST

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
RPROMPT='%(?.%F{green}✓%f.%F{red}✗ %?%f) %F{white}%*%f'

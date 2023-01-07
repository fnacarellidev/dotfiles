alias valgrind="valgrind --leak-check=full --show-leak-kinds=all"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
	git
	colored-man-pages
)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit && compinit
ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN="✨"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PS1='%F{green}%B%n % ➥ %f%F{blue}%m %F{093}%3~ %f%b$(git_prompt_info) $(git_prompt_status)'
RPROMPT='%(?.%F{green}✓%f.%F{red}✗ %?%f) %F{yellow}%*%f'

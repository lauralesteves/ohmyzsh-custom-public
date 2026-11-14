# Configs
alias zshconfig="subl ~/.zshrc ~/.oh-my-zsh/custom"
alias bashconfig="subl ~/.bashrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias awsconfig="subl ~/.aws"

alias ll="ls -lgoh"

# Folders
alias me="cd ~"
alias custom="cd ~/.oh-my-zsh/custom"

# Global pipe aliases (e.g. ps aux G docker, cat file L)
alias -g G='| grep --color=auto -i'
alias -g L='| less'
alias -g T='| tail -20'
alias -g NUL='> /dev/null 2>&1'

# Node
alias npm-global="npm -g ls --depth=0"
alias npm-local="npm ls --depth=0"
alias yanr="yarn"

# Shortcuts to emoji
alias shrug="echo -n '¯\_(ツ)_/¯' | pbcopy"
alias lenny="echo -n '( ͡° ͜ʖ ͡°)' | pbcopy"
alias wut="echo -n 'ಠ_ಠ' | pbcopy"


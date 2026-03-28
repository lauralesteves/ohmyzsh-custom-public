# Docker shortcuts
alias dk=docker
alias dkr='docker run'
alias dkrr='docker run --rm'
alias dkrri='docker run --rm -i -t'
alias dks='docker start'
alias dkstop='docker stop'
alias dkrs='docker restart'
alias dkrm='docker rm'
alias dkrmi='docker rmi'
alias dki='docker inspect'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dktop='docker top'
alias dke='docker exec'
alias dkei='docker exec -i -t'
alias dkl='docker logs'
alias dklf='docker logs -f'
alias dkims='docker images'
alias dkp='docker pull'

# Docker cleanup
alias containerclean="docker ps -a -q | xargs docker rm"
alias imageclean="docker images --filter dangling=true -q | xargs docker rmi"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Ruby dev
alias be='bundle exec '
alias fr='foreman run '
alias br='be fr '
alias bi='bundle install --path .bundle -j4'
alias bu='bundle update '

# Docker
alias fig="docker-compose"
alias dps="docker ps"

# Git
alias gbra="git branch"
alias glog="git log --oneline --decorate --branches --remotes --tags -n 35"
alias gloga="glog --pretty=format:'%C(yellow)%h%C(reset)%C(bold red)%d%C(reset) %s %C(green)(%cr) %C(cyan)<%an>%C(reset)' | ruby -e 'puts STDIN.read.gsub(%(<#{%x(git config user.name).chomp}>), %())'"
alias gstatus="git status"
alias gstatusa="git status -sbu"
alias gdiff="git diff"
alias gadd="git add "
alias gcommit="git commit -v"
alias gcommita="git commit -va"
#alias grebase="git rebase -i HEAD~20"
alias gpull="git pull --rebase origin"
alias gpush="git push origin"
alias gstash="git stash save -u"
alias gpop="git stash pop"
alias gsl="git stash list"
alias gclean="git clean -fd"
alias gsub="git submodule"
alias gsuba="git submodule add"
alias gsubi="git submodule init"
alias gsubu="git submodule update"
alias gmerge="git merge --no-ff"

#Paperwork
function paperwork() { 
	docker run -ti --rm \
		-e DISPLAY=$DISPLAY -e XAUTHORITY=$HOME/.Xauthority -e HOME=$HOME -e USER=$USER \
		-v $HOME:$HOME -v /tmp/.X11-unix:/tmp/.X11-unix -v /etc/sane.d/:/etc/sane.d/ \
		tclavier/paperwork 
}  

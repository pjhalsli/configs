# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bunnyruni"

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(archlinux git jump chucknorris themes )

source $ZSH/oh-my-zsh.sh

# User configuration

# Import colorscheme from 'wal' asynchronously
# &   
# Run the process in the background.
# ( ) 
# Hide shell job control messages.
#(cat ~/.cache/wal/sequences &)

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='mvim'
 fi


 # Gotham Shell
#GOTHAM_SHELL="$HOME/.config/gotham/gotham.sh"
#[ -s $GOTHAM_SHELL ]] && source $GOTHAM_SHELL

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Personal Shit
[ -f ~/.fzf.colors ] && source ~/.fzf.colors

alias lock="i3lock -i Bilder/wp/wallhaven-670048_1920x1080.png -p win -f Source-Code-Pro"
alias lockp="i3lock-fancy -p -f Source-Code-Pro-Medium -t 'Back Soon'"
alias cheeze="./scripts/cheeze"
alias gcal='gcalcli --auth_host_name AUTH_HOST_NAME'
alias checkup="./scripts/checkupdates-aurman.sh -o -c -t"
alias aura="aura -n 'os user' -c 'c7 c5'" 
alias eyes='cowsay -f eyes I Am Watching You'
alias wttr='curl http://wttr.in trondheim'
alias pb="curl -F 'f:1=@"
alias ytv="youtube-dl"
alias yta="youtube-dl --extract-audio --audio-format mp3 "

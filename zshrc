
#                 ██                    
#                ░██                    
#  ██████  ██████░██      ██████  █████ 
# ░░░░██  ██░░░░ ░██████ ░░██░░█ ██░░░██
#    ██  ░░█████ ░██░░░██ ░██ ░ ░██  ░░ 
#   ██    ░░░░░██░██  ░██ ░██   ░██   ██
#  ██████ ██████ ░██  ░██░███   ░░█████ 
# ░░░░░░ ░░░░░░  ░░   ░░ ░░░     ░░░░░  
#

export TERM="xterm-termite"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


ZSH_THEME="classyTouch"

POWERLEVEL9K_TIME_FORMAT=" %D{%H:%M:%S \ %a%d.%m.%y}"
POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
#POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status load os_icon dir vcs)
POWERLEVEL9K_STATUS_FOREGROUND='black'
POWERLEVEL9K_DIR_HOME_BACKGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_TIME_FOREGROUND='black'
POWERLEVEL9K_TIME_BACKGROUND='yellow'
POWERLEVEL9K_LOAD_FOREGROUND='white'
POWERLEVEL9K_LOAD_BACKGROND='cyan'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('ram_joined' 'time')

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
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
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(archlinux git colorize jump colored-man-pages alias-tips zsh-syntax-highlighting)

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
source ~/sourcerer.sh
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
	tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias yasu='yaourt --sucre'
alias yaupg='yaourt -Syua'
alias yain='yaourt -S'
alias yains='yaourt -U'
alias yare='yaourt -R'
alias yarem='yaourt -Rns'
alias yarep='yaourt -Si'
alias yareps='yaourt -Ss'
alias yaloc='yaourt -Qi'
alias yalocs='yaourt -Qs'
alias yalst='yaourt -Qe'
alias yaorph='yaourt -Qtd'
alias pacupg='pacaur -Syu --devel --needed --noedit'
alias pacin='sudo pacman -S'
alias pacins='sudo pacman -U'
alias pacre='sudo pacman -R'
alias pacrem='sudo pacman -Rns'
alias pacrep='sudo pacman -Si'
alias pacreps='sudo pacman -Ss'
alias pacloc='sudo pacman -Qi'
alias paclocs='sudo pacman -Qs'
alias paclstorphans='sudo pacman -Qdt'
alias pacrmorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias weather='curl http://wttr.in/trondheim'
alias edpaco='sudo vim /etc/pacman.conf'

# execute colorscripts
alias pipes='~/Dokumenter/colorscript/pipes'
alias pac='~/Dokumenter/colorscript/script8'
alias invaders='~/Dokumenter/colorscript/script5'
alias colorbar='~/Dokumenter/colorscript/script1'
alias info='~/Dokumenter/colorscript/info'
alias info3='~/Dokumenter/colorscript/info3'
alias info4='~/Dokumenter/colorscript/info4'
alias info5='~/Dokumenter/colorscript/info5'
alias 16='~/Dokumenter/colorscript/colors16'
alias wifi='sudo wifi-menu'
alias eyes='cowsay -f eyes I Am Watching You'

#Weather forcast via nixCraft
#wttr () {
#curl http://wttr.in/$1
#}
alias wttr='curl http://wttr.in trondheim'


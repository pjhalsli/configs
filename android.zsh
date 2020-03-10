# Prompt Options
set -o promptSubst      # Makes prompt string subjected to some expansions
set -o promptPercent    # Expands some escape sequences (that starts with %)
set +o flowControl      # Print unprintable characters that do flow control

_JOBS="%(1j.%B%K{yellow}%F{black} %j jobs %b%F{yellow}%(0?,%K{8},%K{red})%f.)"
_EXIT="%(0?..%B%K{red}%F{white} EXIT: %? %b%F{red}%K{8})"
_CMD="%B%K{8}%F{white} %L.%i %b"
_USR="%(!.%F{8}%K{red}%F{red}%k.%F{8}%K{green}%F{green}%k)"

PS1="
${_JOBS}\
${_EXIT}\
${_CMD}\
${_USR}\
%f%k%b "

PS2=' %K{8}%F{0}%B%f %_ %K{0}%F{8} %k%f%b'

# Right Prompt - Prints pwd
RPS1=' %F{8}%1{%}%F{white}%K{8} %30<...<%~ %f%k'

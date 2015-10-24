# start tmux terminal multiplexer
# If not running interactively, do not do anything
#[[ $- != *i* ]] && return
#[[ -z "$TMUX" ]] && exec tmux

# key bindings
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# dircolors
[[ -f ~/.dircolors ]] && eval `dircolors -b ~/.dircolors`

if [[ -f ~/.zsh-command-coloring ]]; then
    source ~/.zsh-command-coloring
fi

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

autoload -U compinit && compinit
zmodload -i zsh/complist

# generate descriptions with magic.
zstyle ':completion:*' auto-description 'specify: %d'

# Don't prompt for a huge list, page it!
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Don't prompt for a huge list, menu it!
zstyle ':completion:*:default' menu 'select=0'

# color code completion!!!!  Wohoo!
#zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=30=30"
zstyle ':completion:*' list-colors ""

alias ..='cd ..'
alias l='ls -lh --color=auto'
alias ll='ls -lah --color=auto'

alias tdd="phpunit -c ~/projects/brickoo/phpunit.xml "
alias bcc="phpunit -c ~/projects/brickoo/phpunit.xml --coverage-html ~/projects/bcc/ "
alias hht="hhvm ~/projects/phars/phpunit.phar -c ~/projects/brickoo/tests/phpunit.xml "

# User configuration

export PATH=$HOME/bin:/usr/local/bin:$PATH

# POWERLINE THEME

# chars       

case $TERM in
  xterm) TERM=xterm-256color ;;
  screen) TERM=screen-256color ;;
esac

display_colors() {
    for i in {0..256}; do echo -n ${(%):-$(printf '%%F{%1$d}%1$3d%%f' $i) }; (( $i % 36 == 15 )) && echo; done
}

autoload -Uz vcs_info

local vcsformat=" %F{blue}%F{white}%K{blue} %b %F{white}%K{white}%F{black}%m %c%u"
local vcsactionformat="$vcsformat%F{yellow}%K{yellow}%F{white} %a %K{yellow}"


zstyle ':vcs_info:*' enable git svn hg
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' use-simple false
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' max-exports 5
zstyle ':vcs_info:*' formats $vcsformat 
zstyle ':vcs_info:*' actionformats $vcsactionformat
zstyle ':vcs_info:*' branchformat "%b#%r"
zstyle ':vcs_info:*' hgrevformat "%r"
zstyle ':vcs_info:*' stagedstr "%F{green}%K{green}%B%F{white} S %b%K{green}"
zstyle ':vcs_info:*' unstagedstr "%F{red}%K{red}%B%F{white} U %b%K{red}"
zstyle ':vcs_info:git+set-message:*' hooks git-hook-message

+vi-git-hook-message() {
  # Are we NOT on a remote-tracking branch?
  if git rev-parse --verify @{u} &>/dev/null; then
    hook_com[branch]+=" %F{255}%f"
  fi

  # Show +N/-N when your local branch is ahead-of or behind remote HEAD
  local -a gitstatus diff
  diff=($(git rev-list --left-right --count HEAD...@{u} 2>/dev/null))
  (( ${diff[1]} )) && hook_com[branch]+=" %F{46}%B↑%F{white} ${diff[1]}%b%K{blue}"
  (( ${diff[2]} )) && hook_com[branch]+=" %F{white}%B↓ ${diff[2]}%b%K{blue}"

  hook_com[misc]+=" $(git rev-parse --short HEAD)"

  [[ -n $(git ls-files --others --exclude-standard) ]] && hook_com[staged]+=$'%F{yellow}\ue0b2%K{yellow}%B%F{white} N %b%K{yellow}'
}

prompt_precmd() {
  local vcs_info_msg_0_ pwd_msg
  local -a pwd

  if vcs_info; then
    RPROMPT="$vcs_info_msg_0_"
  fi
  
  pwd=("${(s:/:)${(%):-%~}}")

  case ${pwd[1]} in
    "") pwd[1]=/ ;;
    \~) pwd[1]=⌂ ;;
    \~?*) pwd[1]=${pwd[1]/\~/⌂ } ;;
  esac

  [[ -z ${pwd[2]} ]] && pwd[2]=()

# print directories in prompt, last number ist the amount
  pwd_msg=${(j: %F{232}%F{white} :)pwd: -2}

  PROMPT="
%(0#.%K{red}.%K{white})%(0#.%F{white}.%F{black}) %n %(0#.%F{red}.%F{white})%K{blue}%F{white} $pwd_msg %F{blue}%k %F{blue}"
}


autoload -Uz add-zsh-hook
add-zsh-hook precmd prompt_precmd


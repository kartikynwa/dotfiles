set -x EDITOR helix
abbr -a hx helix
abbr -a vim nvim
abbr -a c chezmoi

# Format man pages
set -x MANROFFOPT -c
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Add depot_tools to PATH
if test -d ~/Applications/depot_tools
    if not contains -- ~/Applications/depot_tools $PATH
        set -p PATH ~/Applications/depot_tools
    end
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]

    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=auto --group-directories-first --icons=auto' # preferred listing
alias la='eza -a --color=auto --group-directories-first --icons=auto' # all files and dirs
alias ll='eza -l --color=auto --group-directories-first --icons=auto' # long format
alias lt='eza -aT --color=auto --group-directories-first --icons=auto' # tree listing
alias l.="eza -a | grep -e '^\.'" # show only dotfiles

# Common use
abbr -a untar tar -zxvf
abbr -a wget wget -c
abbr -a psmem "ps auxf | sort -nr -k 4"
abbr -a psmem10 "ps auxf | sort -nr -k 4 | head -10"
abbr -a big "expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
abbr -a gitpkg 'pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages

# Get fastest mirrors
abbr -a mirror sudo cachyos-rate-mirrors

# Cleanup orphaned packages
abbr -a update sudo pacman -Syu
abbr -a fixpacman sudo rm /var/lib/pacman/db.lck
abbr -a cleanup 'sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
abbr -a jctl journalctl -p 3 -xb

# Recent installed packages
abbr -a rip "expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# Rustup
set -x RUSTUP_HOME ~/.local/share/rustup

bind alt-backspace backward-kill-word
bind ctrl-backspace backward-kill-token

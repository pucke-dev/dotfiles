if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls="exa -1 -l -F -a"
alias cat="bat --paging=never"
alias kk="kubectl"

starship init fish | source


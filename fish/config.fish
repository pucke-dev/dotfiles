if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls="exa -1 -l -F -a"
alias cat="bat --paging=never"
alias kk="kubectl"

starship init fish | source

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx PATH "$HOME/go/bin" $PATH
set -gx PATH "$HOME/.rover/bin" $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

thefuck --alias | source

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

export GOPRIVATE="github.com/lovoo/*"

alias ls="eza -1 -l -F -a"
alias cat="bat --paging=never"
alias kk="kubectl"

starship init fish | source
zoxide init fish --cmd cd | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/philippucke/google-cloud-sdk/path.fish.inc' ]; . '/Users/philippucke/google-cloud-sdk/path.fish.inc'; end

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

export GOPRIVATE="github.com/lovoo/*"

alias ls="eza -1 -l -F -a"
alias cat="bat --paging=never"
alias kk="kubectl"
alias vim="nvim"

alias gs="git status"
alias gp="git push"
alias gl="git pull"

starship init fish | source
zoxide init fish --cmd cd | source

fish_add_path -g $(which go)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/philippucke/google-cloud-sdk/path.fish.inc' ]; . '/Users/philippucke/google-cloud-sdk/path.fish.inc'; end
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
mkdir -p ~/.config/fish/completions
carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
carapace _carapace | source

direnv hook fish | source


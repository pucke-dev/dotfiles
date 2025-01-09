if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish | source
end

export XDG_CONFIG_HOME="$HOME/.config"

alias ls="eza -1 -l -F -a"
alias cat="bat --paging=never"
alias k="kubectl"
alias v="nvim"

alias gs="git status"
alias gp="git push"
alias gl="git pull"
alias gcd="git checkout develop"

alias kfp="k get pods --all-namespaces | fzf"

export STARSHIP_CONFIG="~/.config/starship/starship.toml"
starship init fish | source

zoxide init fish --cmd cd | source

fish_add_path -g $(which go)
fish_add_path -g "$HOME/.go/bin"

set -Ux CARAPACE_BRIDGES 'zsh,fish,bash,inshellisense' # optional
mkdir -p ~/.config/fish/completions
carapace --list | awk '{print $1}' | grep -v "^zoxide\$" |xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
carapace _carapace | source

direnv hook fish | source
set -U fish_user_paths /Users/philippucke/.local/bin $fish_user_paths

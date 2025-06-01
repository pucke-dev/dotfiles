# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

### Imports
use std/util "path add"


### Environment Variables & Settings
path add "/nix/var/nix/profiles/default/bin"
path add "/opt/homebrew/bin"
path add "/usr/local/bin"
path add "/opt/homebrew/opt/php@8.2/bin"
path add "/opt/homebrew/opt/php@8.2/sbin"
path add $"(which go)"
path add ($env.HOME | path join ".go/bin")
path add ($env.HOME | path join "go/bin")
path add ($env.HOME | path join ".cargo/bin")
path add ($env.HOME | path join ".local/bin")
path add ($env.HOME | path join ".volta/bin")

$env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
$env.STARSHIP_CONFIG = $"($env.HOME)/.config/starship/starship.toml"
$env.CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense"

# $env.DOCKER_HOST = $"unix://($env.HOME)/.config/colima/default/docker.sock"
# $env.TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE = "/var/run/docker.sock"

$env.EDITOR = "nvim"
$env.config.buffer_editor = "/opt/homebrew/bin/nvim"
$env.config.show_banner = false
$env.config.edit_mode = "vi"
$env.config.completions.algorithm = "fuzzy"
$env.config.footer_mode = "auto"

$env.config.keybindings ++= [
    {
        name: delete_one_word_backward
        modifier: alt
        keycode: backspace
        mode: [emacs, vi_normal, vi_insert]
        event: { edit: backspaceword }
    }
]

$env.config = ($env.config | upsert hooks {
    env_change: {
        PWD: [
            {||
                if (which direnv | is-empty) {
                    return
                }

                direnv export json | from json | default {} | load-env
            }
        ]
    }
})

let fish_completer = {|spans|
    fish --command $'complete "--do-complete=($spans | str join " ")"'
    | from tsv --flexible --noheaders --no-infer
    | rename value description
}

let zoxide_completer = {|spans|
    $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
}

let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans | from json
    | if ($in | default [] | where value =~ '^-.*ERR$' | is-empty) { $in } else { null }
}

let external_completer = {|spans|
    let expanded_alias = scope aliases | where name == $spans.0 | get -i 0.expansion

    let spans = if $expanded_alias != null {
        $spans | skip 1 | prepend ($expanded_alias | split row ' ' | take 1)
    } else {
        $spans
    }

    match $spans.0 {
        nu => $fish_completer
        git => $fish_completer
        z | zi => $zoxide_completer
        __zoxide_z | __zoxide_zi => $zoxide_completer
        _ => $carapace_completer
    } | do $in $spans
}

$env.config.completions.external.completer = $external_completer


### Aliases
alias cat-core = cat
alias cat = bat --paging=never

alias v = nvim

alias gs = git status
alias gp = git push
alias gl = git pull
alias gcm = git commit -m
alias gca = git commit --amend

alias k = kubectl
alias kns = kubens
alias kctx = kubectx


### Install Plugins
let data_dir = $"($env.HOME)/.local/share/nushell"
mkdir ($data_dir | path join "vendor/autoload")

atuin init nu | save -f ($data_dir | path join "vendor/autoload/atuin.nu")
source ~/.local/share/nushell/vendor/autoload/atuin.nu

starship init nu | save -f ($data_dir | path join "vendor/autoload/starship.nu")

carapace _carapace nushell | save -f ($data_dir | path join "vendor/autoload/carapace.nu")

zoxide init nushell --cmd cd | save -f ($data_dir | path join "vendor/autoload/zoxide.nu")
source ~/.local/share/nushell/vendor/autoload/zoxide.nu


# home.nix
# home-manager switch

{ config, pkgs, ... }:

{
  home.username = "philippucke";
  home.homeDirectory = "/Users/philippucke";
  home.stateVersion = "23.05"; # Please read the comment before changing.

# Makes sense for user specific applications that shouldn't be available system-wide
  home.packages = [
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/wezterm".source = ~/dotfiles/wezterm;
    ".config/starship".source = ~/dotfiles/starship;
    ".config/nvim".source = ~/dotfiles/nvim;
    ".config/nix".source = ~/dotfiles/nix;
    ".config/nix-darwin".source = ~/dotfiles/nix-darwin;
    ".config/tmux".source = ~/dotfiles/tmux;
    ".config/aerospace".source = "~/dotfiles/aerospace";
    ".config/atuin".source = "~/dotfiles/atuin";
#    ".config/ghostty".source = ~/dotfiles/ghostty;
  };

  home.sessionVariables = {
  };

  home.sessionPath = [
    "/run/current-system/sw/bin"
      "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.fish = {
    enable = true;
  };
}

{ pkgs, profile, ... }:

{
  imports = [
    ./software/packages.nix
    ./shell/zsh/zsh.nix
    ./browser/firefox.nix
    ./git/git.nix
    ./term-emulator/alacritty.nix
  ];

  home.username = profile.user;
  home.homeDirectory = "/home/${profile.user}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}

{ pkgs, profile, ... }:

{
  imports = [
    ./desktop-env/xfce.nix
    ./software
    ./shell/zsh/zsh.nix
    ./browser/firefox.nix
    ./git/git.nix
    ./ssh/ssh-config.nix
    ./term-emulator/alacritty.nix
  ];

  home.username = profile.user;
  home.homeDirectory = "/home/${profile.user}";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}

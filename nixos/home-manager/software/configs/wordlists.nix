{
  config,
  pkgs,
  lib,
  ...
}:

let
  myLists = pkgs.wordlists.override {
    lists = with pkgs; [
      rockyou
      seclists
    ];
  };
in
{
  # 1. Package installation
  home.packages = [ myLists ];

  # 2. Symlink
  home.file."wordlist" = {
    source = "${myLists}/share/wordlists";
  };
}

{ ... }:

{
  imports = [
    ./packages.nix          # General software arsenal (Pentesting, Dev, Personal)
    ./configs/newsboat.nix  # Newsboat RSS reader 
    ./configs/fcitx.nix     # Input method framework (multi-language support)
    ./configs/wordlists.nix # Wordlist overrides and ~/wordlist symlink setup
  ];
}

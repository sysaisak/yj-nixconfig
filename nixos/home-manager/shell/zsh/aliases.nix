{ ... }:
{
  programs.zsh.shellAliases = {
    ls = "ls --color=auto";
    ll = "ls -lah --color=auto";
    la = "ls -A --color=auto";
    sys-build = "cd ~/dots/nixos && git add . && sudo nixos-rebuild switch --flake '.#yuanjiao' && cd -";
  };
}

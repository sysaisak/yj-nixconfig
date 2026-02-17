{ config, pkgs, lib, ... }:

{
  programs.ssh = {
    enable = true;

    # Disable future default implicit config
    enableDefaultConfig = false;

    matchBlocks = {
      "*" = {
        forwardAgent = false;
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519";
      };

      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}

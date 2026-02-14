{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # System utilities
    git
    curl
    wget
    htop
    tree
    jq
    zip
    unzip
    nixfmt
    nixfmt-tree
    tealdeer

    # Core Unix tooling (recovery / scripts)
    coreutils
    findutils
    gnugrep
    gnused
    gawk
    file
    which
    moreutils

    # Networking (system-level)
    iproute2
    inetutils
    dnsutils

    # Build essentials (for drivers / nix / recovery)
    gcc
    gnumake
    cmake
    pkg-config

    # Containers (system-managed)
    podman
    podman-compose

    # Crypto
    openssl
    gnupg

    # Disk / diagnostics
    parted
    ntfs3g
    exfat
    lsof
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    proggyfonts
    dm-mono
    dm-mono
    source-code-pro
    nerd-fonts.jetbrains-mono
  ];

  documentation.nixos.enable = false;
}

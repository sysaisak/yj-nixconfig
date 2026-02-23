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

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      sarasa-gothic
      nerd-fonts.iosevka
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
      nerd-fonts.jetbrains-mono
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif CJK SC" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK SC" "Noto Sans" ];
        monospace = [ "Sarasa Mono SC" ];
      };
      
      # Better render (?)
      antialias = true;
      hinting.enable = true;
      hinting.style = "slight";
      subpixel.lcdfilter = "default";
    };
  };

  documentation.nixos.enable = false;
}

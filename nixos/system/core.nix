{ profile, pkgs, ... }:

{
  system.stateVersion = "25.11";

  # ----------------------------
  # Nix housekeeping
  # ----------------------------
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d"; # Cleaner way to manage space
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nixpkgs.config.allowUnfree = true;

  # ----------------------------
  # Bootloader (GRUB EFI)
  # ----------------------------
  boot.loader = {
    efi = {
      efiSysMountPoint = "/boot";
      canTouchEfiVariables = true;
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages;

  # ----------------------------
  # Networking
  # ----------------------------
  networking = {
    hostName = profile.hostName;
    networkmanager.enable = true;
  };

  # ----------------------------
  # Locale / Time
  # ----------------------------
  time.timeZone = profile.timeZone;
  i18n = {
    defaultLocale = profile.locale.default; # "en_US.UTF-8"
    extraLocales = profile.locale.extra;
  };

  # ----------------------------
  # User & Shell Configuration
  # ----------------------------

  # Enable both shells at system level so they are available
  programs.zsh.enable = true;
  programs.bash.completion.enable = true;

  # Set default shell based on Flake profile
  users.users.${profile.user} = {
    isNormalUser = true;
    # Dynamic shell selection
    shell = if profile.defaultShell == "zsh" then pkgs.zsh else pkgs.bash;
    extraGroups = [
      "wheel" # Sudo
      "networkmanager"
      "wireshark"
      "video" # GPU
      "podman"
    ];
  };

}

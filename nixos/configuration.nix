# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };
  };
  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "-d";
  };

  networking.hostName = "yuanjiao"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];

  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    open = false; # no open source driver
    #powerManagement.enable = true;  Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    #powerManagement.finegrained = true;
    #dynamicBoost.enable = true;
    nvidiaSettings = true;

    prime = {
      nvidiaBusId = "PCI:1:0:0"; # dedicated
      amdgpuBusId = "PCI:6:0:0"; # integrated
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.c0mbo = {
    isNormalUser = true;
    description = "c0mbo";
    extraGroups = [
      "networkmanager"
      "wheel"
      "podman"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # System utilities
    emacs
    git
    curl
    wget
    htop
    pciutils
    # Media
    obs-studio
    vlc
    ffmpeg_7
    # Adminpkgs
    podman
    podman-compose
    tree
    jq
    # Desktop apps
    telegram-desktop
    qbittorrent
    keepassxc
    # Dev
    jdk
    python3
    lua
  ];
  documentation.nixos.enable = false;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    proggyfonts
    dm-mono
    source-code-pro
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-chinese-addons
      #fcitx5-nord
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}

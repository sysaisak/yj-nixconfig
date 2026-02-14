{
  profile,
  pkgs,
  lib,
  ...
}:

{
  # dynamic user
  users.users.${profile.user} = {
    isNormalUser = true;
    description = profile.user;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "wireshark"
    ]
    ++ lib.optional profile.services.podman "podman";
  };

  #  services.openssh.enable = profile.services.ssh;
  services.openssh = {
    enable = profile.services.ssh;
    settings = {
      PermitRootLogin = "no";
      X11Forwarding = false;
    };
  };

  # Containers
  virtualisation = {
    containers.enable = profile.services.podman;
    podman = {
      enable = profile.services.podman;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # GPG / SSH agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Tor service
  services.tor = {
    enable = profile.services.tor;
    client.enable = true;
  };

  programs.wireshark = {
    enable = true;
    package = pkgs.tshark;
  };
}

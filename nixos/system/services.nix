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
    openFirewall = true;
  };

  # Firewall
  networking.firewall.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.tshark;
  };

  services.syncthing = {
    user = profile.user;
    enable = profile.services.syncthing;
    dataDir = "/home/${profile.user}/org";
    configDir = "/home/${profile.user}/.config/syncthing";

    openDefaultPorts = true;

    settings = {
      devices = {
	"realme" = { id = "QMQHIZ7-K47KW37-OGCODVK-YX3QF34-K2UASIM-R27AQ2I-4RCOA47-24A6QA3"; };
      };
      folders = {
	"Notas" = {
	  path = "/home/${profile.user}/org";
	  devices = [ "realme" ];
	};
      };
    };
  };
}

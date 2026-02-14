{
  config,
  lib,
  profile,
  pkgs,
  ...
}:

{
  virtualisation = {
    containers.enable = profile.services.podman;

    podman = lib.mkIf profile.services.podman {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    libvirtd = lib.mkIf profile.services.virtualization {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
      };
    };
  };

  users.users.${profile.user}.extraGroups = lib.mkIf profile.services.virtualization [ "libvirtd" ];
}

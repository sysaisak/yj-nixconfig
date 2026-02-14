{
  profile,
  pkgs,
  lib,
  ...
}:

let
  isXfce = profile.desktop == "xfce";
in
{
  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = isXfce;
    desktopManager.xfce.enable = isXfce;

    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Input devices
  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # Audio (PipeWire)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Input method
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-chinese-addons
    ];
  };
}

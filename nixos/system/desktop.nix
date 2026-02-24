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
}

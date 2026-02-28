{
  profile,
  pkgs,
  lib,
  ...
}:

let
  isXfce = profile.desktop == "xfce";
#  isDwm = profile.desktop == "dwm";
in
{
  services.xserver = {
    enable = true;

    displayManager.lightdm.enable = true;

    desktopManager.xfce.enable = isXfce;
#    windowManager.dwm.enable = isDwm;

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
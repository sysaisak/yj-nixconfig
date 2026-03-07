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

      displayManager.lightdm = {
	enable = true;
      
	greeters.gtk = {
          enable = true;
        
          theme = {
	    package = pkgs.magnetic-catppuccin-gtk.override {
              tweaks = [ "frappe" "macos" ];
            };
            name = "Catppuccin-GTK-Dark-Frappe"; 
          };

	  iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.catppuccin-papirus-folders.override {
              flavor = "frappe";
              accent = "mauve";
            };
          };

          cursorTheme = {
	    package = pkgs.simp1e-cursors;
            name = "Simp1e-Adw";
          };

          #draw-user-backgrounds = true; 
	};
	background = ../assets/cat-nixos.png;
      };
      # -----------------------------------------------

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

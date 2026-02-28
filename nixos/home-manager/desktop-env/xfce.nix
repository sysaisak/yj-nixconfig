{ profile, pkgs, lib, ... }:

lib.mkIf (profile.desktop == "xfce") {
  # Cursor theme
  home.pointerCursor = {
    name = "Simp1e-Adw";
    package = pkgs.simp1e-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    # GTK theme
    theme = {
      name = "catppuccin-GTK-Dark"; 
      package = pkgs.magnetic-catppuccin-gtk.override {
        tweaks = [ "frappe" "macos" ];
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "frappe";
        accent = "mauve"; 
      };
    };

    gtk3.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
    gtk4.extraConfig.Settings = ''gtk-application-prefer-dark-theme=1'';
  };

  xfconf.settings = {
    xsettings = {
      "Net/ThemeName" = "Catppuccin-GTK-Dark-Frappe";
      "Net/IconThemeName" = "Papirus-Dark";
      "Gtk/CursorThemeName" = "Simp1e-Adw";
      "Gtk/CursorThemeSize" = 24;       
    };

    "xfce4-keyboard-shortcuts" = {
      "commands/custom/<Primary><Alt>t" = "alacritty";
      "commands/custom/<Super>e" = "emacs";
      "commands/custom/<Super>w" = "firefox";
    };
  };
}
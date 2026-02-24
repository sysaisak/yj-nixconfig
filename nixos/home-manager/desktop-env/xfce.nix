{ pkgs, ... }:

{
  gtk = {
    enable = true;

    # 1. Tema de la interfaz (GTK)
    theme = {
      name = "catppuccin-frappe-mauve-standard"; 
      package = pkgs.catppuccin-gtk.override {
        variant = "frappe";
        accents = [ "mauve" ];
        size = "standard";
      };
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "frappe";
        accent = "mauve"; 
      };
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  # 3. Aplicar el tema a XFCE mediante xfconf
  xfconf.settings = {
    # xfwm4 = {
    #   "general/theme" = "catppuccin-frappe-mauve-standard";
    #   "general/use_compositing" = true;
    # };
    xsettings = {
      "Net/ThemeName" = "catppuccin-frappe-mauve-standard";
      "Net/IconThemeName" = "Papirus-Dark";
    };
  };
}

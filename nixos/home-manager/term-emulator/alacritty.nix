{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "catppuccin_frappe";

    settings = {
      window = {
        padding = {
          x = 12;
          y = 12;
        };
        opacity = 0.9;
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 13.0;
      };

      # ---------- Cursor config ----------
      cursor = {
        style = {
          shape = "Block";
          blinking = "Always";
        };
        blink_interval = 225;
        blink_timeout = 0;
        unfocused_hollow = false;

      };
      scrolling.history = 10000;
    };
  };
}

{ config, pkgs, lib, ... }:

{
  programs.newsboat = {
    enable = true;
    
    urls = [
      # --- Ciberseguridad ---
      { url = "https://hackstream.io/feed.xml"; tags = [ "ciberseguridad" ]; }
      { url = "https://www.bleepingcomputer.com/feed/"; tags = [ "ciberseguridad" ]; }
      { url = "https://thehackernews.com/rss.xml"; tags = [ "ciberseguridad" ]; }
      { url = "https://krebsonsecurity.com/feed/"; tags = [ "ciberseguridad" ]; }
      # --- Linux & Open Source ---
      { url = "https://nixos.org/blog/newsletters-rss.xml"; tags = [ "linux" "nix" ]; }
      { url = "https://fosspost.org/feed"; tags = [ "linux" "fosspost" ]; }
      # --- General / Tech ---
      { url = "https://hnrss.org/newest?points=50"; tags = [ "tech" ]; }

      # --- Youtube ---
      # mentalOutlaw
      { url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCgzsRmCl4BU-QmSVC4jFOlg"; tags = [ "youtube" "linux" ]; }
      # Linux Chad
      { url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCa-lsDvCuyK6ZmkRLDlnzsg"; tags = [ "youtube" "linux" ]; }
      # Cyberflow
      { url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCUvkPEm38w6pq8w5QYgtPPw"; tags = [ "youtube" "ciberseguridad" ]; }
      # Hacker Blueprint
      { url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC94vGd_fSmYlXQ5LbBfvIOQ"; tags = [ "youtube" "ciberseguridad" ]; }
      # La Chica de Sistemas
      { url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCzrFWz6KrJy-VOz6D7EoT4w"; tags = [ "youtube" "tech" "linux" ]; }
      
    ];

    autoReload = true;
    reloadTime = 60;
    
    extraConfig = ''
      browser "firefox"
      color listfocus yellow blue bold
      color info red black bold
      keep-articles-days 15
      # Opciones de interfaz
      datetime-format "%d/%m/%y %H:%M"
      show-keymap-hint yes
    '';
  };
}

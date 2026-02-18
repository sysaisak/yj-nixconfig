{ pkgs, profile, ... }:

{
  programs.firefox = {
    enable = true;

    profiles = {

      # =========================
      # PERFIL PERSONAL (DEFAULT)
      # =========================
      ${profile.user} = {
        id = 0;
        name = profile.user;
        isDefault = true;

        search = {
          force = true;
          default = "google";
          order = [
            "google"
            "nix-packages"
            "ddg"
          ];
          engines = {

            "google".metaData.alias = "@g";

            "nix-packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@np" ];
            };

            "bing".metaData.hidden = true;
            "ebay".metaData.hidden = true;
            "duckduckgo".metaData.hidden = true;
          };
        };

        settings = {
          "browser.startup.homepage" = "https://www.google.com";
          "general.smoothScroll" = true;
          "media.gmp-widevinecdm.enabled" = true;
          "media.gmp-gmpopenh264.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "browser.contentblocking.category" = "standard";
          "datareporting.policy.dataSubmissionEnable" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "extensions.pocket.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layout.css.devPixelsPerPx" = 1.1;
        };
      };

      # =========================
      # PERFIL GENERAL
      # =========================
      trabajo = {
        id = 1;
        name = "General";
        isDefault = false;

        search = {
          force = true;
          default = "ddg";
          order = [
            "ddg"
            "google"
          ];
        };

        settings = {
          "browser.startup.homepage" = "https://mail.google.com";
          "browser.contentblocking.category" = "strict";
          "browser.shell.checkDefaultBrowser" = false;
          "datareporting.policy.dataSubmissionEnable" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
        };
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always";
      EncryptedMediaExtensions.Enabled = true;

      ExtensionSettings = {
        "*".installation_mode = "allowed";

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "unhook@cenkbilkur.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}

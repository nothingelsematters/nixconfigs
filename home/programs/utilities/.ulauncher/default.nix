{ config, pkgs, ... }:

# TODO it is being fixed

with builtins;
with config.lib;
let
  configDir = "ulauncher";
  themeName = "custom";
  themeDir = "${configDir}/user-themes/${themeName}";
  themeFileName = "theme.css";
  themeGtk3FileName = "theme-gtk3.css";
in {
  home.packages = with pkgs; [ ulauncher librsvg ];

  lib.packages.launcher = {
    name = "ulauncher";
    cmd = "ulauncher-toggle";
    package = pkgs.ulauncher;
  };

  # TODO can't do anything, actually, why does it wanna write?

  systemd.user.services.ulauncher = {
    Unit = {
      Description = "application and more laucher";
      PartOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Restart = "on-abort";
      ExecStart = ''
        ${pkgs.nix}/bin/nix-shell -p ulauncher librsvg zsh --pure --run "zsh -c ulauncher"'';
    };
  };

  xdg.configFile = {
    "${configDir}/settings.json".text = toJSON {
      blacklisted-desktop-dirs = "/usr/share/locale:/usr/share/app-install"
        + ":/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5"
        + ":/usr/share/mimelnk";
      clear-previous-query = true;
      hotkey-show-app = "<Primary><Shift>question";
      render-on-screen = "mouse-pointer-monitor";
      show-indicator-icon = true;
      show-recent-apps = true;
      terminal-command = packages.terminal.name;
      theme-name = themeName;
    };

    "${configDir}/shortcuts.json".text = ''
      {
          "e9681325-275f-40b2-a915-4728a8605811": {
              "added": 1590100000.0,
              "cmd": "https://duckduckgo.com/?q=%s",
              "icon": "${
                fetchurl {
                  url =
                    "https://raw.githubusercontent.com/dhelmr/ulauncher-duckduckgo-bangs/master/icons/ddg_icon.png";
                  sha256 =
                    "0n0bhq7is04xyhfw64jkqq9chxvv07c42jjcyhzbc8rnclfyy1vg";
                }
              }",
              "id": "e9681325-275f-40b2-a915-4728a8605811",
              "is_default_search": true,
              "keyword": "ddg",
              "name": "duckduckgo",
              "run_without_argument": false
          }
      }
    '';

    "${configDir}/extensions.json".text = toJSON {
      "com.github.dhelmr.ulauncher-duckduckgo-bangs" = {
        id = "com.github.dhelmr.ulauncher-duckduckgo-bangs";
        url = "https://github.com/dhelmr/ulauncher-duckduckgo-bangs";
        updated_at = "2020-05-22T00:00:32.516707";
        last_commit = "efb7b3e6545dedb4d626a085c0480eddc3dd4ed2";
        last_commit_time = "2020-02-15T22:17:26";
      };
      "com.github.rkarami.ulauncher-gitmoji" = {
        id = "com.github.rkarami.ulauncher-gitmoji";
        url = "https://github.com/rkarami/ulauncher-gitmoji";
        updated_at = "2020-05-22T00:02:57.668703";
        last_commit = "59ad2d0aa89696d41a29ce0efc845f2138f47b6e";
        last_commit_time = "2019-09-26T13:21:43";
      };
    };

    "${themeDir}/manifest.json".text = toJSON rec {
      manifest_version = "1";
      name = themeName;
      display_name = name;
      extend_theme = if theme.isDark then "dark" else "light";
      css_file = themeFileName;
      "css_file_gtk_3.20+" = themeGtk3FileName;
      matched_text_hl_colors = {
        when_selected = theme.colors.text.secondary;
        when_not_selected = theme.colors.text.secondary;
      };
    };

    "${themeDir}/${themeGtk3FileName}".text = ''
      @import url("${themeFileName}");
    '' + functions.toCSS {
      ".input".caret-color = "@caret_color";
      # workaround for a bug in GTK+ < 3.20
      ".selected.item-box".border = "none";
    };

    # TODO shortcuts and title colors
    "${themeDir}/${themeFileName}".text = ''
      /**
       * App Window
       */
      @define-color bg_color ${theme.colors.background.primary};
      @define-color window_bg @bg_color;
      @define-color window_border_color ${theme.colors.text.secondary};
      @define-color prefs_backgroud ${theme.colors.background.primary};

      /**
       * Input
       */
      @define-color selected_bg_color ${theme.colors.background.selection};
      @define-color selected_fg_color lighter(${theme.colors.text.selection});
      @define-color input_color ${theme.colors.text.primary};
      @define-color caret_color darker(@input_color);

      /**
       * Result items
       */
      @define-color item_name ${theme.colors.text.primary};
      @define-color item_text ${theme.colors.text.disabled};
      @define-color item_box_selected ${theme.colors.background.selection};
      @define-color item_name_selected ${theme.colors.text.selection};
      @define-color item_text_selected ${theme.colors.text.disabled};
      @define-color item_shortcut_color ${theme.colors.text.secondary};
      @define-color item_shortcut_color_sel ${theme.colors.text.secondary};
      @define-color item_shortcut_shadow darker(@bg_color);
      @define-color item_shortcut_shadow_sel darker(@item_box_selected);
    '' + functions.toCSS rec {
      ".app" = {
        background-color = "@window_bg";
        border-color = "@window_border_color";
      };

      ".input".color = "@input_color";

      # Selected text in input
      ".input *:selected,\n.input *:focus,\n*:selected:focus" = {
        background-color = "alpha (@selected_bg_color, 0.9)";
        color = "@selected_fg_color";
      };

      ".item-text".color = "@item_text";
      ".item-name".color = "@item_name";

      ".selected.item-box" = rec {
        background-color = "@item_box_selected";
        border-left = "1px solid @window_border_color";
        border-right = border-left;
      };
      ".selected.item-box .item-text".color = "@item_text_selected";
      ".selected.item-box .item-name".color = "@item_name_selected";
      ".item-shortcut" = {
        color = "@item_shortcut_color";
        text-shadow = "1px 1px 1px @item_shortcut_shadow";
      };
      ".selected.item-box .item-shortcut" = {
        color = "@item_shortcut_color_sel";
        text-shadow = "1px 1px 1px @item_shortcut_shadow_sel";
      };

      ".prefs-btn".opacity = 0;
      ".prefs-btn:hover".background-color = "@prefs_backgroud";

      ".no-window-shadow".margin = "-20px";
    };
  };

}

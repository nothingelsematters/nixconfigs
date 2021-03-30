args@{ lib, pkgs, ... }:

{
  lib.theme = {
    colors = rec {
      background = rec {
        primary = "#1f2428";
        secondary = "#2f363d";
        disabled = "#2f363d";
        accent = "#717790";
        urgent = "#f44d4d";
        selection = secondary;
        inverted = text.primary;
      };
      text = rec {
        primary = "#e2e2e4";
        secondary = "#044289";
        disabled = "#5b5d67";
        urgent = background.urgent;
        inverted = background.primary;
        selection = primary;
      };
    };

    xresources = "";
    isDark = true;

    fonts = {
      notification = "Comfortaa";

      mono = {
        name = "Jetbrains Mono";
        package = pkgs.jetbrains-mono;
      };

      gtk = {
        name = "Ubuntu Regular 9.6";
        package = pkgs.ubuntu_font_family;
      };
    };

    icons = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    notification-icons = {
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };

    cursor = {
      size = 15;
      name = "Paper";
      package = pkgs.paper-icon-theme;
    };

    gtk = rec {
      name = "Materia-Custom";
      package = pkgs.materia-theme;
      # package = let stripHash = builtins.substring 1 (-1);
      # in with (import ./colors args);
      # pkgs.materia-theme.overrideAttrs (base: rec {
      #   version = "20200916";

      #   src = pkgs.fetchFromGitHub {
      #     owner = "nana-4";
      #     repo = base.pname;
      #     rev = "v${version}";
      #     sha256 = "0qaxxafsn5zd2ysgr0jyv5j73360mfdmxyd55askswlsfphssn74";
      #   };

      #   buildInputs = with pkgs; base.buildInputs ++ [ sassc inkscape optipng ];

      #   installPhase = ''
      #     patchShebangs *.sh scripts/*.sh src/*/*.sh
      #     sed -i install.sh \
      #       -e "s|if .*which gnome-shell.*;|if true;|" \
      #       -e "s|CURRENT_GS_VERSION=.*$|CURRENT_GS_VERSION=${
      #         lib.versions.majorMinor pkgs.gnome3.gnome-shell.version
      #       }|"
      #     sed -i change_color.sh \
      #       -e "s|\$HOME/\.themes|$out/share/themes|"
      #     ./change_color.sh -o '${name}' <(echo -e "BG=${
      #       stripHash colors.background.primary
      #     }\n \
      #       FG=${stripHash colors.text.primary}\n \
      #       MATERIA_VIEW=${stripHash colors.background.accent}\n \
      #       MATERIA_SURFACE=${stripHash colors.background.secondary}\n \
      #       HDR_BG=${stripHash colors.background.secondary}\n \
      #       HDR_FG=${stripHash colors.text.primary}\n \
      #       SEL_BG=${stripHash colors.background.selection}\n \
      #       ROUNDNESS=0\n \
      #       MATERIA_STYLE_COMPACT=True")
      #     rm $out/share/themes/*/COPYING
      #   '';
      # });
    };
  };
}

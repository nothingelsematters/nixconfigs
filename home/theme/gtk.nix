{ config, pkgs, ... }:

# TODO fix w/ Travis
with config.lib.theme;
# let stripHash = builtins.substring 1 (-1); in
{
  cursor = {
    size = 15;
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };

  gtk = rec {
    name = "Materia-Custom";
    package = pkgs.materia-theme;
    # package = (pkgs.materia-theme.overrideAttrs (base: rec {
    #   version = "20200320";

    #   src = pkgs.fetchFromGitHub {
    #     owner = "nana-4";
    #     repo = base.pname;
    #     rev = "v${version}";
    #     sha256 = "0g4b7363hzs7z9xghldlz9aakmzzp18hhx32frb6qxy04lna2lwk";
    #   };

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
    #     FG=${stripHash colors.text.primary}\n \
    #     MATERIA_VIEW=${stripHash colors.background.primary}\n \
    #     MATERIA_SURFACE=${stripHash colors.background.secondary}\n \
    #     HDR_BG=${stripHash colors.background.secondary}\n \
    #     HDR_FG=${stripHash colors.text.primary}\n \
    #     SEL_BG=${stripHash colors.background.selection}\n \
    #     ROUNDNESS=0\n \
    #     MATERIA_STYLE_COMPACT=True")
    #     rm $out/share/themes/*/COPYING
    #   '';
    # }));
  };
}

{ config, pkgs, lib, ... }:

with config.lib.theme;
let stripHash = builtins.substring 1 (-1);
in {
  cursor = {
    size = 15;
    name = "Paper";
    package = pkgs.paper-icon-theme;
  };

  gtk = rec {
    name = "Materia-Custom";
    # FIXME w/ travis & cachix
    package = pkgs.materia-theme;
    # (pkgs.materia-theme.overrideAttrs (base: {
    #   buildInputs = with pkgs; base.buildInputs ++ [ sassc librsvg optipng ];

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

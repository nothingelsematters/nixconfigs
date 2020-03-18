{ pkgs, lib, ... }:

let
  atomDirectory = ".atom";
  theme = import ../../theme { inherit pkgs lib; };
  cfg = import ./config.nix { inherit pkgs lib; };
  colors = theme.colors;
in {
  home = {
    packages = [ pkgs.atom ];

    # TODO extensions manager

    file = {
      "${atomDirectory}/config.cson".text = cfg;
      "${atomDirectory}/snippets.cson".source = ./snippets.cson;
      "${atomDirectory}/styles.less".text = ''
        atom-text-editor {
          background-color: ${colors.background.primary};
          color: ${colors.text.primary};
        }
      '';
      "${atomDirectory}/packages/atom-material-ui/styles/user-settings.less".text =
        ''
          @accent-color: ${colors.background.primary};
          @accent-text-color: ${colors.text.selection};
          @base-color: ${colors.background.primary};
          @background-color-selected: ${colors.background.selection};
          @syntax-background-color: ${colors.background.primary};
        '';
    };
  };
}

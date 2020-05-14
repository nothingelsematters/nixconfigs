arg@{ config, pkgs, lib, ... }:

with config.lib;
with config.lib.theme;
let atomDirectory = ".atom";
in {
  home = {
    packages = [ pkgs.atom ];

    file = {
      "${atomDirectory}/config.cson".text = import ./config.nix arg;
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

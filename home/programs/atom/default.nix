{ pkgs, lib, ... }:

let
  atomDirectory = ".atom";
  theme = import ../../theme { inherit pkgs lib; };
  colors = theme.colors;
  cfg = builtins.replaceStrings [ "editor:" ] [''
    editor:
        fontFamily: "${theme.fonts.mono.name}"''] (builtins.readFile ./config.cson);
in {
  home = {
    packages = [ pkgs.atom ];

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
        '';
    };
  };
}

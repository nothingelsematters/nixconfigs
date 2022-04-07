{ config, ... }:

{
  programs = {
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "zsh" "enhanced" "once" "fzf" ];
    };

    zsh = {
      shellAliases = {
        zz = "z -I";
        bd = "z -b";
      };

      initExtra = ''
        zcd() {
          _zlua $1 && ${config.lib.packages.editor.name} .
        }
      '';
    };
  };
}

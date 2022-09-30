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
        j = "_zlua";
        jj = "j -I";
        bd = "j -b";
      };

      initExtra = ''
        jcd() {
          _zlua $1 && ${config.lib.packages.editor.name} .
        }
      '';
    };
  };
}

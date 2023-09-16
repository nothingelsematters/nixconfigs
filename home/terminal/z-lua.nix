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
        jcode() {
          _zlua $1 && ${config.lib.packages.editor.command} .
        }
        jjcode() {
          jj $1 && ${config.lib.packages.editor.command} .
        }
      '';
    };
  };
}

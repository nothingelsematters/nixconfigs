{ config, ... }:

{
  home.sessionVariables._ZL_FZF_FLAG = ''
    --reverse --preview \"if [ -d {2} ]; then eza --color always --icons --tree --level 2 {2}; else bat --color always {2}; fi\"'';

  programs = {
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "zsh" "enhanced" "once" "fzf" ];
    };

    zsh = {
      shellAliases = {
        j = "_zlua";
        "j.fzf" = "j -I";
      };

      initExtra = ''
        j.code() {
          _zlua $1 && ${config.lib.packages.editor} .
        }
        j.fzf.code() {
          j.fzf $1 && ${config.lib.packages.editor} .
        }
      '';
    };
  };
}

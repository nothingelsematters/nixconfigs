{ config, ... }:

{
  home.sessionVariables._ZL_FZF_FLAG = "--reverse --preview 'if [ -d {2} ]; then eza --color always --icons --tree --level 2 {2}; else bat --color always {2}; fi'";

  programs = {
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "zsh"
        "enhanced"
        "once"
        "fzf"
      ];
    };

    zsh.shellAliases = with config.lib; {
      j = "_zlua";
      "j.fzf" = "j -I";
      "j.code" = "() { j $1 && ${packages.editor} . }";
      "j.fzf.code" = "() { j.fzf $1 && ${packages.editor} . }";
    };
  };
}

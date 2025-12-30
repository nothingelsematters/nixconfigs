{ config, ... }:

{
  home.sessionVariables._ZO_FZF_OPTS = "--reverse --preview 'if [ -d {2} ]; then eza --color always --icons --tree --level 2 {2}; else bat --color always {2}; fi'";

  programs = {
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    zsh.shellAliases = with config.lib; {
      j = "z";
      "j.fzf" = "zi";
      "j.code" = "() { j $1 && ${packages.editor} . }";
      "j.fzf.code" = "() { j.fzf $1 && ${packages.editor} . }";
    };
  };
}

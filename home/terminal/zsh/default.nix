{ pkgs, ... }:

{
  home.sessionVariables.TERM = "xterm";

  programs.zsh = {
    enable = true;
    autosuggestion = {
      enable = true;
      highlight = "fg=#a8a8a8,underline";
    };

    history = {
      expireDuplicatesFirst = false;
      ignoreDups = false;
    };
    historySubstringSearch.enable = true;

    initContent = builtins.readFile ./init-content.sh;

    shellGlobalAliases = {
      "..." = "../..";
      "...." = "../../..";
      "....." = "../../../..";
    };

    plugins = with pkgs; [
      {
        name = "you-should-use";
        src = zsh-you-should-use + /share/zsh/plugins/you-should-use;
      }
      {
        name = "fast-syntax-highlighting";
        src = zsh-fast-syntax-highlighting + /share/zsh/plugins/fast-syntax-highlighting;
      }
    ];
  };
}

{ pkgs, ... }:

{
  home.sessionVariables.TERM = "xterm";

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

    history = {
      expireDuplicatesFirst = false;
      ignoreDups = false;
    };
    historySubstringSearch.enable = true;

    initExtra = builtins.readFile ./init-extra.sh;

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
        src = zsh-fast-syntax-highlighting + /share/zsh/site-functions;
      }
    ];
  };
}

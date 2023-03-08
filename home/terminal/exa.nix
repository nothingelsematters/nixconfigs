{
  programs = {
    exa = {
      enable = true;
      icons = true;
      extraOptions = [
        "--header"
        "--no-user"
        "--no-permissions"
        "--group-directories-first"
      ];
    };

    zsh.shellAliases = {
      l = "exa --long";
      lg = "l --git";
      la = "l --all";
      tree = "l --tree";
      ll = "tree --level 2";
      lll = "tree --level 3";
    };
  };
}

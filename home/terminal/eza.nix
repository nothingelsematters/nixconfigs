{
  programs = {
    eza = {
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
      l = "eza --long --no-time --git";
      la = "l --all";
      tree = "l --tree";
      ll = "tree --level 2";
      lll = "tree --level 3";
    };
  };
}

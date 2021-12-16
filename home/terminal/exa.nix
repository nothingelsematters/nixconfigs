{
  programs = {
    exa.enable = true;

    zsh.shellAliases = {
      l = "exa -lh --no-user --no-permissions --group-directories-first";
      lg = "l --git";
      la = "l -a";
      tree = "l -T";
      ll = "tree -L 2";
      lll = "tree -L 3";
    };
  };
}

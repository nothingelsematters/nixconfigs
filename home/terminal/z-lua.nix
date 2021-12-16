{
  programs = {
    z-lua = {
      enable = true;
      enableZshIntegration = true;
      options = [ "zsh" "enhanced" "once" "fzf" ];
    };

    zsh.shellAliases = {
      zz = "z -I";
      bd = "z -b";
    };
  };
}

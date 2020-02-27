{ config, ... }:

{
  programs.z-lua = {
    enable = true;
    enableZshIntegration = true;
    options = [ "zsh" "enhanced" "once" "fzf" ];
  };
}

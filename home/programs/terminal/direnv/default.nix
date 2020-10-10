{ config, ... }:

{
  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
    enableZshIntegration = true;
  };
}

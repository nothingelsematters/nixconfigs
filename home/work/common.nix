{ config, lib, pkgs, ... }:

{
  imports = [ ../common ./starship.nix ];

  home = {
    packages = with pkgs; [ jdk11 maven kubernetes ];
    sessionVariables.JAVA_HOME = "${pkgs.jdk11}";
  };

  lib.theme.isDark = true;

  programs = {
    git.extraConfig.core.editor = "nano";

    zsh.plugins = [{
      name = "forgit";
      src = pkgs.inputs.forgit;
    }];
  };
}

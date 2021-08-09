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

    zsh = {
      shellAliases.mci = "mvn clean install -DskipTests";

      plugins = [{
        name = "forgit";
        src = pkgs.inputs.forgit;
      }];
    };
  };
}

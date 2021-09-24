{ config, lib, pkgs, ... }:

{
  imports = [
    ./starship.nix

    ../common/development/git.nix
    ../common/development/nix-packages.nix

    ../common/terminal/bat.nix
    ../common/terminal/direnv.nix
    ../common/terminal/fzf.nix
    ../common/terminal/htop.nix
    ../common/terminal/most.nix
    ../common/terminal/packages.nix
    ../common/terminal/packages-linux.nix
    ../common/terminal/starship.nix
    ../common/terminal/zsh.nix
  ];

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

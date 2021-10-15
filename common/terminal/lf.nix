{ config, pkgs, ... }:

{
  programs.lf = {
    enable = true;
    previewer.source = pkgs.writeShellScript "lf.sh" ''
      #!/bin/sh

      case "$1" in
          *.tar*) tar tf "$1";;
          *.zip) unzip -l "$1";;
          *) bat "$1";;
      esac
    '';
  };
}

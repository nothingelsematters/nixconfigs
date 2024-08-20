{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
    exclude = [
      "development/rust.nix"
      "development/packages.nix"
    ];
  };

  home.sessionPath = [ "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home" ];

  programs = {
    git = {
      userEmail = "simon.naumov@zalando.de";
      extraConfig = {
        url."ssh://git@github.bus.zalan.do/".insteadOf = "https://github.bus.zalan.do/";
      };
    };

    zsh = {
      shellAliases = {
        hms = "nix build .#work.activationPackage && ./result/activate";

        # zalando utils
        zkc = "zkubectl";
        zaws = "zalando-aws-cli";
      };

      initExtra = "eval \"$(zalando-aws-cli completion zsh)\"";
    };
  };
}

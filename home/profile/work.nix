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

  home.sessionPath = [
    "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"
    # ruby (iOS)
    "$HOME/.mint/bin"
    "$HOME/.rvm/bin"
  ];

  programs = {
    git = {
      userEmail = "simon.naumov@zalando.de";
      extraConfig = {
        credential."https://github.bus.zalan.do".username = "snaumov";
      };
    };

    zsh = {
      shellAliases = {
        hms = "nix build '.#work.activationPackage' && ./result/activate";

        # zalando utils
        zkc = "zkubectl";
        zawsc = "zalando-aws-cli";
      };

      initExtra = ''
        eval "$(zalando-aws-cli completion zsh)"
        eval "$(rbenv init - zsh)" # ruby (iOS)
      '';
    };
  };
}

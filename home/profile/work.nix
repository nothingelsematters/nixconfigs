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

  lib.packages.editor = "idea";

  home = {
    packages = with pkgs; [
      # man-in-the-middle proxy
      turbo.mitmproxy
    ];

    sessionPath = [
      # java
      "/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home"

      # ruby (iOS)
      "$HOME/.mint/bin"
      "$HOME/.rvm/bin"

      # zalando utils
      "$HOME/work/zalando-scripts"
    ];

    sessionVariables = {
      # nvm (TypeScript)
      "NVM_DIR" = "$HOME/.nvm";
      "NODE_EXTRA_CA_CERTS" = "/usr/local/share/ca-certificates/zalando-all.crt";
    };
  };

  programs = {
    git = {
      userEmail = "simon.naumov@zalando.de";
      extraConfig = {
        url."ssh://git@github.bus.zalan.do/".insteadOf = "https://github.bus.zalan.do/";
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

      initContent = ''
        eval "$(zalando-aws-cli completion zsh)"

        # ruby (iOS)
        eval "$(rbenv init - zsh)"

        # nvm (TypeScript)
        [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
        [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
      '';
    };
  };
}

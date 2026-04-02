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

  editorconfig = {
    settings."*.go" = {
      indent_size = 2;
      indent_style = "tab";
    };
  };

  home = {
    packages = with pkgs; [
      # man-in-the-middle proxy
      mitmproxy
    ];

    sessionPath = [
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
    git.settings.user.email = "simon.naumov@zalando.de";

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

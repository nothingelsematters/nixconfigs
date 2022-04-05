{ config, lib, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home = with pkgs; {
    sessionVariables = {
      OPENSSL_ROOT_DIR = "${openssl}";
      PKG_CONFIG_PATH = "$PKG_CONFIG_PATH:${openssl.dev}/lib/pkgconfig";
    };
    packages = [
      # building
      gcc
      cmake
      binutils
      openssl.dev
      openssl
      # devopsing
      etcd_3_4
      stable.dbeaver
      oracle-instantclient
    ];
  };

  programs = {
    zsh = {
      shellAliases.hms =
        "nix build .#work.activationPackage && ./result/activate";

      initExtra = ''
        if [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then
          . "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi

        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    };

    git = {
      userName = "Simon Naumov";
      userEmail = "s.d.naumov@tinkoff.ru";
    };
  };
}

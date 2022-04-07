{ config, lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
    recursive = true;
    includeFiles = true;
    exclude = [
      "development/docker.nix"
      "development/nix.nix"
      "development/python.nix"
      "profile"
      "terminal/kitty.nix"
    ];
  };

  home = with pkgs; {
    sessionVariables = {
      OPENSSL_ROOT_DIR = "${openssl}";
      PKG_CONFIG_PATH = "$PKG_CONFIG_PATH:${openssl.dev}/lib/pkgconfig";
      # install oracle client manually because of tnsnames.ora
      LD_LIBRARY_PATH =
        "$LD_LIBRARY_PATH:/usr/lib/oracle/21/client64/lib:${libaio}/lib";
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
      libaio # for oracle client
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

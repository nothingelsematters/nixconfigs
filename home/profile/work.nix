{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
    exclude = [ "development/packages.nix" "packages.nix" ];
  };

  programs = {
    git.userEmail = "s.d.naumov@tinkoff.ru";
    zsh.shellAliases.hms =
      "nix build .#work.activationPackage && ./result/activate";
  };

  home = with pkgs;
    let openssl_pkg = openssl_3_1;
    in {
      sessionVariables = {
        OPENSSL_ROOT_DIR = "${openssl_pkg}";
        PKG_CONFIG_PATH = "$PKG_CONFIG_PATH:${openssl_pkg.dev}/lib/pkgconfig";
        # install oracle client manually because of tnsnames.ora
        LD_LIBRARY_PATH =
          "$LD_LIBRARY_PATH:/usr/lib/oracle/21/client64/lib:${libaio}/lib";
      };

      packages = [
        # building
        gcc
        cmake
        binutils
        openssl_pkg.dev
        openssl_pkg
        turbo.zlib
        protobuf
        gawk
        cyrus_sasl

        # devopsing
        etcd_3_4
        stable.dbeaver
        libaio # for oracle client
        postgresql
      ];
    };
}

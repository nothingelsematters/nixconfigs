{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
    exclude = [ "development/packages.nix" "packages.nix" ];
  };

  programs = {
    git.userEmail = "s.d.naumov@tinkoff.ru";
    zsh.shellAliases = {
      hms = "nix build .#work.activationPackage && ./result/activate";

      "gl.mr.o" = "lab mr browse";
      "gl.mr.c" = ''
        () {
          lab mr create origin master -a s.d.naumov -m "$1" &&
            lab mr browse
        }'';
      "gl.mr.c.push" = "g.push && gl.mr.c";
    };
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
      turbo.zlib
      protobuf
      gawk

      # devopsing
      etcd_3_4
      stable.dbeaver
      libaio # for oracle client
      postgresql
    ];
  };
}

self:
super:

{
  redasm = super.stdenv.mkDerivation rec {
    name = "redasm-${version}";
    version = "2.0";

    src = super.fetchgit {
      url = "https://github.com/REDasmOrg/REDasm";
      rev = "b47ed30";
      sha256 = "0jjd0sfhbf2kgm57008qmhvrpgb9gpzxz41bmqv8cq2k39vcs6gk";
      fetchSubmodules = true;
    };

    buildInputs = with self; [cmake qt5.qtbase qt5.qtwebengine busybox];
    cmakeFlags = with self; ["-DCMAKE_BUILD_TYPE=Release"];

    postInstall = ''
      mkdir -p $out/bin
      mkdir -p $out/lib

      cp REDasm $out/bin
      cp LibREDasm.so $out/lib/
    '';
  };
}

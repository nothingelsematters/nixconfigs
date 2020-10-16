_: _:

{
  kotlin-jupyter-kernel = with self.pkgs;
    with python38Packages;
    buildPythonPackage rec {
      pname = "kotlin-jupyter-kernel";
      version = "0.8.2.61";

      src = python38.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "0mcaz4lv7zb0gw0i9zbd0cmxc41dnw344ggwj1wy9y40d627wdcq";
      };

      doCheck = false;
    };
}

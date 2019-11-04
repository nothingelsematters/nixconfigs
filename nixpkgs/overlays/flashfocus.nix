self:
super:

let

pytest_lazy_fixture = super.python3.pkgs.buildPythonPackage rec {
  pname = "pytest-lazy-fixture";
  version = "0.5.2";

  src = super.python3.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "190riklqdl4bpbwpvyd3bg6fqk4sm34kqvx14av5xdhlf0436y3q";
  };

  propagatedBuildInputs = with super.python3.pkgs; [ pytest ];
};

pytest_factoryboy = super.python3.pkgs.buildPythonPackage rec {
  pname = "pytest-factoryboy";
  version = "2.0.3";

  src = super.python3.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "06js78jshf81i2nqgf2svb8z68wh4m34hcqdvz9rj4pcvnvkzvzz";
  };

  propagatedBuildInputs = with super.python3.pkgs; [ pytest factory_boy inflection tox ];
};

xpybutil = super.python3.pkgs.buildPythonPackage rec {
  pname = "xpybutil";
  version = "0.0.6";

  src = super.fetchFromGitHub {
    owner = "BurntSushi";
    repo = "xpybutil";
    rev = "0.0.6";
    sha256 = "17gbqq955fcl29aayn8l0x14azc60cxgkvdxblz9q8x3l50w0xpg";
  };

  propagatedBuildInputs = with super.python3.pkgs; [ xcffib pillow ];
};

in

{ 
flashfocus = super.python3.pkgs.buildPythonApplication rec {
  pname = "flashfocus";
  version = "1.2.7";

  doCheck = false;

  src = super.python3.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "0n86561k7wzbbj7wk6lggv9laaalj3i6xb2zxq0l12q95d42f3vi";
  };

  propagatedBuildInputs = with super.python3.pkgs; [ pytest_factoryboy pytest pytestrunner marshmallow cffi xpybutil pyyaml click factory_boy pytest_lazy_fixture];
};
}

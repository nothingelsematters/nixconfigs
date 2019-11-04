self:
super:

{ 
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
}

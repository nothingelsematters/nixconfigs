{ pkgs, ... }:

{
  colors = rec {
    background = rec {
      primary        = "#fdf6e3"; # base3
      secondary      = "#eee8d5"; # base2
      disabled       = "#eee8d5"; # base2
      accent         = "#859900"; # green
      strong         = "#b58900"; # yellow
      urgent         = "#dc322f"; # red
      selection      = secondary;
      inverted       = text.primary;
    };
    text = rec {
      primary        = "#839496"; # base0
      disabled       = "#93a1a1"; # base1
      secondary      = "#6c77bb";
      urgent         = "#dc322f"; # nord11
      inverted       = background.primary;
      selection      = primary;
    };
  };
  xresources = builtins.readFile (
    pkgs.fetchFromGitHub {
      owner = "solarized";
      repo = "xresources";
      rev = "0c426297b558965d462f0e45f87eb16a10586c53";
      sha256 = "1h013bmcl8ba49wxcnxqgp4grma3d6zrsszr320wr6i7anl4fdln";
  } + "/Xresources.light");
  isDark = false;
}

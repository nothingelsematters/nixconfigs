{ pkgs, ... }:

{
  colors = rec {
    background = rec {
      primary        = "#383851";
      secondary      = "#222433";
      disabled       = "#434c5e";
      accent         = "#eceff4";
      strong         = "#88c0d0";
      urgent         = "#bf616a";
      selection      = secondary;
      inverted       = text.primary;
    };
    text = rec {
      primary        = "#b5b9c9";
      disabled       = "#4c566a";
      urgent         = "#bf616a";
      inverted       = background.primary;
      selection      = primary;
    };
  };
  xresources = builtins.readFile (
    pkgs.fetchFromGitHub {
       owner = "arcticicestudio";
       repo = "nord-xresources";
       rev = "5a409ca2b4070d08e764a878ddccd7e1584f0096";
       sha256 = "1b775ilsxxkrvh4z8f978f26sdrih7g8w2pb86zfww8pnaaz403m";
    } + "/src/nord");
  isDark = true;
}

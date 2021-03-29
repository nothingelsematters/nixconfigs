{ pkgs, ... }:

{
  colors = {
    background = rec {
      primary = "#2e3440"; # nord0
      secondary = "#3b4252"; # nord1
      disabled = "#434c5e"; # nord2
      accent = "#eceff4"; # nord6
      strong = "#88c0d0"; # nord8
      urgent = "#bf616a"; # nord11
      selection = secondary;
      inverted = text.primary;
    };
    text = rec {
      primary = "#d8dee9"; # nord4
      disabled = "#4c566a"; # nord3
      secondary = "#00b19f";
      urgent = "#bf616a"; # nord11
      inverted = background.primary;
      selection = primary;
    };
  };
  xresources = builtins.readFile (pkgs.fetchFromGitHub {
    owner = "arcticicestudio";
    repo = "nord-xresources";
    rev = "5a409ca2b4070d08e764a878ddccd7e1584f0096";
    sha256 = "1b775ilsxxkrvh4z8f978f26sdrih7g8w2pb86zfww8pnaaz403m";
  } + "/src/nord");
  isDark = true;
}

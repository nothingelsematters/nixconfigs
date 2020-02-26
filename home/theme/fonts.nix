{ pkgs, ... }:

{
  fonts = {
    notification = "Comfortaa";

    mono = {
      name = "Jetbrains Mono";
      package = pkgs.jetbrains-mono;
    };
    
    gtk = {
      name = "Ubuntu Regular 9.6";
      package = pkgs.ubuntu_font_family;
    };
  };
}

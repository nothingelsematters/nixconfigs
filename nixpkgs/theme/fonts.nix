{ pkgs, ... }:

{
  fonts = {
    mono = "Jetbrains Mono";
    notification = "Comfortaa";
    gtk = {
      name = "Ubuntu Regular 9.6";
      package = pkgs.ubuntu_font_family;
    };
  };
}

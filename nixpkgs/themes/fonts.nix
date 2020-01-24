{ pkgs, ... }:

{
  fonts = {
    mono = "Jetbrains Mono";
    notification = "Comfortaa";
    gtk = {
      name = "Ubuntu Regular";
      size = "9.6";
      package = pkgs.ubuntu_font_family;
    };
  };
}

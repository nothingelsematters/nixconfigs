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

  fontPkgs = with pkgs; [
    hack-font
    ubuntu_font_family
    font-awesome_4
    font-awesome
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    roboto
    roboto-slab
    roboto-mono
    material-icons
    comfortaa
    jetbrains-mono
  ];
}

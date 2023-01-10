{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # move and resize windows in macOS using keyboard shortcuts or snap areas
    rectangle
    # powerful macOS menu bar customization tool
    swiftbar
  ];
}

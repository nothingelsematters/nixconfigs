self: super:

{
  nixpkgs-wayland = import "${super.nixpkgs-wayland-sources}/default.nix" self super;
}

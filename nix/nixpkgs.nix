self: super:
let
  sources = import ../sources.nix;
  config = { allowBroken = false; };
  reliable-nixpkgs = import sources.reliable-nixpkgs { inherit config; };
  turbo-nixpkgs = import sources.turbo-nixpkgs { inherit config; };
in {
  nixpkgs-wayland =
    import "${super.nixpkgs-wayland-sources}/default.nix" self super;
}

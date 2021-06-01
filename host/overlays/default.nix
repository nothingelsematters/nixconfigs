{ config, inputs, lib, ... }:

{
  nixpkgs.overlays = map import (import ../../lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeFiles = true;
  }) ++ [
    (self: super: {
      turbo = inputs.nixpkgs-turbo.legacyPackages.x86_64-linux;
      stable = inputs.nixpkgs-stable.legacyPackages.x86_64-linux;
    })
  ];
}

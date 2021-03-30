{ lib, ... }:

{
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      "https://nixpkgs-wayland.cachix.org"
      "https://nothingelsematters.cachix.org"
      "https://quentini.cachix.org"
    ];
    binaryCachePublicKeys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nothingelsematters.cachix.org-1:zRZaHQgixucyZdxxClIKICy1QHtTFGeGng//uxspSPQ="
      "quentini.cachix.org-1:fgzasbBNj2JBTzzpLnpSfulnC06ImDvzYJEXiACwNkg="
    ];
  };
}

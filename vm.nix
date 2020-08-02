let sources = import nix/sources.nix;
in (import "${sources.nixpkgs}/nixos" {
  configuration = import ./configuration.nix;
}).vm

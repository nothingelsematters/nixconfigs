import "${(import ./nix/sources.nix).nixpkgs}/nixos" {
  configuration = ./configuration.nix;
}

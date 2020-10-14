# WARN: this file will get overwritten by $ cachix use <name>
{ lib, ... }:

let
  folder = ./.;
  toImport = name: _: folder + ("/" + name);
  filterCaches = key: value:
    value == "regular" && lib.hasSuffix ".nix" key && key != "default.nix";
  imports = lib.mapAttrsToList toImport
    (lib.filterAttrs filterCaches (builtins.readDir folder));
in {
  inherit imports;
  nix.binaryCaches = [ "https://cache.nixos.org/" ];
}

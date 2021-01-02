args@{ lib, pkgs, ... }:

{
  lib.theme = lib.trivial.pipe (import ../lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeFiles = true;
  }) [ (builtins.map (x: import x args)) (builtins.foldl' (x: y: x // y) { }) ];
}

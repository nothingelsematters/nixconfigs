args@{ lib, pkgs, ... }:

{
  lib.theme = lib.trivial.pipe (import ../lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeDirectories = false;
    includeFiles = true;
    additional = [ ./colors/dracula-mint.nix ];
  }) [ (builtins.map (x: import x args)) (builtins.foldl' (x: y: x // y) { }) ];
}

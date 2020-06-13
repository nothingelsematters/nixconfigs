args@{ pkgs, lib, ... }:

{
  lib.theme = lib.trivial.pipe (import <imports> {
    inherit lib;
    dir = ./.;
    includeDirectories = false;
    includeFiles = true;
    additional = [ ./colors/dracula-mint.nix ];
  }) [ (builtins.map (x: import x args)) (builtins.foldl' (x: y: x // y) { }) ];
}

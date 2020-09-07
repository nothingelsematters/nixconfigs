{ lib, ... }:

{
  imports = import ../home/lib/imports.nix {
    inherit lib;
    dir = ./.;
  };
}

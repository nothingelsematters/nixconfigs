{ lib, ... }:

{
  imports = import ../lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeFiles = true;
  };
}

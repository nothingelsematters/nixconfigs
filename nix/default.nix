lib:

map import (import ../lib/imports.nix {
  inherit lib;
  dir = ./.;
  includeFiles = true;
  exclude = [ "/cachix.nix" ];
})

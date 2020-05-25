lib:
builtins.map import (import ../home/lib/imports.nix {
  inherit lib;
  dir = ./.;
})

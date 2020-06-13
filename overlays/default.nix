lib:
builtins.map import (import <imports> {
  inherit lib;
  dir = ./.;
  includeFiles = true;
})

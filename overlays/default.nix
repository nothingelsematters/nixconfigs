lib:

with builtins;
with lib;
with attrsets;
let
  imports = import ../home/lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeFiles = true;
  };

  sources = import ../nix/sources.nix;
in trivial.pipe ../nix/sources.nix [
  import
  (filterAttrs (name: _: name != "__functor"))
  (mapAttrsToList (name: value: _: _: { "${name}" = value; }))
] ++ map import imports

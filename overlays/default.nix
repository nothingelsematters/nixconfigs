lib:

let
  imports = import ../home/lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeFiles = true;
  };

  sources = self: super:
    lib.trivial.pipe ../nix/sources.nix [
      import
      (lib.attrsets.filterAttrs (name: _: name != "__functor"))
    ];

in [ sources ] ++ builtins.map import imports

lib:

with builtins;
with lib;
with attrsets;
let
  imports = import ../home/lib/imports.nix {
    inherit lib;
    dir = ./.;
  };

  overlays = map import imports;

  nivSources = trivial.pipe ./sources.nix [
    import
    (filterAttrs (name: _: name != "__functor"))
    (mapAttrsToList (name: value: _: _: { "${name}" = value; }))
  ];
in nivSources ++ overlays

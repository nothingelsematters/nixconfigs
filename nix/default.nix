lib:

with builtins;
with lib;
with attrsets;
let
  imports = import ../lib/imports.nix {
    inherit lib;
    dir = ./.;
    includeFiles = true;
    exclude = [ "/cachix.nix" "/sources.nix" ];
  };

  overlays = map import imports;

  nivSources = trivial.pipe ./sources.nix [
    import
    (filterAttrs (name: _: name != "__functor"))
    (mapAttrsToList (name: value: _: _: { "${name}" = value; }))
  ];
in nivSources ++ overlays

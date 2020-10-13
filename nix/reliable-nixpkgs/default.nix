let
  sources = import ../sources.nix;
  reliable-nixpkgs =
    import sources.reliable-nixpkgs { config = { allowBroken = false; }; };
in with reliable-nixpkgs; _: _: { }

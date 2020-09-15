self: super:

let
  sources = import ../sources.nix;
  turbo-nixpkgs =
    import "${sources.turbo-nixpkgs}" { config = { allowBroken = false; }; };
in with turbo-nixpkgs; { }

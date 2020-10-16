_: super:

let nix-linter-sources = super.nix-linter;
in { nix-linter = import "${nix-linter-sources}/default.nix"; }

{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      (ghc.withHoogle (ps:
        with ps; [
          # building
          stack
          cabal2nix

          # coding
          hlint
          stylish-haskell

          # analyzing
          threadscope

          # libraries
          optparse-applicative
          directory
          Diff
          ncurses

          # testing
          criterion
          hedgehog
          hedgehog-fn
          tasty
          tasty-hedgehog
        ]))
    ];
}

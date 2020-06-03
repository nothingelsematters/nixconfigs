{ config, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      (ghc.withPackages (ps:
        with ps; [
          # building
          stack
          cabal2nix

          # coding
          hlint
          stylish-haskell

          # analyzing
          threadscope

          # ghci
          pretty-simple

          # sources
          unordered-containers
          directory
          optparse-applicative
          Diff
          microlens
          ListZipper
          ncurses

          # testing
          criterion
          hspec
          hedgehog
          hedgehog-fn
          tasty
          tasty-hedgehog
          tasty-hspec
        ]))
    ];

  home.file.".ghci".text = ''
    :set prompt "\ESC[0;34m\STX%s\n\ESC[1;31m\STX\x03BB> \ESC[m\STX"
    :set prompt-cont "|> "
    :set +s
    :set +m
    :set +t
    :set -Wall
    :set -Wno-type-defaults
    :set -package pretty-simple
    :set -interactive-print Text.Pretty.Simple.pPrint
  '';
}

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # markdown
    typora

    # c++
    gcc
    gdb
    cmake
    valgrind

    # kotlin
    kotlin

    # java
    jdk14
    maven
    antlr4

    # haskell
    (ghc.withPackages (ps:
      with ps; [
        # building
        stack
        cabal2nix

        # coding
        hlint
        stylish-haskell

        # sources
        unordered-containers
        directory
        optparse-applicative
        Diff

        # testing
        hspec
        hedgehog
        hedgehog-fn
        tasty
        tasty-hedgehog
        tasty-hspec
      ]))

    # python
    (python3.withPackages (ps: with ps; [ virtualenv pip ]))

    # python2
    (python2.withPackages (ps: with ps; [ pip ]))

    # javascript
    nodejs
    yarn

    # nix
    niv
    nixfmt
  ];
}

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ## editor
    typora

    ## languages related
    # c++
    gcc
    gdb
    cmake
    valgrind

    # kotlin
    kotlin

    # java
    jdk13
    maven
    antlr4

    # haskell
    (ghc.withPackages (ps:
      with ps; [
        # usefull
        unordered-containers
        directory
        optparse-applicative
        Diff

        # building
        stack
        cabal2nix
        stylish-haskell

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
  ];
}

{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # markdown
    typora
    mdcat

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

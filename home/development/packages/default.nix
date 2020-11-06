{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # markdown
    mdcat

    # c++
    gcc
    gdb
    cmake
    valgrind

    # kotlin
    kotlin
    ktlint

    # java
    jdk14
    maven
    antlr4

    # python
    (python3.withPackages (ps:
      with ps; [
        notebook
        ipykernel
        numpy
        matplotlib
        sklearn-deap
        tqdm
        ipywidgets
      ]))

    # python2
    (python2.withPackages (ps: with ps; [ pip ]))

    # javascript
    nodejs
    yarn

    # nix
    niv
    nixfmt
    cachix
    manix
    cached-nix-shell
    generation-diff

    # databases
    postgresql_12
  ];
}

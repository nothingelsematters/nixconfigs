{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    kt = "kotlin";
    ktc = "kotlinc";
    kts = "kotlinc -script";
    py = "python3";
  };

  home.packages = with pkgs; [
    # markdown
    mdcat

    # kotlin
    kotlin
    ktlint

    # java
    jdk14
    maven
    antlr4

    # c++
    gcc
    gdb
    cmake
    valgrind

    # rust
    rustup

    # nix
    niv
    nixfmt
    cachix
    manix
    cached-nix-shell
    generation-diff

    # databases
    postgresql_12

    # javascript
    nodejs
    yarn

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
  ];
}

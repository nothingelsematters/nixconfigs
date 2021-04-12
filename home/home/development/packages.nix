{ pkgs, ... }:

{
  programs.zsh.shellAliases = {
    kt = "kotlin";
    ktc = "kotlinc";
    kts = "kotlinc -script";
    rs = "rustc";
    py = "python3";
  };

  home.packages = with pkgs; [
    docker
    docker_compose
    subversion
    (texlive.combine { inherit (texlive) scheme-full latexmk; })

    # markdown
    mdcat

    # kotlin
    kotlin
    ktlint

    # java
    jdk15_headless
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

    # databases
    postgresql_13

    # javascript
    nodejs-14_x
    yarn

    # python
    (python3.withPackages (ps:
      with ps; [
        # jupyter
        notebook
        ipykernel
        tqdm
        ipywidgets

        # calculations
        numpy
        matplotlib
        pandas
        scikitlearn

        # formatter
        autopep8
      ]))
  ];
}

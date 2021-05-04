{ pkgs, nixpkgs-turbo, ... }:

{
  home.packages = with pkgs; [
    # java
    jdk16_headless
    maven
    antlr4

    # c++
    gcc
    gdb
    cmake
    valgrind

    # javascript
    nodejs-16_x
    yarn

    # databases
    postgresql_13

    # paper writing
    subversion
  ];
}

{ pkgs, nixpkgs-turbo, ... }:

{
  home.packages = with pkgs; [
    # java
    jdk16_headless
    maven
    antlr4

    # databases
    postgresql_13

    # paper writing
    subversion
  ];
}

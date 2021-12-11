{ pkgs, ... }:

{
  home.packages = with pkgs; [ jdk17_headless maven antlr4 ];
}

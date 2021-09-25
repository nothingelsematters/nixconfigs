{ pkgs, ... }:

{
  home.packages = with pkgs; [ jdk16_headless maven antlr4 ];
}

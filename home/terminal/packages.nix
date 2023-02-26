{ pkgs, ... }:

with pkgs; {
  home.packages = [
    ripgrep
    fd # rip find
    loc # count lines of code
    jq # processing JSON

    # archive
    zip
    unzip
  ];
}

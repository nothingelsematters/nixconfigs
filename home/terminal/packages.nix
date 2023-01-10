{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # rip grep
    ripgrep
    # rip find
    fd
    # count lines of code
    loc

    # make builder
    gnumake
    # processing JSON
    jq

    # archive
    zip
    unzip
  ];
}

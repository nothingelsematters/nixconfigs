{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # filesystem
    ripgrep # rip grep
    fd      # rip find
    loc     # count lines of code

    # utility
    gnumake # make builder
    jq      # processing JSON

    # archive
    zip
    unzip
  ];
}

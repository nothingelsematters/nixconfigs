{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # rip grep
    ripgrep
    # rip find
    fd
    # count lines of code
    loc
    # processing JSON
    jq
    # archive
    zip
    unzip
  ];
}

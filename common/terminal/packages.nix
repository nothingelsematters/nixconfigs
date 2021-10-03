{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # filesystem utility packages
    exa     # rip ls
    ripgrep # rip grep
    fd      # rip find
    lf      # terminal file manager
    loc     # count lines of code quickly
    wget    # download

    # utility packages
    gnumake # control the generation of non-source files from sources
    jq      # processing JSON inputs
    man     # on-line reference manuals

    # archive management
    zip   # package and compress archive files
    unzip # zip format extraction
  ];
}

{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # filesystem utility packages
    ripgrep # rip grep
    fd      # rip find
    loc     # count lines of code quickly

    # utility packages
    gnumake # control the generation of non-source files from sources
    jq      # processing JSON inputs
    man     # on-line reference manuals

    # archive management
    zip   # package and compress archive files
    unzip # zip format extraction
  ];
}

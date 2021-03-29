{ pkgs, ... }:

with pkgs; {
  home.packages = [
    # filesystem utility packages
    exa     # rip ls
    ripgrep # rip grep
    fd      # rip find
    lf      # terminal file manager
    file    # determine file type
    wget    # download

    # utility packages
    gnumake  # control the generation of non-source files from sources
    binutils # tools for manipulating binaries (linker, assembler, etc)
    jq       # processing JSON inputs

    # terminal helpful
    man    # on-line reference manuals
    tldr   # simplified man pages
    psmisc # fuser, killall and pstree...

    # archive management
    atool # archive command line helper
    zip   # package and compress archive files
    unzip # zip format extraction
  ];
}

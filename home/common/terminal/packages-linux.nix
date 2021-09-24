{ pkgs, ... }:

with pkgs; {
  home.packages = [
    exa # rip ls
    psmisc # fuser, killall and pstree...
  ];
}

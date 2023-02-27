{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd # rip find
    loc # count lines of code
    jq # processing JSON

    # archive
    zip
    unzip
  ];
}

{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd # rip find
    tokei # count lines of code
    jq # processing JSON
    yq # processing YAML

    # archive
    zip
    unzip
  ];
}

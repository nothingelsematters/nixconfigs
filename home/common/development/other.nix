{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # databases
    postgresql_13

    # paper writing
    subversion
  ];
}

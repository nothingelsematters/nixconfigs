{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ gcc gdb cmake valgrind ];
}

{ lib, ... }:

{
  imports = import <imports> {
    inherit lib;
    dir = ./.;
    includeFiles = true;
  };
}

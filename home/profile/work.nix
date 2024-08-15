{ lib, pkgs, ... }:

{
  imports = import ./import.nix {
    inherit lib;
    dir = ../.;
    exclude = [
      "development/rust.nix"
      "development/packages.nix"
    ];
  };

  programs = {
    git.userEmail = "simon.naumov@zalando.de";
    zsh.shellAliases.hms = "nix build .#work.activationPackage && ./result/activate";
  };
}

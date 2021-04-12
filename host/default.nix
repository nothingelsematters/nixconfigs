inputs@{ system, nixpkgs, nixpkgs-turbo, nixpkgs-stable, nixpkgs-wayland, home
, flake-utils, materialFox, nord-dircolors, forgit, vars, ... }:

with nixpkgs;
lib.nixosSystem rec {
  inherit system;

  specialArgs = { inherit inputs vars; };

  modules = import ../lib/imports.nix {
    inherit lib;
    dir = ./.;
    recursive = true;
    includeFiles = true;

    additional = [
      home.nixosModules.home-manager

      ../home/home

      ({ config, lib, ... }: {
        options.home-manager.users = lib.mkOption {
          type = with lib.types;
            attrsOf (submoduleWith {
              inherit specialArgs;
              modules = [ ];
            });
        };
      })
    ];
  };
}

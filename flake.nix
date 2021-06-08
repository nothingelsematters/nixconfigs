{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-21.05";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home.url = "github:nix-community/home-manager/master";
    flake-utils.url = "github:numtide/flake-utils";

    materialFox = {
      url = "github:muckSponge/materialFox";
      flake = false;
    };
    nord-dircolors = {
      url = "github:arcticicestudio/nord-dircolors";
      flake = false;
    };
    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };
  };

  outputs =
    inputs@{ nixpkgs, nixpkgs-turbo, nixpkgs-stable, home, forgit, ... }:
    let username = "simon";
    in rec {
      # home, NixOS
      nixosConfigurations.simyon = import ./host (inputs // {
        system = "x86_64-linux";
        vars.username = username;
      });

      # work, WSL Ubuntu
      homeManagerConfigurations = let
        makeWsl = file:
          home.lib.homeManagerConfiguration {
            inherit username;
            configuration = { pkgs, lib, ... }: {
              imports = [ file ];
              nixpkgs = {
                overlays = [ (self: super: { inherit inputs; }) ];
                config.allowUnfree = true;
              };
            };
            system = "x86_64-linux";
            homeDirectory = "/home/${username}";
          };
      in {
        wsl1 = makeWsl ./home/work/wsl-1.nix;
        wsl2 = makeWsl ./home/work/wsl-2.nix;
      };
    };
}

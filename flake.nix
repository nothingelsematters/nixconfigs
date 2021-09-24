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

      # home managers
      homeManagerConfigurations = let
        makeConfiguration = system: homeDirectory: file:
          home.lib.homeManagerConfiguration {
              inherit username system homeDirectory;
              configuration = { pkgs, lib, ... }: {
                imports = [ file ];
                nixpkgs = {
                  overlays = [ (self: super: { inherit inputs; }) ];
                  config.allowUnfree = true;
                };
              };
            };

        makeWsl = file:
          makeConfiguration "x86_64-linux" "/home/${username}" file;
      in {
        wsl1 = makeWsl ./home/work/wsl-1.nix;
        wsl2 = makeWsl ./home/work/wsl-2.nix;
        mac = makeConfiguration "aarch64-darwin" "/Users/simonnaumov/home" ./home/mac;
      };
    };
}

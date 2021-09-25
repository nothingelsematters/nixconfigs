{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-21.05";
    nixpkgs-fixed.url = "nixpkgs/ec81333c99894f6dd9b248efe617ff79482cc8f6";
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    home.url = "github:nix-community/home-manager/master";
    flake-utils.url = "github:numtide/flake-utils";

    materialFox = {
      url = "github:muckSponge/materialFox";
      flake = false;
    };
    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-turbo, nixpkgs-stable, nixpkgs-fixed, home
    , forgit, ... }:
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
                overlays = [
                  (self: super: {
                    inherit forgit;

                    turbo = import nixpkgs-turbo {
                      inherit system;
                      config.allowUnfree = true;
                    };

                    stable = import nixpkgs-stable {
                      inherit system;
                      config.allowUnfree = true;
                    };

                    fixed = import nixpkgs-fixed {
                      inherit system;
                      config.allowUnfree = true;
                    };
                  })
                ];
                config.allowUnfree = true;
              };
            };
          };

        makeWsl = file:
          makeConfiguration "x86_64-linux" "/home/${username}" file;
      in {
        wsl1 = makeWsl ./home/work/wsl-1.nix;
        wsl2 = makeWsl ./home/work/wsl-2.nix;
        mac =
          makeConfiguration "aarch64-darwin" "/Users/simonnaumov" ./home/mac;
      };
    };
}

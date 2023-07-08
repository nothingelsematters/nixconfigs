{
  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-23.05";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-turbo, nixpkgs-stable, home, ... }:
    let
      mkHomeConfig = { username, system, homePrefix, file }:
        let
          unfreeConfig = {
            inherit system;
            config.allowUnfree = true;
          };
        in home.lib.homeManagerConfiguration {
          pkgs = import nixpkgs (unfreeConfig // {
            overlays = [
              (_: _: {
                turbo = import nixpkgs-turbo unfreeConfig;
                stable = import nixpkgs-stable unfreeConfig;
              })
            ];
          });
          modules = [
            file
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix}/${username}";
                stateVersion = "23.05";
              };
            }
          ];
        };
    in rec {
      mac = mkHomeConfig {
        username = "simon";
        system = "aarch64-darwin";
        homePrefix = "/Users";
        file = ./home/profile/home.nix;
      };

      work = mkHomeConfig {
        username = "sdnaumov";
        system = "x86_64-linux";
        homePrefix = "/home";
        file = ./home/profile/work.nix;
      };
    };
}

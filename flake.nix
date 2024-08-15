{
  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-turbo,
      home,
      ...
    }:
    let
      mkHomeConfig =
        {
          username,
          homeDirectory,
          file,
        }:
        let
          unfreeConfig = {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
        in
        home.lib.homeManagerConfiguration {
          pkgs = import nixpkgs (
            unfreeConfig // { overlays = [ (_: _: { turbo = import nixpkgs-turbo unfreeConfig; }) ]; }
          );
          modules = [
            file
            {
              home = {
                inherit username homeDirectory;
                stateVersion = "24.05";
              };
            }
          ];
        };
    in
    rec {
      home = mkHomeConfig {
        username = "simon";
        homeDirectory = "/Users/simon";
        file = ./home/profile/home.nix;
      };

      work = mkHomeConfig {
        username = "snaumov";
        homeDirectory = "/";
        file = ./home/profile/work.nix;
      };
    };
}

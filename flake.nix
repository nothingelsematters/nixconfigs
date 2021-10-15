{
  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-21.05";
    nixpkgs-fixed.url = "nixpkgs/ec81333c99894f6dd9b248efe617ff79482cc8f6";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-turbo, nixpkgs-stable, nixpkgs-fixed, home
    , forgit, ... }:
    let
      overlay = system: self: super:
        let
          unfreeConfig = {
            inherit system;
            config.allowUnfree = true;
          };
        in {
          inherit forgit;
          turbo = import nixpkgs-turbo unfreeConfig;
          stable = import nixpkgs-stable unfreeConfig;
          fixed = import nixpkgs-fixed unfreeConfig;
        };
    in rec {
      mac = home.lib.homeManagerConfiguration rec {
        username = "simon";
        system = "aarch64-darwin";
        homeDirectory = "/Users/${username}";

        configuration = { pkgs, lib, ... }: {
          imports = [ ./home ];
          nixpkgs = {
            overlays = [ (overlay system) ];
            config.allowUnfree = true;
          };
        };
      };
    };
}

{
  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-21.11";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };
  };

  outputs =
    inputs@{ nixpkgs, nixpkgs-turbo, nixpkgs-stable, home, forgit, ... }:
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
        };

      mkHomeConfig = username: system: homePrefix: file:
        home.lib.homeManagerConfiguration rec {
          inherit username system;
          homeDirectory = "${homePrefix}/${username}";

          configuration = { pkgs, lib, ... }: {
            imports = [ file ];
            nixpkgs = {
              overlays = [ (overlay system) ];
              config.allowUnfree = true;
            };
          };
        };
    in rec {
      mac =
        mkHomeConfig "simon" "aarch64-darwin" "/Users" ./home/profile/home.nix;
      work =
        mkHomeConfig "sdnaumov" "x86_64-linux" "/home" ./home/profile/work.nix;
    };
}

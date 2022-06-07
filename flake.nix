{
  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-22.05";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    forgit = {
      url = "github:wfxr/forgit";
      flake = false;
    };
  };

  outputs = { nixpkgs, nixpkgs-turbo, nixpkgs-stable, home, forgit, ... }:
    let
      mkHomeConfig = username: system: homePrefix: file:
        let
          unfreeConfig = {
            inherit system;
            config.allowUnfree = true;
          };
        in home.lib.homeManagerConfiguration rec {
          inherit username system;
          homeDirectory = "${homePrefix}/${username}";
          configuration = import file;
          pkgs = import nixpkgs (unfreeConfig // {
            overlays = [
              (_: _: {
                inherit forgit;
                turbo = import nixpkgs-turbo unfreeConfig;
                stable = import nixpkgs-stable unfreeConfig;
              })
            ];
          });
        };
    in rec {
      mac =
        mkHomeConfig "simon" "aarch64-darwin" "/Users" ./home/profile/home.nix;
      work =
        mkHomeConfig "sdnaumov" "x86_64-linux" "/home" ./home/profile/work.nix;
    };
}

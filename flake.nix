{
  inputs = rec {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-22.11";

    home = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nixpkgs-turbo, nixpkgs-stable, home, ... }:
    let
      mkHomeConfig = username: system: homePrefix: file:
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
                stateVersion = "22.11";
              };
            }
          ];
        };
    in rec {
      mac =
        mkHomeConfig "simon" "aarch64-darwin" "/Users" ./home/profile/home.nix;
      work =
        mkHomeConfig "sdnaumov" "x86_64-linux" "/home" ./home/profile/work.nix;
    };
}

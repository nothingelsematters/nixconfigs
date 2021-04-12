{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-turbo.url = "nixpkgs/master";
    nixpkgs-stable.url = "nixpkgs/release-20.09";
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

  outputs = inputs@{ nixpkgs, nixpkgs-stable, nixpkgs-turbo, home, ... }: rec {
    nixosConfigurations.simyon = import ./host (inputs // {
      system = "x86_64-linux";
      vars.username = "simon";
    });
  };
}

{ config, inputs, lib, pkgs, ... }:

{
  system = {
    stateVersion = "20.09";
    # doesn't make sense with flakes
    autoUpgrade.enable = false;
  };

  sound.enable = true;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  nix = {
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;

    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixFlakes;
    registry.nixpkgs.flake = inputs.nixpkgs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      joypixels.acceptLicense = true;
    };
    overlays = import ../nix lib;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  fonts = {
    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "Jetbrains Mono" ];
        emoji = [ "Joypixels" ];
      };
    };

    fonts = with pkgs; [
      ubuntu_font_family
      font-awesome_4
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      joypixels
      material-icons
      comfortaa
      jetbrains-mono
    ];
  };
}

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
    ];

  boot = {
    # Use the systemd-boot EFI boot loader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
  };

  hardware = {
    enableAllFirmware = true;

    # Enable sound
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };

    opengl.driSupport32Bit = true;
  };

  system = {
    stateVersion = "19.09";
    autoUpgrade.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      libinput.enable = true;
      desktopManager.gnome3 = {
        enable = true;
      };
      displayManager.sddm.enable = true;
      layout = "us,ru";

      # adding i3
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };

    gnome3 = {
      at-spi2-core.enable = true;
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    zerotierone = {
      enable = true;
      joinNetworks = ["8bd5124fd62082f4"];
    };
  };
  fonts.fonts = with pkgs; [
    hasklig
    hack-font
    ubuntu_font_family
    font-awesome_4
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    roboto
    roboto-slab
    roboto-mono
    material-icons
  ];

  virtualisation.docker.enable = true;
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable sound.
  sound.enable = true;
}

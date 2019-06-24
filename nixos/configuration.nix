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
        stateVersion = "18.09"; # Did you read the comment?
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
        };

        gnome3.at-spi2-core.enable = true;
        printing = {
            enable = true;
            drivers = [ pkgs.brlaser ];
        };

        zerotierone = {
            enable = true;
            joinNetworks = ["8bd5124fd62082f4"];
        };

        /* mysql = {
            enable = true;
            package = pkgs.mariadb;
        }; */
    };

    virtualisation.docker.enable = true;
    networking.networkmanager.enable = true;
    nixpkgs.config.allowUnfree = true;

    # Set your time zone.
    time.timeZone = "Europe/Moscow";

    # Enable sound.
    sound.enable = true;

    # networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    # i18n = {
    #   consoleFont = "Lat2-Terminus16";
    #   consoleKeyMap = "us";
    #   defaultLocale = "en_US.UTF-8";
    # };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Enable the X11 windowing system.
    # services.xserver.enable = true;
    # services.xserver.layout = "us";
    # services.xserver.xkbOptions = "eurosign:e";
}
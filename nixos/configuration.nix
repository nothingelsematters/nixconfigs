{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ./users.nix ];

  boot = {
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

      libinput = {
        enable = true;
        naturalScrolling = true;
      };

      displayManager.lightdm = {
        enable = true;
        background = "${pkgs.nixos-artwork.wallpapers.mosaic-blue}"
          + "/share/artwork/gnome/nix-wallpaper-mosaic-blue.png";
        greeters.mini = {
          enable = true;
          user = "simon";
          extraConfig = ''
            [greeter]
            password-label-text = Slide to unlock:
            show-input-cursor = false
            font = "Fira Code Medium"

            [greeter-theme]
            background-image = ""
          '';
        };
      };

      layout = "us,ru";

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };
  };

  fonts = {
    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "Jetbrains Mono" ];
        emoji = [ "Twitter Color Emoji" "Noto Color Emoji" ];
      };
    };

    fonts = with pkgs; [
      ubuntu_font_family
      font-awesome_4
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      twitter-color-emoji
      fira-code
      fira-code-symbols
      material-icons
      comfortaa
    ];
  };

  virtualisation.docker.enable = true;
  networking.networkmanager.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Enable sound.
  sound.enable = true;
}

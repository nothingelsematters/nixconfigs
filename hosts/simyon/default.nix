{ config, pkgs, ... }:

let sources = import ../../nix/sources.nix;
in {
  imports = [ ./hardware.nix ../../home/simon.nix ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
      support32Bit = true;
    };

    opengl.driSupport32Bit = true;
  };

  system = {
    stateVersion = "20.03";
    autoUpgrade.enable = true;
  };

  sound.enable = true;
  networking.networkmanager.enable = true;

  nix = {
    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
  };

  time.timeZone = "Europe/Moscow";

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
      fira-code
      fira-code-symbols
      material-icons
      comfortaa
      jetbrains-mono
    ];
  };

  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export MOZ_ENABLE_WAYLAND="1"
    '';
  };

  # needed by sddm display manager themes
  environment.systemPackages = with pkgs.qt5; [ qtwayland qtgraphicaleffects ];

  services = {
    xserver = {
      enable = true;

      libinput = {
        enable = true;
        naturalScrolling = true;
      };

      layout = "us,ru";

      # TODO login logo
      displayManager = {
        sessionPackages = [ pkgs.sway ];
        sddm = let fetchedTheme = sources.sddm-theme-clairvoyance;
        in {
          enable = true;
          theme = with pkgs.lib;
            lists.last
            (strings.splitString "/" (builtins.toString fetchedTheme));
          extraConfig = ''
            [Theme]
            ThemeDir=${fetchedTheme}/..
            EnableAvatars=true
          '';
        };
      };

    };

    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
      ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
    '';
  };
}

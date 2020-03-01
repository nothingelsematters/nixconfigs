{ config, pkgs, ... }:

{
  imports = [ ./hardware.nix ./simon.nix ];

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
    stateVersion = "19.09";
    autoUpgrade.enable = true;
  };

  sound.enable = true;
  virtualisation.docker.enable = true;
  networking.networkmanager.enable = true;
  nix.autoOptimiseStore = true;

  time.timeZone = "Europe/Moscow";

  fonts = {
    fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = [ "Jetbrains Mono" ];
        emoji = [ "Twitter Color Emoji" ];
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
      jetbrains-mono
    ];
  };

  # needed by sddm display manager themes
  environment.systemPackages = [ pkgs.qt5.qtgraphicaleffects ];

  services = {
    xserver = {
      enable = true;

      libinput = {
        enable = true;
        naturalScrolling = true;
      };

      layout = "us,ru";

      displayManager.sddm = let
        fetchedTheme = pkgs.fetchFromGitHub {
          owner = "eayus";
          repo = "sddm-theme-clairvoyance";
          rev = "dfc5984ff8f4a0049190da8c6173ba5667904487";
          sha256 = "13z78i6si799k3pdf2cvmplhv7n1wbpwlsp708nl6gmhdsj51i81";
        };
      in {
        enable = true;
        theme = with builtins;
          let folders = split "/" (toString fetchedTheme);
          in elemAt folders (length folders - 1);

        extraConfig = ''
          [Theme]
          ThemeDir=${fetchedTheme}/..
          CursorTheme=Paper
        '';
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
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

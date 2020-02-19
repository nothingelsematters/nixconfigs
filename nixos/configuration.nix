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

  nixpkgs.config.allowUnfree = true;
  nix.autoOptimiseStore = true;

  time.timeZone = "Europe/Moscow";

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

  services = {
    xserver = {
      enable = true;

      libinput = {
        enable = true;
        naturalScrolling = true;
      };

      layout = "us,ru";

      displayManager.slim = {
        enable = true;
        defaultUser = "simon";
        theme = pkgs.fetchFromGitHub {
          owner = "adi1090x";
          repo = "slim_themes";
          rev = "8435cec00f5407a001813af2202dde9109186666";
          sha256 = "0i745r45rlgg84vl0b1s5klj9vy9phfy5wnklcmnrndxhw2jqjc0";
        } + "/themes/darky_pink";
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

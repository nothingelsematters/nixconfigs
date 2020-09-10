{ config, pkgs, ... }:

{
  imports = [ ./hardware.nix ../../home/simon.nix ../../services ];

  system = {
    stateVersion = "20.03";
    autoUpgrade.enable = true;
  };

  sound.enable = true;
  networking.networkmanager.enable = true;

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

  nix = {
    binaryCaches = [ "https://nothingelsematters.cachix.org" ];
    binaryCachePublicKeys = [
      "nothingelsematters.cachix.org-1:zRZaHQgixucyZdxxClIKICy1QHtTFGeGng//uxspSPQ="
    ];

    autoOptimiseStore = true;
    gc.automatic = true;
    optimise.automatic = true;
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';
}

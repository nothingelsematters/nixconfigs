{ config, pkgs, lib, ... }:

let
  theme = import ../../themes { inherit pkgs; };
  mkINI = import ../../themes/lib/mkINI.nix;
  cfg = builtins.readFile ./config.ini;
in
{
  services.polybar = {
    enable  = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    extraConfig = ''
      ${mkINI theme.colors}
      background-primary-opaque = ${"#EE" + builtins.substring 1 6 theme.colors.background.primary}
      ${cfg}
    '';
    script = "PATH=$PATH:${pkgs.i3}/bin:${pkgs.rofi}/bin:${pkgs.networkmanager_dmenu}/bin:${pkgs.bash}/bin"
      + " LABEL_CHARGING=\" %{F${theme.colors.text.primary}}%percentage%%%{F-}\""
      + " LABEL_MUTED=\" %{F${theme.colors.text.primary}}mute%{F-}\""
      + " LABEL_DISCONNECTED=\"%{A1:networkmanager_dmenu:} %{F${theme.colors.text.primary}}[not connected]%{F-}%{A}\""
      + " FORMAT_CONNECTED=\"%{A1:networkmanager_dmenu:}%{F${theme.colors.text.secondary}}  <ramp-signal> <label-connected>%{F-}%{A}\""
      + " polybar top &";
  };
}

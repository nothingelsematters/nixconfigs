{ config, pkgs, lib, ... }:

let
  theme = import ../../themes { inherit pkgs; };
  mkINI = import ../../themes/lib/mkINI.nix;
  cfg = builtins.readFile ./config;
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
      background-primary-opaque = ${"#66" + builtins.substring 1 6 theme.colors.background.primary}
      ${cfg}
    '';
    script = "PATH=$PATH:${pkgs.i3}/bin polybar bottom &";
  };

  xdg.configFile.mpris = {
    target = "polybar/mpris.sh";
    executable = true;
    text =
      ''
      #!${pkgs.bash}/bin/bash
      # Specifying the icon(s) in the script
      # This allows us to change its appearance conditionally
      icon=""

        player_status=$(${pkgs.playerctl}/bin/playerctl status 2> /dev/null)

      if [[ $? -eq 0 ]]; then
          metadata="$(${pkgs.playerctl}/bin/playerctl metadata artist 2> /dev/null) :: $(${pkgs.playerctl}/bin/playerctl metadata title 2> /dev/null)"
      fi

      # Foreground color formatting tags are optional
      if [[ $player_status = "Playing" ]]; then
          echo "%{F#eee}$icon $metadata"       # Orange when playing
      elif [[ $player_status = "Paused" ]]; then
          echo "%{F#d1d1d1}$icon $metadata"       # Greyed out info when paused
      else
          echo "%{F#65737E}$icon"                 # Greyed out icon when stopped
      fi
      '';
  };
}

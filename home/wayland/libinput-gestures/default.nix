{ pkgs, ... }:

let
  getScript = import ../../lib/getScript.nix { inherit pkgs; };
  focus = with pkgs; getScript ./focus.sh [ sway ripgrep gawk coreutils ];
in {
  home.packages = [ pkgs.libinput-gestures ];

  xdg.configFile."libinput-gestures.conf".text = ''
    # Move to next workspace
    gesture swipe left   ${focus} next

    # Move to prev workspace
    gesture swipe right  ${focus} prev

    # Focus next window
    gesture swipe up swaymsg focus right

    # Focus prev window
    gesture swipe down swaymsg focus left
  '';

  systemd.user.services.libinput-gestures = {
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      Restart = "on-abort";
    };
  };
}

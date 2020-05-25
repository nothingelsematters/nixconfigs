{ config, pkgs, ... }:

let
  focus = with pkgs;
    config.lib.functions.toScript "focus.sh" [ sway jq ] ''
      case $1 in
        "next")
            op="+ 1 - length"
            ;;
        "prev")
            op="- 1"
            ;;
        *)
            echo only "'prev'" and "'next'" are supported
            exit
            ;;
      esac
      swaymsg workspace $(swaymsg -t get_workspaces | jq -r ".[([.[].focused] | index(true)) $op].name")
    '';
in {
  xdg.configFile."libinput-gestures.conf".text = ''
    gesture swipe left  ${focus} next        # Move to next workspace
    gesture swipe right ${focus} prev        # Move to prev workspace
    gesture swipe up    swaymsg  focus right # Focus next window
    gesture swipe down  swaymsg  focus left  # Focus prev window
  '';

  systemd.user.services.libinput-gestures = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      Restart = "on-abort";
    };
  };
}

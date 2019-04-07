{ pkgs, ... }:

{
  systemd.user.services.background = {
    Unit = {
      Description = "Set desktop background using feh";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.feh}/bin/feh /home/quentin/Pictures/wallpaper.png --bg-fill";
      IOSchedulingClass = "idle";
    };

    Install = {
       WantedBy = [ "graphical-session.target" ];
    };
  };
}

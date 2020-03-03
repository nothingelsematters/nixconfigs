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
      ExecStart = "${pkgs.feh}/bin/feh ${./background.jpg} --bg-fill";
      IOSchedulingClass = "idle";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}

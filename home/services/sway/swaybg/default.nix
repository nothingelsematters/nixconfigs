{ config, pkgs, ... }:

{
  systemd.user.services.background = {
    Unit = {
      Description = "Set desktop background using feh";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${./background.jpg}";
      IOSchedulingClass = "idle";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}

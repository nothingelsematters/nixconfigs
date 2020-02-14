{ pkgs, ... }:

let backgroundPath = ".config/background.jpg";
in {
  home.file."${backgroundPath}".source = ./background.jpg;

  systemd.user.services.background = {
    Unit = {
      Description = "Set desktop background using feh";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.feh}/bin/feh ${backgroundPath} --bg-fill";
      IOSchedulingClass = "idle";
    };

    Install = { WantedBy = [ "graphical-session.target" ]; };
  };
}

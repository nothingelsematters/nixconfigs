{ config, pkgs, ...}:

{
  home.packages = [ pkgs.guake ];
  systemd.user.services.guake = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "on-abort";
    };
  };
}

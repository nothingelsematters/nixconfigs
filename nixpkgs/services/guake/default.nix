{ config, pkgs, ...}:

{
  home.packages = [
    (pkgs.guake.overrideAttrs (base: {
      propagatedBuildInputs = base.propagatedBuildInputs ++ [ pkgs.python37Packages.packaging ];
    }))
  ];
  systemd.user.services.guake = {
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
    Service = {
      Restart = "on-abort";
    };
  };
}

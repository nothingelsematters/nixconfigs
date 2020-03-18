{ config, pkgs, lib, ... }:

let theme = import ../../../theme { inherit pkgs lib; };
in {
  home.packages = with pkgs; [ mako ];

  xdg.configFile."mako/config".text = ''
    max-visible=5
    layer=top
    anchor=top-right
    border-size=0
    border-radius=7
    margin=3,5
    width=350
    height=100

    icons=1
    icon-path=${theme.notification-icons.package}/share/icons/Paper
    max-icon-size=32
    default-timeout=5000

    format=%s\n<small>%b</small>
    font=${theme.fonts.notification} 9
    sort=+time

    background-color=${theme.colors.background.secondary}
    text-color=${theme.colors.text.primary}
  '';

  systemd.user.services.mako = {
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-abort";
    };
  };
}

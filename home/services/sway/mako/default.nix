{ config, pkgs, lib, ... }:

let theme = import ../../../theme { inherit pkgs lib; };
in {
  home.packages = with pkgs; [ mako ];

  # TODO icons, icon-path???
  # TODO wtf why is it broken
  xdg.configFile."mako/config".text = ''
    max-visible=5
    layer=top
    anchor=top-right
    font=${theme.fonts.notification} 9
    sort=+time
    background-color=${theme.colors.background.secondary}
    text-color=${theme.colors.text.primary}
    border-size=0
    margin=0,5
    width=350
    height=100
    format=%s\n<small>%b</small>
  '';

  systemd.user.services.mako = {
    Install = { WantedBy = [ "graphical-session.target" ]; };
    Service = {
      ExecStart = "${pkgs.mako}/bin/mako";
      Restart = "on-abort";
    };
  };
}

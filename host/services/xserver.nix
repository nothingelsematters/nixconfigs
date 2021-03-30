{ pkgs, ... }:

{
  programs.sway = {
    enable = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export MOZ_ENABLE_WAYLAND="1"
    '';
  };

  # needed by sddm display manager themes
  environment.systemPackages = with pkgs.qt5; [ qtwayland qtgraphicaleffects ];

  services = {
    xserver = {
      enable = true;

      libinput = {
        enable = true;
        touchpad.naturalScrolling = true;
      };

      layout = "us,ru";

      displayManager = {
        sessionPackages = [ pkgs.sway ];
        sddm = {
          enable = true;
          theme = "clairvoyance";
          # extraConfig = ''
          #   [Theme]
          #   ThemeDir=${pkgs.sddm-theme-clairvoyance}/share
          #   EnableAvatars=true

          #   [Users]
          #   HideUsers=jupyter
          # '';
        };
      };
    };
  };

  boot.plymouth = {
    enable = true;
    theme = "red_loader";
    themePackages = [ pkgs.plymouth-theme-red-loader ];
  };
}

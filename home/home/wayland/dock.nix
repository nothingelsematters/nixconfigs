{ config, pkgs, inputs, ... }:

let
  configFileName = "lavalauncher/lavalauncher.conf";
  lavalauncher = inputs.nixpkgs-wayland.packages.x86_64-linux.lavalauncher;
in {
  home.packages = [ lavalauncher ];

  systemd.user.services.lavalauncher = {
    Unit = {
      Description = "Dock-like launcher";
      PartOf = [ "graphical-session.target" ];
    };

    Install.WantedBy = [ "graphical-session.target" ];

    Service = {
      Restart = "on-abort";
      ExecStart = with pkgs;
        with config;
        # TODO replace $PATH hardcode
        lib.functions.toScript "lavalauncher.sh" [ ]
        ("export PATH=/home/simon/.yarn/bin/" + ":${kitty}/bin"
          + ":${imagemagick}/bin"
          + ":/nix/store/h0d22zybfmklxmalv0g9ccbncsmwn8ml-xsel-unstable-2019-08-21/bin"
          + ":/nix/store/ncgqkpqj9gjaz6abxlwv15jpdn2nc818-ncurses-6.2-dev/bin"
          + ":${swaybg}/bin:/run/wrappers/bin:/home/simon/.nix-profile/bin"
          + ":/etc/profiles/per-user/simon/bin:/nix/var/nix/profiles/default/bin"
          + ":/run/current-system/sw/bin"
          + ":/home/simon/.zsh/plugins/nix-zsh-completions"
          + ":/home/simon/.zsh/plugins/you-should-use"
          + ":/home/simon/.zsh/plugins/fast-syntax-highlighting"
          + ":/home/simon/.zsh/plugins/command-time"
          + ":/home/simon/.zsh/plugins/forgit" + ''

            ${lavalauncher}/bin/lavalauncher -c ${xdg.configHome}/${configFileName}
          '');
    };
  };

  xdg.configFile.${configFileName}.text = let
    appButton = name: cmd: ''
      button
      {
        image-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/apps/${name}.svg";
        command = "${cmd}";
      }
    '';
    appButton' = name: appButton name name;
  in with config.lib.theme.colors; ''
    bar
    {
      output = eDP-1;
      position = bottom;
      background-colour = "#AAAAAA22";
      hidden-size = 2;
      border = 0;
      radius = 10;
      size = 45;
      icon-padding = 5;
      exclusive-zone = false;
      layer = top;
      indicator-hover-colour = "#AAAAAA22";
      indicator-active-colour = "#AAAAAA22";

      ${appButton "applications-all" config.lib.packages.launcher.cmd}

      spacer {
        length = 10;
      }

      ${appButton' "firefox"}
      ${appButton "telegram" "telegram-desktop"}
      ${appButton' "spotify"}
      ${appButton "visual-studio-code" "code"}
      ${appButton' "slack"}
      ${appButton "libreoffice6.4-writer" "libreoffice"}
      ${appButton "utilities-x-terminal" config.lib.packages.terminal.name}
      ${appButton "htop" "kitty htop"}
    }
  '';
}

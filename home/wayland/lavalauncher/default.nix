{ config, pkgs, ... }:

let
  configFileName = "lavalauncher/lavalauncher.conf";
  lavalauncher = pkgs.nixpkgs-wayland.lavalauncher;
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
      ExecStart = with config;
      # TODO replace $PATH hardcode
        lib.functions.toScript "lavalauncher.sh" [ ]
        ("export PATH=/home/simon/.yarn/bin/"
          + ":/nix/store/r06lylxjyav7pc2if6qvls91d9c9x25v-kitty-0.18.3/bin"
          + ":/nix/store/cdy8ib4zn70x81p8n8j9da7qwby33b9n-imagemagick-6.9.11-14/bin"
          + ":/nix/store/h0d22zybfmklxmalv0g9ccbncsmwn8ml-xsel-unstable-2019-08-21/bin"
          + ":/nix/store/ncgqkpqj9gjaz6abxlwv15jpdn2nc818-ncurses-6.2-dev/bin"
          + ":/nix/store/cbh69vrnybyfvx4phhjmjqyn0y8vwfd7-swaybg-1.0/bin"
          + ":/run/wrappers/bin" + ":/home/simon/.nix-profile/bin"
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
        image-path "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark/16x16/apps/${name}.svg";
        command "${cmd}";
      }
    '';
    appButton' = name: appButton name name;
  in with config.lib.theme.colors; ''
    global-settings
    {
      watch-config-file true;
    }

    bar
    {
      output eDP-1;
      position bottom;
      background-colour "#00000000";
      hidden-size 1;
      border 0 0 2 0;
      radius 0;
      size 45;
      icon-padding 5;
      exclusive-zone false;
      layer top;
      indicator-hover-colour "${background.secondary}BA";
      indicator-active-colour "${text.secondary}D0";

      ${appButton' "firefox"}
      ${appButton "telegram" "telegram-desktop"}
      ${appButton' "spotify"}
      ${appButton "visual-studio-code" "code"}
      ${appButton "utilities-x-terminal" config.lib.packages.terminal.name}
      ${appButton "htop" "kitty htop"}
    }
  '';
}

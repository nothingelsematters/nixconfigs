{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs lib; };
  mkINI = import ../../theme/lib/mkINI.nix;
  getScript = import ../../lib/getScript.nix { inherit pkgs lib; };
  cfg = builtins.readFile ./config.ini;
  height = "22";

  bin = x: builtins.concatStringsSep ":" (builtins.map (y: y + "/bin") x);
  i3w-folder = ".config/polybar/i3-windows";
  modulePath = i3w-folder + "/module.py";
  commandPath = i3w-folder + "/command.py";
  python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]);

  addVars = with builtins;
    file: vars:
    let
      lines = filter isString (split "\n" (readFile file));
      isPrefix = prefix: str:
        stringLength prefix <= stringLength str
        && substring 0 (stringLength prefix) str == prefix;
      snd = x: elemAt x 1;
      folder = x: y:
        if head x then [
          true
          (snd x ++ [ y ])
        ] else
          (if (y == "" || isPrefix "import " y || isPrefix "from " y) then [
            false
            (snd x ++ [ y ])
          ] else [
            true
            (snd x ++ [ vars y ])
          ]);
      patched = foldl' folder [ false [ ] ] lines;
    in concatStringsSep "\n" (snd patched);

  calendarPopup = with pkgs;
    getScript ./. "calendar-popup.sh" [ [ yad "yad" ] [ xdotool "xdotool" ] ];
in {
  home = {
    packages = [ pkgs.yad ];

    file = {
      "${commandPath}".source = ./i3-windows/command.py;
      "${modulePath}".text = addVars ./i3-windows/module.py ''
        focused = '${theme.colors.text.secondary}'
        wfocused = '${theme.colors.text.primary}'
        unfocused = '${theme.colors.text.disabled}'
        urgent = '${theme.colors.text.urgent}'

        empty = ''
        ICON_FONT = 3
        COMMAND = 'python3 ${commandPath}'
        ICONS = [
            ('class=Firefox', ''),
            ('class=Telegram', ''),
            ('class=Slack', ''),
            ('class=Atom', ''),
            ('class=Alacritty', ''),
            ('class=kitty', ''),
            ('class=Typora', ''),
            ('class=libreoffice*', ''),
            ('class=Evince', ''),
            ('*', ''),
        ]
      '';
    };
  };

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    script = with pkgs;
      "PATH=$PATH:${
        bin [
          i3
          rofi
          alacritty
          htop
          networkmanager_dmenu
          bash
          python
          networkmanager
          ripgrep
          rofi
        ]
      } polybar top &";

    extraConfig = let
      action = cmd: text: "%{A1:${cmd}:}${text}%{A}";
      color = cl: text: "%{F${cl}}${text}%{F-}";

      hook = x: "polybar-msg hook network-details ${x}";
      wifi = x: color theme.colors.text.secondary (action (hook x) "");
      switch = turn: icon:
        ''echo "${action "(nmcli radio wifi ${turn} && ${hook "2"}) &" icon}"'';
      on = switch "off" "";
      off = switch "on" "";
      toggled =
        "$(if [[ `nmcli general status | rg disabled` ]]; then ${off}; else ${on}; fi;)";
      menu = action "(networkmanager_dmenu && ${hook "1"}) &" "";
      options = color theme.colors.text.disabled ''"${toggled}" ${menu}'';
    in ''
      ${mkINI theme.colors}

      [tricks]
      font-notification = ${theme.fonts.notification}:pixelsize=9;1
      charging =  ${color theme.colors.text.primary "%percentage%%"}
      muted =  ${color theme.colors.text.primary "mute"}
      connected = ${
        action "networkmanager_dmenu &" "<ramp-signal> <label-connected>"
      }
      time = ${action "${calendarPopup} ${height} &" "%a %H:%M"}
      height = ${height}
      i3w-exec = ${python}/bin/python3 ${modulePath}
      apps = ${color theme.colors.text.secondary (action "rofi -show &" "")} ${
        color theme.colors.text.primary " │ "
      }

      network-details-hook-0 = echo "${wifi "2"}"
      network-details-hook-1 = echo "${wifi "1"} ${options}"

      ${cfg}
    '';
  };
}

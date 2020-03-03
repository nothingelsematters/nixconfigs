{ config, pkgs, lib, ... }:

let
  theme = import ../../theme { inherit pkgs lib; };
  vars = import ../../lib/variables.nix { inherit pkgs; };
  i3-windows = import ./i3-windows { inherit pkgs lib; };
  getScript = import ../../lib/getScript.nix { inherit pkgs; };
  height = builtins.toString vars.bar-height;

  calendarPopup = with pkgs; getScript ./calendar-popup.sh [ yad xdotool ];
in {
  home.packages = [ pkgs.yad ];

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
    };
    script = let
      PATH = with pkgs;
        stdenv.lib.makeBinPath [
          i3
          rofi
          vars.terminal.package
          htop
          networkmanager_dmenu
          bash
          python
          networkmanager
          ripgrep
          rofi
        ];
    in "PATH=$PATH:${PATH} polybar top &";

    config = let
      colors = theme.colors // {
        trans = "#00000000";
        red = "#EC7875";
        green = "#1FA789";
        yellow = "#EBD369";

        icons = theme.colors.text.secondary;
        textColor = theme.colors.text.primary;
        pale = theme.colors.text.disabled;
      };

      action = cmd: text: "%{A1:${cmd}:}${text}%{A}";
      colorize = cl: text: "%{F${cl}}${text}%{F-}";

      hook = x: "polybar-msg hook network-details ${x}";
    in {
      "bar/top" = {
        monitor = "eDP-1";
        bottom = false;
        width = "100%";
        height = height;
        radius = 3;
        fixed-center = true;
        enable-ipc = true;

        background = colors.trans;
        foreground = colors.text.primary;

        line-size = 1;
        line-color = colors.text.primary;

        border-top-size = 4;
        border-bottom-size = 0;
        border-left-size = 10;
        border-right-size = 10;
        border-color = colors.trans;

        padding-right = 1;

        module-margin-left = 0;
        module-margin-right = 1;

        font-0 = "${theme.fonts.notification}:pixelsize=9;1";
        font-1 = "Font Awesome 5 Brands:pixelsize=9;1";
        font-2 = "Font Awesome 5 Free:pixelsize=9;1";
        font-3 = "Font Awesome 5 Free Solid:pixelsize=9;1";
        font-4 = "Fira code medium:pixelsize=8;0";
        font-5 = "noto-fonts-emoji:pixelsize=4;1"; # TODO emoji font

        modules-left = "apps i3-windows window-title";
        modules-center = "date";
        modules-right = "xkeyboard volume battery network-details network cpu";

        tray-position = "none";
      };

      settings.screenchange-reload = true;

      "global/wm".margin-bottom = 0;

      "module/apps" = {
        type = "custom/text";
        content =
          "${colorize colors.text.secondary (action "rofi -show &" "")} ${
            colorize colors.text.primary " │ "
          }";
      };

      "module/i3-windows" = i3-windows.module;

      "module/window-title" = {
        type = "internal/xwindow";

        label = " │  %title%";
        label-maxlen = 70;

        format-foreground = colors.textColor;
      };

      "module/date" = {
        type = "internal/date";

        interval = "1.0";
        date = "";
        time = action "${calendarPopup} ${height} &" "%a %H:%M";

        label = "%time%";
        label-foreground = colors.textColor;
        format = "<label>";
        format-foreground = colors.icons;
        format-padding = 2;
      };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist-0 = "num lock";

        format-prefix = "  ";
        format-prefix-foreground = colors.icons;
        format-prefix-underline-size = 0;
        label-layout = "%layout%";
        label-layout-foreground = colors.textColor;
        label-layout-underline-size = 0;
      };

      "module/volume" = {
        type = "internal/alsa";

        format-volume = "<ramp-volume>  <label-volume>";
        format-muted = "<label-muted>";
        label-volume = "%percentage%%";
        label-volume-foreground = colors.textColor;
        label-muted = " ${colorize colors.text.primary "mute"}";
        label-muted-foreground = colors.icons;
        format-volume-padding = 1;
        format-muted-padding = 1;

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        ramp-volume-foreground = colors.icons;
        ramp-headphones-0 = "";
      };

      "module/battery" = {
        type = "internal/battery";

        full-at = 99;

        battery = "BAT0";
        adapter = "AC0";

        poll-interval = 5;

        format-charging = "<label-charging>";
        format-discharging = "<ramp-capacity>  <label-discharging>";
        format-full = "<ramp-capacity>  <label-full>";

        label-charging = " ${colorize colors.text.primary "%percentage%%"}";
        label-charging-foreground = colors.green;
        label-discharging = "%percentage%%";
        label-discharging-foreground = colors.textColor;

        label-full = "%percentage%%";
        format-charging-padding = 1;
        format-discharging-padding = 1;
        format-full-padding = 1;

        ramp-capacity-0 = "";
        ramp-capacity-0-foreground = colors.red;
        ramp-capacity-1 = "";
        ramp-capacity-1-foreground = colors.yellow;
        ramp-capacity-2 = "";
        ramp-capacity-2-foreground = colors.green;
        ramp-capacity-3 = "";
        ramp-capacity-3-foreground = colors.green;
        ramp-capacity-4 = "";
        ramp-capacity-4-foreground = colors.green;
        ramp-capacity-5 = "";
        ramp-capacity-5-foreground = colors.green;
        ramp-capacity-6 = "";
        ramp-capacity-6-foreground = colors.green;
        ramp-capacity-7 = "";
        ramp-capacity-7-foreground = colors.green;
        ramp-capacity-8 = "";
        ramp-capacity-8-foreground = colors.green;
        ramp-capacity-9 = "";
        ramp-capacity-9-foreground = colors.green;
      };

      "module/network-details" = let
        wifi = x: colorize colors.text.secondary (action (hook x) "");
        switch = turn: icon:
          ''
            echo "${
              action "(nmcli radio wifi ${turn} && ${hook "2"}) &" icon
            }"'';

        toggled = "$(if [[ `nmcli general status | rg disabled` ]]; then ${
            switch "on" ""
          }; else ${switch "off" ""}; fi;)";
        menu = action "(networkmanager_dmenu && ${hook "1"}) &" "";
        options = colorize colors.text.disabled ''"${toggled}" ${menu}'';
      in {
        type = "custom/ipc";
        hook-0 = ''echo "${wifi "2"}"'';
        hook-1 = ''echo "${wifi "1"} ${options}"'';
        initial = 1;
      };

      "module/network" = {
        type = "internal/network";
        interface = "wlp3s0";
        interval = "2.0";

        format-connected =
          action "networkmanager_dmenu &" "<ramp-signal> <label-connected>";
        format-disconnected = "<label-disconnected>";
        format-packetloss = "<label-connected>";

        ramp-signal-0 = "";
        ramp-signal-1 = "";
        ramp-signal-2 = "";
        ramp-signal-3 = "";
        ramp-signal-4 = "";
        ramp-signal-5 = "";

        label-connected = "%essid%";
        label-disconnected = "%{A1:networkmanager_dmenu &:} %{A}";

        label-connected-foreground = colors.textColor;
        label-disconnected-foreground = colors.pale;
        ramp-signal-foreground = colors.pale;
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 1;

        format =
          "%{A1:${vars.terminal.name} -e htop &:}   <ramp-coreload>%{A}";
        format-foreground = colors.icons;
        format-padding = 1;
        label-foreground = colors.icons;

        ramp-coreload-spacing = 1;
        ramp-coreload-0 = "▁";
        ramp-coreload-1 = "▂";
        ramp-coreload-2 = "▃";
        ramp-coreload-3 = "▄";
        ramp-coreload-4 = "▅";
        ramp-coreload-5 = "▆";
        ramp-coreload-6 = "▇";
        ramp-coreload-7 = "█";
        ramp-coreload-0-foreground = colors.green;
        ramp-coreload-1-foreground = colors.green;
        ramp-coreload-2-foreground = colors.green;
        ramp-coreload-3-foreground = colors.green;
        ramp-coreload-4-foreground = colors.yellow;
        ramp-coreload-5-foreground = colors.yellow;
        ramp-coreload-6-foreground = colors.red;
        ramp-coreload-7-foreground = colors.red;
      };
    };
  };
}

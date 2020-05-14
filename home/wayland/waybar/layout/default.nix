{ pkgs, ... }:

let path = with pkgs; stdenv.lib.makeBinPath [ sway jq gawk ];
in {
  format = " {}";
  exec = "PATH=PATH:${path} swaymsg -t get_inputs"
    + " | jq -r '[.[].xkb_active_layout_name | select(length > 0)][0][0:2]'"
    + " | awk '{ print tolower($1) }'";
  interval = 1;
  tooltip = false;
}

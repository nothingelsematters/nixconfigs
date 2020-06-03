{ config, pkgs, ... }:

{
  format = " {}";
  exec = with pkgs;
    config.lib.functions.toScript "layout.sh" [ sway jq ] ''
      swaymsg -t get_inputs | jq -r '[.[].xkb_active_layout_name | select(length > 0)][0][:2] | ascii_downcase'
      while true; do swaymsg -t subscribe '[ "input" ]' | jq -r '.input.xkb_active_layout_name[:2] | ascii_downcase'; done
    '';
  interval = 0;
  tooltip = false;
}

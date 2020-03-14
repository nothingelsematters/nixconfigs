{ pkgs, ... }:

let
  getScript = import ../../../../lib/getScript.nix { inherit pkgs; };
  path = with pkgs; pkgs.stdenv.lib.makeBinPath [ sway ripgrep gawk coreutils ];
in {
  format = " {}";
  exec =
    "PATH=PATH:${path} swaymsg -t get_inputs | rg -i active_layout_name | " +
    "head -n 1 |  awk -F'[:\"(]' '{ print tolower($5) }' | cut -b 1-2";
  interval = 1;
  tooltip = false;
}

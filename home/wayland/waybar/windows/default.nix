{ config, pkgs, ... }:

with config.lib.theme;
let python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]) + /bin/python3;
in {
  exec = "${python} ${./windows.py} --focused '${colors.text.secondary}'"
    + " --wfocused '${colors.text.primary}'"
    + " --unfocused '${colors.text.disabled}'"
    + " --urgent '${colors.text.urgent}'";
  tooltip = false;
}

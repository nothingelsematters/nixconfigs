{ config, pkgs, ... }:

with config.lib.functions;
let python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]) + /bin/python3;
in {
  resize = with pkgs; "exec " + getScript ./resize.sh [ slurp sway ];
  inactive-transparency = "${python} ${./inactive-transparency.py} -o 0.86";
}

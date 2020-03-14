{ pkgs, ... }:

let
  getScript = import ../../../lib/getScript.nix { inherit pkgs; };
  getScript' = x: y: "exec " + getScript x y;
  python = pkgs.python3.withPackages (ps: with ps; [ i3ipc ]) + /bin/python3;
in {
  resize = with pkgs; getScript' ./resize.sh [ slurp sway ];
  inactive-transparency = "${python} ${./inactive-transparency.py} -o 0.86";
}

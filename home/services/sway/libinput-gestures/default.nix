{ pkgs, ... }:

let
  getScript = import ../../../lib/getScript.nix { inherit pkgs; };
  focus = with pkgs; getScript ./focus.sh [ sway ripgrep gawk coreutils ];
in {
  home.packages = [ pkgs.libinput-gestures ];

  xdg.configFile."libinput-gestures.conf".text = ''
    # Move to next workspace
    gesture swipe left   ${focus} next

    # Move to prev workspace
    gesture swipe right  ${focus} prev
  '';
}

{ pkgs, ... }:

{
  getScript = import ./getScript.nix { inherit pkgs; };
  toCSON = import ./toCSON.nix { inherit pkgs; };
  toCss = import ./toCss.nix { inherit pkgs; };
  theme = import ./theme;

  terminal = {
    name = "kitty";
    package = pkgs.kitty;
  };

  barHeight = 22;

  toggle-mute = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && "
    + "( ${pkgs.pamixer}/bin/pamixer --get-mute && echo 0 > $SWAYSOCK.wob ) || "
    + "${pkgs.pamixer}/bin/pamixer --get-volume > $SWAYSOCK.wob";
}

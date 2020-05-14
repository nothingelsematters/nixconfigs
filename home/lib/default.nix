arg@{ pkgs, ... }:

{
  lib = {
    sources = import ../../nix/sources.nix;

    constants.barHeight = 22;

    functions = rec {
      toScript = import ./toScript.nix arg;
      getScript = with builtins;
        file: packs:
        toScript (replaceStrings [ "/" ] [ "" ] (toString file)) packs
        (readFile file);

      toCSON = import ./toCSON.nix arg;
      toCss = import ./toCss.nix arg;
      toggleMute = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && "
        + "( ${pkgs.pamixer}/bin/pamixer --get-mute && echo 0 > $SWAYSOCK.wob ) || "
        + "${pkgs.pamixer}/bin/pamixer --get-volume > $SWAYSOCK.wob";
    };
  };
}

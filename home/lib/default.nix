arg@{ pkgs, lib, ... }:

with builtins; {
  lib = {
    sources = import ../../nix/sources.nix;

    constants = {
      barHeight = 22;
      toggleMute = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && "
        + "( ${pkgs.pamixer}/bin/pamixer --get-mute && echo 0 > $SWAYSOCK.wob ) || "
        + "${pkgs.pamixer}/bin/pamixer --get-volume > $SWAYSOCK.wob";
    };

    functions = rec {
      toScript = name: packs: str:
        let
          patched = ''
            export PATH=${pkgs.stdenv.lib.makeBinPath packs}
          '' + str;
        in (pkgs.writeShellScriptBin name patched) + "/bin/" + name;

      getScript = file: packs:
        toScript (replaceStrings [ "/" ] [ "" ] (toString file)) packs
        (readFile file);

      toCSON = import ./toCSON.nix arg;
      toCSS = import ./toCSS.nix arg;
    };
  };
}

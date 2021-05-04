{ pkgs, lib, ... }:

with builtins;
with pkgs; {
  lib = rec {
    constants.barHeight = 16;

    functions = rec {
      toScript = name: packs: str:
        let
          patched = ''
            export PATH=${lib.makeBinPath packs}
          '' + str;
        in (writeShellScriptBin name patched) + "/bin/" + name;

      getScript = file: packs:
        toScript (replaceStrings [ "/" ] [ "" ] (toString file)) packs
        (readFile file);
    };
  };
}

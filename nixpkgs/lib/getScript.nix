{ pkgs, lib, ... }:

with builtins;
dir: name: packs:
  let
    fst = x: elemAt x 0;
    snd = x: elemAt x 1;
    replacing = replaceStrings [ "-" ] [ "" ];
    patching = x: "${lib.toUpper (replacing (snd x))}=${fst x}/bin/${snd x}";
    patchPkgs = file: packs: concatStringsSep "\n" (map patching packs) + "\n" + readFile file;
  in
    (pkgs.writeShellScriptBin name (patchPkgs (dir + ("/" + name)) packs)) + "/bin/"  + name

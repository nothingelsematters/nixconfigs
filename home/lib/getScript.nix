{ pkgs, ... }:

with builtins;
file: packs:
let
  PATH = pkgs.stdenv.lib.makeBinPath packs;
  patched = ''
    export PATH=$PATH:${PATH}
  '' + readFile file;
  name = replaceStrings [ "/" ] [ "" ] (toString file);
in (pkgs.writeShellScriptBin name patched) + "/bin/" + name

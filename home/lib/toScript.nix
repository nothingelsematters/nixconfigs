{ pkgs, ... }:

with builtins;
name: packs: str:
let
  patched = ''
    export PATH=$PATH:${pkgs.stdenv.lib.makeBinPath packs}
  '' + str;
in (pkgs.writeShellScriptBin name patched) + "/bin/" + name

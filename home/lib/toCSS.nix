{ pkgs, ... }:

let
  concatMapped = f: set:
    builtins.concatStringsSep "\n" (pkgs.lib.attrsets.mapAttrsToList f set);
  mapValues = name: value: "    ${name}: ${builtins.toString value};";
  mapGroups = name: value: ''
    ${name} {
    ${concatMapped mapValues value}
    }'';
in concatMapped mapGroups

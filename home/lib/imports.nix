{ lib, dir, includeDirectories ? true, includeFiles ? false, skipDotted ? true
, additional ? [ ] }:

with lib;
additional ++ trivial.pipe dir [
  builtins.readDir

  (attrsets.filterAttrs (k: v:
    ((includeDirectories && v == "directory")
      || (includeFiles && v == "regular" && k != "default.nix"))
    && !(strings.hasPrefix "." k && skipDotted)))

  (attrsets.mapAttrsToList (k: v: dir + ("/" + k)))
]

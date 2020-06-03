{ lib, dir, includeDirectories ? true, includeFiles ? false, skipDotted ? true
, additional ? [ ] }:

with lib;
let
  isFile = type: type == "regular";
  isNix = name: strings.hasSuffix ".nix" name;
  isDefaultNix = name: name == "default.nix";
  includeFile = name: type:
    includeFiles && isFile type && isNix name && !(isDefaultNix name);
  includeDir = type: includeDirectories && type == "directory";
  includeHidden = name: !(strings.hasPrefix "." name && skipDotted);
in additional ++ trivial.pipe dir [
  builtins.readDir
  (attrsets.filterAttrs (name: type:
    (includeDir type || includeFile name type) && includeHidden name))
  (attrsets.mapAttrsToList (name: type: dir + ("/" + name)))
]

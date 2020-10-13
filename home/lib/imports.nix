{ lib, dir, includeDirectories ? true, includeFiles ? false, skipDotted ? true
, additional ? [ ], recursive ? false }:

with lib.attrsets;
with lib.lists;
with lib.trivial;
with lib.strings;
with builtins;
let
  isFile = type: type == "regular";
  isNix = hasSuffix ".nix";
  isDefaultNix = name: name == "default.nix";
  includeFile = name: type:
    includeFiles && isFile type && isNix name && !(isDefaultNix name);
  includeDir = type: includeDirectories && type == "directory";
  includeHidden = name: !(hasPrefix "." name && skipDotted);

  hasDefault = directory:
    any isDefaultNix (mapAttrsToList const (readDir directory));

  filter = filterAttrs (name: type:
    (includeDir type || includeFile name type) && includeHidden name);
  merge = directory:
    mapAttrsToList (name:
      let child = directory + ("/" + name);
      in type:
      (if type == "directory" && recursive && !hasDefault child then
        exploreDir
      else
        singleton) child);

  exploreDir = directory:
    pipe directory [ readDir filter (merge directory) concatLists ];
in additional ++ exploreDir dir

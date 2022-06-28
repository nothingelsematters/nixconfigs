{ lib, dir, includeDirectories ? true, includeFiles ? true, skipDotted ? true
, recursive ? true, additional ? [ ], exclude ? [ ] }:

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

  filterFiles = filterAttrs (name: type:
    (includeDir type || includeFile name type) && includeHidden name);
  merge = directory:
    mapAttrsToList (name:
      let child = directory + ("/" + name);
      in type:
      (if type == "directory" && recursive && !hasDefault child then
        exploreDir
      else
        singleton) child);

  filterExclusion = filter (a:
    count (b:
      "${toString a}" == "${toString dir}/${b}"
      || match "${toString dir}/${b}/.*" (toString a) != null)
    (exclude ++ [ "profile" ]) == 0);

  exploreDir = directory:
    pipe directory [
      readDir
      filterFiles
      (merge directory)
      concatLists
      filterExclusion
    ];
in additional ++ exploreDir dir

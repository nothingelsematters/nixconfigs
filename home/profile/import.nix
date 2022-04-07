{ lib, dir, includeDirectories ? true, includeFiles ? false, skipDotted ? true
, additional ? [ ], exclude ? [ ], recursive ? false }:

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
      a == (dir + b)
      || builtins.match "${builtins.toString dir}/${b}/.*" (builtins.toString a)
      != null) exclude == 0);

  exploreDir = directory:
    pipe directory [
      readDir
      filterFiles
      (merge directory)
      concatLists
      filterExclusion
    ];
in additional ++ exploreDir dir

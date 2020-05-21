lib: dir:

with lib.attrsets;
lib.trivial.pipe dir [
  builtins.readDir
  (filterAttrs (k: v: v == "directory" && !(lib.strings.hasPrefix "." k)))
  (mapAttrsToList (k: v: dir + ("/" + k)))
]

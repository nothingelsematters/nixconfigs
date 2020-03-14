{ pkgs, ... }:

let
  indent = builtins.map (str: "  ${str}");
  processSet = set:
    builtins.concatLists (pkgs.lib.attrsets.mapAttrsToList valueToCSON set);

  valueToCSON = name: value:
    let left = ''"${name}": '';
    in (if builtins.isAttrs value then
      [ left ] ++ indent (processSet value)
    else
      (if builtins.isList value then
        [ (left + "[") ] ++ indent (builtins.map (str: ''"${str}"'') value)
        ++ [ "]" ]
      else
        (if builtins.isString value then
          [ ''${left}"${value}"'' ]
        else
          (if builtins.isBool value then
            [ (left + (if value then "true" else "false")) ]
          else
            [ "${left}${builtins.toString value}" ]))));
in set: builtins.concatStringsSep "\n" (processSet set)

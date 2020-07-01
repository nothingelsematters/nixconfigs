arg@{ pkgs, lib, ... }:

with builtins;
with pkgs;
with lib.attrsets; {
  lib = {
    constants.barHeight = 16;

    functions = rec {
      toScript = name: packs: str:
        let
          patched = ''
            export PATH=${stdenv.lib.makeBinPath packs}
          '' + str;
        in (writeShellScriptBin name patched) + "/bin/" + name;

      getScript = file: packs:
        toScript (replaceStrings [ "/" ] [ "" ] (toString file)) packs
        (readFile file);

      toCSS = let
        concatMapped = f: set: concatStringsSep "\n" (mapAttrsToList f set);
        mapValues = name: value: "    ${name}: ${toString value};";
        mapGroups = name: value: ''
          ${name} {
          ${concatMapped mapValues value}
          }'';
      in concatMapped mapGroups;

      toCSON = let
        indent = map (str: "  ${str}");
        processSet = set: concatLists (mapAttrsToList valueToCSON set);
        valueToCSON = name: value:
          let left = ''"${name}": '';
          in if isAttrs value then
            [ left ] ++ indent (processSet value)
          else if isList value then
            [ (left + "[") ] ++ indent (map (str: ''"${str}"'') value)
            ++ [ "]" ]
          else if isString value then
            [ ''${left}"${value}"'' ]
          else if isBool value then
            [ (left + (if value then "true" else "false")) ]
          else
            [ "${left}${toString value}" ];
      in set: concatStringsSep "\n" (processSet set);
    };

    theme.utils = let
      mkCommon = { prefix, postfix, valuef }:
        attrs:
        let
          recurse = func: path: set:
            mapAttrs (name: value:
              (if isAttrs value then (recurse func) else valuef)
              (path ++ [ name ]) value) set;

          collect = attrs:
            if isAttrs attrs then
              concatMap collect (attrValues attrs)
            else
              [ attrs ];
        in ''
          ${prefix}
          ${concatStringsSep "\n" (collect (recurse valuef [ ] attrs))}
          ${postfix}
        '';
    in {
      mkOpaque = color: color + "bf";

      mkCss = mkCommon {
        prefix = "{";
        postfix = "}";
        valuef = path: value:
          "--${(concatStringsSep "-" ([ "theme" ] ++ path))}: ${
            toString value
          };";
      };

      mkINI = mkCommon {
        prefix = "[theme]";
        postfix = "";
        valuef = path: value:
          "${(concatStringsSep "-" path)} = ${toString value}";
      };
    };
  };
}

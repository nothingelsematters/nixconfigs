let
  mkCommon = { prefix, postfix, valuef }:
    attrs:
    let
      recurse = func: path: set:
        let
          g = name: value:
            (if builtins.isAttrs value then (recurse func) else valuef)
            (path ++ [ name ]) value;
        in builtins.mapAttrs g set;

      collect = attrs:
        if builtins.isAttrs attrs then
          builtins.concatMap collect (builtins.attrValues attrs)
        else
          [ attrs ];
    in ''
      ${prefix}
      ${builtins.concatStringsSep "\n" (collect (recurse valuef [ ] attrs))}
      ${postfix}
    '';
in {
  mkOpaque = color: color + "bf";

  mkCss = mkCommon {
    prefix = "{";
    postfix = "}";
    valuef = path: value:
      "--${(builtins.concatStringsSep "-" ([ "theme" ] ++ path))}: ${
        toString value
      };";
  };

  mkINI = mkCommon {
    prefix = "[theme]";
    postfix = "";
    valuef = path: value:
      "${(builtins.concatStringsSep "-" path)} = ${toString value}";
  };
}

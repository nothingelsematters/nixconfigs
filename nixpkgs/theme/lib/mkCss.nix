let
  attrsToVars = import ./mkCommon.nix;
  attrsToCSSVars = prefix: attrsToVars {
    prefix = "{";
    postfix = "}";
    valuef = path: value: "--${(builtins.concatStringsSep "-" ([prefix] ++ path))}: ${toString value};";
  };
in
  attrsToCSSVars "theme"

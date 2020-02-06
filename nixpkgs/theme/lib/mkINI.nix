let
  attrsToVars = import ./mkCommon.nix;
  attrsToINIVars = prefix: attrsToVars {
    prefix = prefix;
    postfix = "";
    valuef = path: value: "${(builtins.concatStringsSep "-" path)} = ${toString value}";
  };
in
  attrsToINIVars "[theme]"

let
  mapAttrsRecursive = f: set:
    let
      recurse = path: set:
        let
          g = name: value:
            if builtins.isAttrs value then
              recurse (path ++ [ name ]) value
            else
              f (path ++ [ name ]) value;
        in builtins.mapAttrs g set;
    in recurse [ ] set;
  collect = attrs:
    if builtins.isAttrs attrs then
      builtins.concatMap collect (builtins.attrValues attrs)
    else
      [ attrs ];
  attrsToVars = valuef: attrs: collect (mapAttrsRecursive valuef attrs);
in params: attrs: ''
  ${params.prefix}
  ${builtins.concatStringsSep "\n" (attrsToVars params.valuef attrs)}
  ${params.postfix}
''

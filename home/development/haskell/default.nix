{ pkgs, ... }:

{
  home = {
    packages = with pkgs;
      [
        (ghc.withHoogle
          (ps: with ps; [ pretty-simple unordered-containers microlens ]))
      ];

    file.".ghci".text = ''
      :set prompt "\ESC[0;34m\STX%s\n\ESC[1;31m\STX\x03BB> \ESC[m\STX"
      :set prompt-cont "|> "
      :set +s
      :set +m
      :set +t
      :set -Wall
      :set -Wno-type-defaults
      :set -package pretty-simple
      :set -interactive-print Text.Pretty.Simple.pPrint
      :def hoogle \s -> return $ ":! hoogle search -l --colour --count=15 \"" ++ s ++ "\""
      :def doc \s -> return $ ":! hoogle search -l --colour --info \"" ++ s ++ "\""
    '';
  };
}

{ pkgs, ... }:

{
  config.lib.language = {
    packages = [
      (pkgs.ghc.withHoogle (ps:
        with ps; [
          # necessary
          pretty-simple
          unordered-containers
          microlens

          # building
          stack
          cabal2nix

          # coding
          hlint
          stylish-haskell

          # analyzing
          threadscope

          # libraries
          optparse-applicative
          directory
          ncurses

          # testing
          criterion
          hedgehog
          hedgehog-fn
          tasty
          tasty-hedgehog
        ]))
    ];

    settings = {
      "[haskell]" = {
        "editor.defaultFormatter" = "vigoo.stylish-haskell";
        "editor.tabSize" = 2;
        "editor.rulers" = [ 80 ];
      };
      "haskell.hlint.executablePath" = pkgs.hlint + /bin/hlint;
      "haskell.hlint.run" = "onType";
      "ghcSimple.startupCommands.all" = [
        "System.IO.hSetBuffering System.IO.stderr System.IO.NoBuffering"
        "System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering"
        ":set -haddock"
      ];
    };

    extensions = [ pkgs.vscode-extensions.justusadam.language-haskell ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "haskell-linter";
          publisher = "hoovercj";
          version = "0.0.6";
          sha256 = "0fb71cbjx1pyrjhi5ak29wj23b874b5hqjbh68njs61vkr3jlf1j";
        }
        {
          name = "stylish-haskell";
          publisher = "vigoo";
          version = "0.0.10";
          sha256 = "1zkvcan7zmgkg3cbzw6qfrs3772i0dwhnywx1cgwhy39g1l62r0q";
        }
        {
          name = "vscode-ghc-simple";
          publisher = "dramforever";
          version = "0.1.22";
          sha256 = "0x3csdn3pz5rhl9mhplpm8kxb40l1dw5rnwhh3zsif3rz0nqhk2a";
        }
      ];
  };

  home.file.".ghci".text = ''
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

  programs.vscode.haskell = {
    enable = true;
    hie.enable = false;
  };
}

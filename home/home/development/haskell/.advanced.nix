{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      (ghc.withHoogle (ps:
        with ps; [
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
          Diff
          ncurses

          # testing
          criterion
          hedgehog
          hedgehog-fn
          tasty
          tasty-hedgehog
        ]))
    ];

  programs.vscode.userSettings = {
    "haskell.hlint.executablePath" = pkgs.hlint + /bin/hlint;
    "haskell.hlint.run" = "onType";
    "ghcSimple.startupCommands.all" = [
      "System.IO.hSetBuffering System.IO.stderr System.IO.NoBuffering"
      "System.IO.hSetBuffering System.IO.stdout System.IO.NoBuffering"
      ":set -haddock"
    ];
  };
}

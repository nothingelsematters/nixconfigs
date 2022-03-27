args@{ config, pkgs, ... }:

{
  lib.packages.editor = {
    name = "code";
    package = config.programs.vscode.package;
  };

  programs.zsh.initExtra = ''
    zcd() {
      _zlua $1 && code .
    }
  '';

  programs.vscode = {
    enable = true;
    keybindings = import ./keybindings.nix;
    userSettings = import ./settings.nix args;

    extensions = with pkgs;
      with vscode-extensions;
      [
        tomoki1207.pdf
        editorconfig.editorconfig
        usernamehw.errorlens

        # theme
        file-icons.file-icons
        gruntfuggly.todo-tree
        github.github-vscode-theme

        # markdown
        yzhang.markdown-all-in-one
      ] ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-diff";
          publisher = "fabiospampinato";
          version = "1.4.2";
          sha256 = "sha256-b1N+m+Y4kUylXrJOU0Y1c9eRI12CSkb5mWyKYy+FAzc=";
        }
        {
          name = "rest-client";
          publisher = "humao";
          version = "0.24.6";
          sha256 = "sha256-g1RSkRnKamuaegmNX6MnDLfKL0SQThr2XQgRsN+p16Q=";
        }
      ];
  };
}

args@{ config, pkgs, ... }:

{
  lib.packages.editor = {
    name = "code";
    package = config.programs.vscode.package;
  };

  programs.vscode = {
    enable = true;
    keybindings = import ./keybindings.nix;
    userSettings = import ./settings.nix args;

    extensions = with pkgs;
      with vscode-extensions;
      [
        tomoki1207.pdf

        # theme
        file-icons.file-icons
        gruntfuggly.todo-tree
        github.github-vscode-theme

        # markdown
        yzhang.markdown-all-in-one
      ] ++ vscode-utils.extensionsFromVscodeMarketplace [{
        name = "vscode-diff";
        publisher = "fabiospampinato";
        version = "1.4.1";
        sha256 = "sha256-PgkXh65lBvX4XwYdKCqdjQbBr156qE4QMbnjJ+Tb8QI=";
      }];
  };
}

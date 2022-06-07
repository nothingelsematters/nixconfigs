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
        editorconfig.editorconfig
        usernamehw.errorlens

        # theme
        file-icons.file-icons
        gruntfuggly.todo-tree
        github.github-vscode-theme

        # markdown
        yzhang.markdown-all-in-one

        # rest
        turbo.vscode-extensions.humao.rest-client
      ] ++ vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-diff";
          publisher = "fabiospampinato";
          version = "1.4.2";
          sha256 = "sha256-b1N+m+Y4kUylXrJOU0Y1c9eRI12CSkb5mWyKYy+FAzc=";
        }
        {
          name = "relativegoto";
          publisher = "retepaskab";
          version = "0.0.1";
          sha256 = "sha256-8xg8cy2OtJ0CdEclE6grIAHXHHN5eBfNKYAqu4sk6y8=";
        }
        # command + shift + P -> Open Scratchpad
        {
          name = "scratchpad";
          publisher = "awesomektvn";
          version = "0.1.0";
          sha256 = "sha256-jbyua6slJpA4SDxPyvyLuz4R5drcrwNtLIKYR8jNpZg=";
        }
      ];
  };
}

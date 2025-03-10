{ pkgs, ... }:

with pkgs.vscode-utils;
let
  extensions = with pkgs.vscode-extensions; [
    tomoki1207.pdf
    usernamehw.errorlens
    fabiospampinato.vscode-diff
    retepaskab.relativegoto

    # theme
    file-icons.file-icons
    gruntfuggly.todo-tree
    github.github-vscode-theme

    # markdown
    yzhang.markdown-all-in-one

    # rest
    humao.rest-client
  ];

  fabiospampinato.vscode-diff = extensionFromVscodeMarketplace {
    name = "vscode-diff";
    publisher = "fabiospampinato";
    version = "1.4.2";
    sha256 = "sha256-b1N+m+Y4kUylXrJOU0Y1c9eRI12CSkb5mWyKYy+FAzc=";
  };

  retepaskab.relativegoto = extensionFromVscodeMarketplace {
    name = "relativegoto";
    publisher = "retepaskab";
    version = "0.0.1";
    sha256 = "sha256-8xg8cy2OtJ0CdEclE6grIAHXHHN5eBfNKYAqu4sk6y8=";
  };
in
extensions

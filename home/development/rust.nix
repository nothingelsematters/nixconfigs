{ pkgs, ... }:

{
  home.packages = with pkgs; [ rustup ];

  programs.vscode = {
    userSettings = {
      "[rust]"."editor.defaultFormatter" = "matklad.rust-analyzer";
      "rust-analyzer.checkOnSave.command" = "clippy";
    };

    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
    ];
  };
}

{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ rustup ];
    sessionVariables.PATH = "$PATH:/Users/simon/.cargo/bin";
  };

  programs.vscode = {
    userSettings = {
      "[rust]"."editor.defaultFormatter" = "matklad.rust-analyzer";
      "rust-analyzer.checkOnSave.command" = "clippy";
      "rust-analyzer.cargo.features" = "all";
    };

    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      serayuzgur.crates
      tamasfe.even-better-toml
    ];
  };
}

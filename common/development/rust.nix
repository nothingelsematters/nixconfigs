{ pkgs, ... }:

{
  home.packages = with pkgs; [ rustup ];

  programs.vscode = {
    userSettings."[rust]"."editor.defaultFormatter" = "matklad.rust-analyzer";
    extensions = with pkgs.vscode-extensions; [
      matklad.rust-analyzer
      serayuzgur.crates
    ];
  };
}

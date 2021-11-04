{ pkgs, ... }:

{
  home.packages = with pkgs; [ rustup ];

  programs.vscode = {
    userSettings."[rust]"."editor.defaultFormatter" = "matklad.rust-analyzer";
    extensions = with pkgs.vscode-extensions; [
      pkgs.stable.vscode-extensions.matklad.rust-analyzer # TODO
      serayuzgur.crates
      tamasfe.even-better-toml
    ];
  };
}

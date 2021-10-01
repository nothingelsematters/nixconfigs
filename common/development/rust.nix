{ pkgs, ... }:

{
  home.packages = with pkgs; [ rustup ];

  programs = {
    zsh.shellAliases.rs = "rustc";

    vscode = {
      userSettings."[rust]"."editor.defaultFormatter" = "matklad.rust-analyzer";

      extensions = with pkgs.vscode-extensions; [
        matklad.rust-analyzer
        serayuzgur.crates
      ];
    };
  };
}

{ pkgs, nixpkgs-turbo, ... }:

{
  home.packages = with pkgs; [ rustup turbo.glibc ];

  programs = {
    zsh.shellAliases.rs = "rustc";

    vscode = {

      userSettings."[rust]"."editor.defaultFormatter" = "rust-lang.rust";

      extensions = with pkgs.vscode-extensions; [
        matklad.rust-analyzer
        serayuzgur.crates
      ];
    };
  };
}

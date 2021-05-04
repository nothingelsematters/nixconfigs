{ pkgs, nixpkgs-turbo, ... }:

{
  home.packages = with pkgs; [ rustup turbo.glibc ];

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

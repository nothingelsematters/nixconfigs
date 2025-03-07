{ pkgs, ... }:

{
  home.packages = [ pkgs.nixfmt-rfc-style ];

  editorconfig.settings."*.nix".indent_size = 2;

  programs = {
    zsh.shellAliases.nsp = "nix-shell --run zsh -p";

    vscode.profiles.default = {
      userSettings = {
        "nixfmt.path" = pkgs.nixfmt-rfc-style + /bin/nixfmt;
        "[nix]" = {
          "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
          "editor.tabSize" = 2;
          "editor.rulers" = [ 80 ];
        };
      };

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        brettm12345.nixfmt-vscode
      ];
    };
  };
}

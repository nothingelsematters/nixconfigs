{ pkgs, ... }:

{
  home.packages = with pkgs; [ nixfmt manix ];

  programs = {
    zsh.shellAliases.nsp = "nix-shell --run zsh -p";

    vscode = {
      userSettings = {
        "nixfmt.path" = pkgs.nixfmt + /bin/nixfmt;
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

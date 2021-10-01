{ pkgs, ... }:

{
  imports = [ ../common ];

  programs = {
    vscode.package = pkgs.fixed.vscode;

    zsh.shellAliases.hms =
      "nix build .#homeManagerConfigurations.mac.activationPackage "
      + "&& ./result/activate";
  };
}

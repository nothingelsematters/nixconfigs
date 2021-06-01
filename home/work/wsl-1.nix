{
  imports = [ ./common.nix ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeManagerConfiguration.wsl1.activatePackage "
    + "&& ./result/activate";
}

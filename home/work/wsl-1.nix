{
  imports = [ ./common.nix ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeManagerConfigurations.wsl1.activationPackage "
    + "&& ./result/activate";
}

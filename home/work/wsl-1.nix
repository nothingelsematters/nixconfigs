{
  imports = [ ./common.nix ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeConfiguration.wsl1.activatePackage "
    + "&& ./result/activate";
}

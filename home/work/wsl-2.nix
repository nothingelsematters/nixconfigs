{
  imports =
    [ ./common.nix ../home/development/docker.nix ../home/terminal/z-lua.nix ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeManagerConfigurations.wsl2.activationPackage "
    + "&& ./result/activate";
}

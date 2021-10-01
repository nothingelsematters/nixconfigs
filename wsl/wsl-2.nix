{
  imports = [
    ./common.nix
    ../common/development/docker.nix
    ../common/terminal/z-lua.nix
  ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeManagerConfigurations.wsl2.activationPackage "
    + "&& ./result/activate";
}

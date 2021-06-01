{
  imports =
    [ ./common.nix ../home/development/docker.nix ../home/terminal/z-lua.nix ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeManagerConfiguration.wsl2.activatePackage "
    + "&& ./result/activate";
}

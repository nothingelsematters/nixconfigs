{
  imports =
    [ ./common.nix ../home/development/docker.nix ../home/terminal/z-lua.nix ];

  programs.zsh.shellAliases.hms =
    "nix build .#homeConfiguration.wsl2.activatePackage "
    + "&& ./result/activate";
}

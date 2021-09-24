{ gpkgs, ... }:

{
  imports = [
    ../common/development/vscode
    ../common/development/git.nix
    ../common/development/git-additional.nix
    ../common/development/kotlin.nix
    ../common/development/nix.nix
    ../common/development/python.nix
    ../common/development/rust.nix

    ../common/terminal/bat.nix
    ../common/terminal/direnv.nix
    ../common/terminal/fzf.nix
    ../common/terminal/htop.nix
    ../common/terminal/most.nix
    ../common/terminal/packages.nix
    ../common/terminal/starship.nix
    ../common/terminal/starship-additional.nix
    ../common/terminal/z-lua.nix
    ../common/terminal/zsh.nix

    ../common/theme.nix
  ];

  programs.zsh = {
    shellAliases.hms =
      "nix build .#homeManagerConfigurations.mac.activationPackage "
      + "&& ./result/activate";

    plugins = [{
      name = "forgit";
      src = pkgs.inputs.forgit;
    }];
  };
}

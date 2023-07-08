{ pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry
    (python311.withPackages (ps: with ps; [ autopep8 ]))
  ];

  programs = {
    zsh.shellAliases = {
      py = "python3";
      ipy = "ipython";
    };
  };
}

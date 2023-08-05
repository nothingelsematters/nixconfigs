{ pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry
    (python311.withPackages (ps: with ps; [ ipython ]))
  ];

  programs = {
    zsh.shellAliases = {
      py = "python3";
      ipy = "ipython";
    };

    vscode.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-pyright.pyright
    ];
  };
}

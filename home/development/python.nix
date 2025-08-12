{ pkgs, ... }:

{
  home.packages = with pkgs; [
    poetry
    (python313.withPackages (
      ps: with ps; [
        ipython
        requests
        python-dateutil
        pyyaml
      ]
    ))
  ];

  programs = {
    zsh.shellAliases = {
      py = "python3";
      ipy = "ipython";
    };

    vscode.profiles.default = {
      userSettings."files.exclude"."**/__pycache__" = true;

      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-pyright.pyright
      ];
    };
  };
}

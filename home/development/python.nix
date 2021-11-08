{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    (python310.withPackages (ps: with ps; [ autopep8 ]))
  ];

  programs = {
    zsh.shellAliases.py = "python3";

    vscode.userSettings = {
      "python.dataScience.alwaysTrustNotebooks" = true;
      "python.dataScience.askForKernelRestart" = false;
      "jupyter.experiments.optInfo" = [ "CustomEditor" ];
      "jupyter.askForKernelRestart" = false;
    };
  };
}

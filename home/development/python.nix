{ pkgs, config, ... }:

{
  home.packages = [
    (pkgs.python39.withPackages (ps:
      with ps; [
        autopep8

        notebook
        ipykernel
        pandas
        scikitlearn
        pyenchant
        nltk
      ]))
  ];

  programs = {
    zsh.shellAliases.py = "python3";

    vscode = {
      extensions = with pkgs.vscode-extensions; [ ms-toolsai.jupyter ];

      userSettings = {
        "python.dataScience.alwaysTrustNotebooks" = true;
        "python.dataScience.askForKernelRestart" = false;
        "jupyter.experiments.optInfo" = [ "CustomEditor" ];
        "jupyter.askForKernelRestart" = false;
      };
    };
  };
}

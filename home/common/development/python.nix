{ pkgs, config, ... }:

{
  home.packages = [
    (pkgs.python3.withPackages (ps:
      with ps; [
        # jupyter
        # notebook
        # ipykernel
        # tqdm
        # ipywidgets

        # calculations
        # numpy
        # matplotlib
        # pandas
        # scikitlearn

        # formatter
        autopep8
      ]))
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

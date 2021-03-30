{ pkgs, ... }:

let
  pythonEnv = (pkgs.python3.withPackages (pythonPackages:
    with pythonPackages; [
      # jupyter
      notebook
      ipykernel
      tqdm
      ipywidgets

      # calculations
      numpy
      matplotlib
      pandas
      scikitlearn

      # formatter
      autopep8
    ]));
in {
  services.jupyter = {
    enable = true;
    password =
      "'argon2:$argon2id$v=19$m=10240,t=10,p=8$gl09lvZPjohe8rll3BMQyw$c0yrTHV5mEUNLLMQ3f9oNw'";
    kernels = {
      python3 = rec {
        displayName = language;
        language = "python";
        argv = [
          pythonEnv.interpreter
          "-m"
          "ipykernel_launcher"
          "-f"
          "{connection_file}"
        ];
      };
    };
  };
}

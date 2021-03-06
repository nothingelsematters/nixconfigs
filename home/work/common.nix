{ config, lib, pkgs, ... }:

{
  imports = [ ../common ];

  home.packages = with pkgs; [ jdk11 maven ];

  lib.theme.isDark = true;

  programs = {
    git.extraConfig.core.editor = "nano";

    zsh.plugins = [{
      name = "forgit";
      src = pkgs.inputs.forgit;
    }];

    starship.settings = {
      scan_timeout = 1;

      memory_usage = {
        disabled = false;
        format = "ram ([\${ram}]($style)) ";
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      git_branch.symbol = "";
      java.symbol = "java ";
      jobs.symbol = "+";
      nix_shell.symbol = "nix ";

      env_var.variable = "NIX_NAME";

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vicmd_symbol = "[<](bold green)";
      };

      format = "$shlvl" + "$directory" + "$git_branch" + "$git_commit"
        + "$git_state" + "$docker_context" + "$nix_shell" + "$memory_usage"
        + "$cmd_duration" + "$line_break" + "$jobs" + "$battery" + "$character";
    };
  };
}

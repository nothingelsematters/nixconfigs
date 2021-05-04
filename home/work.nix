{ config, lib, pkgs, ... }:

{
  imports = [ ./common ];

  home.packages = with pkgs; [ jdk11 maven ];

  lib.theme.isDark = true;

  programs = {
    zsh.shellAliases.hms = "home-manager switch";

    starship.settings = {
      scan_timeout = 1;

      memory_usage.disabled = false;

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      git_branch.symbol = "";
      java.symbol = "java ";
      jobs.symbol = "+";

      env_var.variable = "NIX_NAME";
      nix_shell = {
        symbol = "nix ";
        use_name = true;
      };

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
        vicmd_symbol = "[<](bold green)";
      };
      format = "$shlvl" + "$directory" + "$git_branch" + "$git_commit"
        + "$git_state" + "$docker_context" + "$package" + "$java" + "$nix_shell"
        + "$memory_usage" + "$cmd_duration" + "$line_break" + "$jobs"
        + "$battery" + "$character";
    };
  };
}

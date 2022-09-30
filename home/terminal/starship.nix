{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      scan_timeout = 10;

      nix_shell.symbol = "❄️";

      env_var.variable = "NIX_NAME";

      memory_usage = {
        format = "$symbol [\${ram}( | \${swap})]($style) ";
        disabled = false;
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      status.disabled = false;

      shlvl = {
        disabled = false;
        threshold = 1;
        symbol = "❯";
        repeat = true;
        style = "bold white";
        format = "[$symbol]($style) ";
      };

      format = "$directory" + "$git_branch" + "$git_state" + "$git_status"
        + "$docker_context" + "$nix_shell" + "$env_var" + "$memory_usage"
        + "$cmd_duration" + "$line_break" + "$status" + "$battery" + "$jobs"
        + "$shlvl";
    };
  };
}

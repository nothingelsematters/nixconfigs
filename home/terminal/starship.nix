{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      scan_timeout = 10;

      memory_usage.disabled = false;
      shlvl = {
        disabled = false;
        symbol = "❯";
        repeat = true;
        style = "bold white";
        format = "[$symbol]($style)";
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      env_var.variable = "NIX_NAME";

      format = "$directory" + "$git_branch" + "$git_state" + "$git_status"
        + "$docker_context" + "$nix_shell" + "$env_var" + "$memory_usage"
        + "$cmd_duration" + "$line_break" + "$shlvl" + "$jobs" + "$battery"
        + "$status" + "$character";
    };
  };
}

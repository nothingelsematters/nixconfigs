{
  programs.starship.settings = {
    scan_timeout = 10;

    memory_usage.disabled = false;

    cmd_duration = {
      min_time = 500;
      show_milliseconds = true;
    };

    env_var.variable = "NIX_NAME";

    format = "$username" + "$hostname" + "$shlvl" + "$directory" + "$git_branch"
      + "$git_commit" + "$git_state" + "$git_status" + "$docker_context"
      + "$nix_shell" + "$env_var" + "$memory_usage" + "$cmd_duration"
      + "$line_break" + "$jobs" + "$battery" + "$status" + "$character";
  };
}

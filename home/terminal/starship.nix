{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      scan_timeout = 10;

      memory_usage = {
        format = "$symbol [\${ram}( | \${swap})]($style) ";
        disabled = false;
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      nix_shell = {
        format = "[$symbol]($style)";
        symbol = "❄️";
      };

      shlvl = {
        disabled = false;
        threshold = 2;
        symbol = "↓";
        repeat = false;
        style = "bold white";
      };

      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$docker_context"
        "$memory_usage"
        "$cmd_duration"
        "$line_break"
        "$battery"
        "$jobs"
        "$nix_shell"
        "$shlvl"
        "$character"
      ];
    };
  };
}

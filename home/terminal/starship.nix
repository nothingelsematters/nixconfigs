{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = false;
      scan_timeout = 10;

      kubernetes = {
        disabled = false;
        format = ''[$symbol $context (\($namespace\))]($style)'';
        symbol = "☁️";
      };

      memory_usage = {
        format = "$symbol [\${ram}( | \${swap})]($style) ";
        disabled = false;
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
        format = ''\(took [$duration]($style)\)'';
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
        "$kubernetes"
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

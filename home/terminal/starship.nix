{ lib, ... }:

{
  programs.starship =
    let
      git_style = "bold purple";
    in
    {
      enable = true;
      enableZshIntegration = true;

      settings = {
        add_newline = false;
        scan_timeout = 10;

        git_branch.style = git_style;
        git_state.style = git_style;

        git_metrics.disabled = false;

        git_status = {
          style = git_style;
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
        };

        memory_usage = {
          format = "$symbol [\${ram}( | \${swap})]($style) ";
          disabled = false;
        };

        cmd_duration = {
          min_time = 500;
          show_milliseconds = true;
          format = ''⏱️ [$duration]($style)'';
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
          "$git_metrics"
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

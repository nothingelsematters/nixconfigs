{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;

      character = {
        success_symbol = "[🗸](bold green) ";
        error_symbol = "[✗](bold red) ";
      };

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      nix_shell = { use_name = true; };

      memory_usage = { disabled = false; };
    };
  };
}

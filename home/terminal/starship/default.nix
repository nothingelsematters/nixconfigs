{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      scan_timeout = 10;

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      nix_shell = {
        use_name = true;
        symbol = "❄️";
      };

      python.python_binary = [ "python3" ];

      memory_usage.disabled = false;
    };
  };
}

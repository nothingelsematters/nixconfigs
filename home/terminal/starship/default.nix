{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      scan_timeout = 10;

      memory_usage.disabled = false;

      cmd_duration = {
        min_time = 500;
        show_milliseconds = true;
      };

      nix_shell = {
        symbol = "❄️ ";
        use_name = true;
      };

      python.python_binary = [ "python3" ];

      custom.kotlin = {
        symbol = "🏝 ";
        style = "bold fg:208";
        format = "via [\${symbol}\${version}]($style)";
        command = "(cat build.gradle.kts"
          + " | rg 'id\\(\"org.jetbrains.kotlin.jvm\"\\) version'"
          + " || kotlin -version)"
          + " | gawk '{ gsub(/\"/, \"\", $3); print $3 }'";
        files = [ "build.gradle.kts" ];
        directories = [ "gradle" ];
        extensions = [ "kt" ];
      };
    };
  };
}

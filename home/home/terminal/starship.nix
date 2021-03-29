{
  programs.starship.settings = {
    scan_timeout = 10;

    memory_usage.disabled = false;

    cmd_duration = {
      min_time = 500;
      show_milliseconds = true;
    };

    env_var.variable = "NIX_NAME";

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

    format = "$username" + "$hostname" + "$shlvl" + "$kubernetes" + "$directory"
      + "$git_branch" + "$git_commit" + "$git_state" + "$git_status"
      + "$hg_branch" + "$docker_context" + "$package" + "$cmake" + "$dart"
      + "$dotnet" + "$elixir" + "$elm" + "$erlang" + "$golang" + "$helm"
      + "$java" + "$julia" + "$nim" + "$nodejs" + "$ocaml" + "$perl" + "$php"
      + "$purescript" + "$python" + "$ruby" + "$rust" + "$swift" + "$terraform"
      + "$zig" + "$custom" + "$nix_shell" + "$env_var" + "$conda"
      + "$memory_usage" + "$aws" + "$gcloud" + "$openstack" + "$crystal"
      + "$cmd_duration" + "$line_break" + "$lua" + "$jobs" + "$battery"
      + "$time" + "$status" + "$character";
  };
}

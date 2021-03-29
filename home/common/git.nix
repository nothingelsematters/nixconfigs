{ config, ... }:

{
  programs = {
    zsh.shellAliases = {
      g = "git";
      gco = "git checkout";

      current_branch = "git rev-parse --abbrev-ref HEAD";
      gpull = "git pull origin $(current_branch)";
      gpush = "git push origin $(current_branch)";

      gs = "git status -s";
      gl =
        "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)"
        + " - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)-"
        + " %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";

      gcmsg = "git commit -m";
      gc = "git commit --no-edit";
      gmc = "gitmoji -c";
    };

    git.delta = {
      enable = true;
      options = {
        line-numbers = true;
        decorations = true;
        theme = "OneHalf${if config.lib.theme.isDark then "Dark" else "Light"}";
      };
    };
  };
}

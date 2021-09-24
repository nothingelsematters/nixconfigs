{ config, ... }:

{
  programs = {
    zsh.shellAliases = {
      g = "git";
      gco = "git checkout";
      gcl = "git clone";

      current_branch = "git rev-parse --abbrev-ref HEAD";
      gpull = "git pull origin $(current_branch)";
      gpush = "git push origin $(current_branch)";

      gs = "git status -s";
      gl = "gll --all --stat";
      gll =
        "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)"
        + " - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)-"
        + " %an%C(reset)%C(bold red)%d%C(reset)%n'";

      gcmsg = "git commit -m";
      gc = "git commit --no-edit";
      gmc = "gitmoji -c";
    };

    git = {
      enable = true;

      delta = {
        enable = true;
        options = {
          line-numbers = true;
          decorations = true;
          theme =
            "OneHalfDark";
        };
      };

      extraConfig = {
        pull.rebase = true;
        credential.helper = "store";
        color.ui = true;

        "color \"diff-highlight\"" = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 52";
        };

        "color \"diff\"" = {
          meta = "yellow";
          frag = "magenta bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
      };
    };

    gh.enable = true;
  };
}

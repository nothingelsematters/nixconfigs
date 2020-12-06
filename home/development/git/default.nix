{ config, pkgs, ... }:

{
  programs = {
    gh.enable = true;

    zsh.shellAliases = {
      g = "git";
      gco = "git checkout";
      gpull = "git pull origin $(current_branch)";
      gpush = "git push origin $(current_branch)";

      gs = "git status -s";
      gl =
        "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset)"
        + " - %C(bold yellow)%<|(27)%ar%C(reset) %C(bold green)%<|(70)%s%C(reset) %C(dim white)-"
        + " %an%C(reset)%C(bold red)%d%C(reset)%n' --all --stat";

      gcmsg = "git commit -m";
      gmc = "gitmoji -c";
    };

    git = {
      enable = true;
      userName = "Simon Naumov";
      userEmail = "daretoodefy@gmail.com";

      delta = {
        enable = true;
        options = {
          line-numbers = true;
          decorations = true;
          theme =
            "OneHalf${if config.lib.theme.isDark then "Dark" else "Light"}";
        };
      };

      extraConfig = {
        core.editor = "$EDITOR --wait";

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
  };
}

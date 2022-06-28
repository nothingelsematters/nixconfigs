{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nodePackages.gitmoji-cli ];

  programs = {
    git = {
      enable = true;
      userName = "Simon Naumov";

      delta = {
        enable = true;
        options = {
          line-numbers = true;
          decorations = true;
          theme = "OneHalfDark";
        };
      };

      extraConfig = {
        pull.rebase = true;
        credential.helper = "store";
        init.defaultBranch = "main";

        core.editor = "${config.lib.packages.editor.name} --wait";
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

    zsh.shellAliases = {
      g = "git";
      gco = "git checkout";
      gcl = "git clone";

      current_branch = "git rev-parse --abbrev-ref HEAD";
      gpull = "git pull origin $(current_branch)";
      gpush = "git push origin $(current_branch)";
      "gpush!" = "gpush --force";
      grpo = "git remote prune origin";

      gs = "git status -s";

      gcm = "git commit -m";
      gmc = "gitmoji -c";
    }
    # git log aliases
      // (let
        colored = color: text: "%C(${color})${text}%C(reset)";

        shortFormat = colored "bold blue" "%>|(13)%h" # commit hash
          + " - " + colored "bold yellow" "%<(12)%ad" # date, time
          + colored "bold green" " %<(60,trunc)%s" # message
          + colored "dim white" " - %an" # author
          + colored "bold red" "%d"; # ref names

        longFormat = colored "bold blue" "%>|(13)%h" # commit hash
          + " - " + colored "bold yellow" "%<(12)%ad" # date, time
          + colored "bold green" " %<(60)%s" # message
          + colored "dim white" " by %an" # author
          + colored "bold red" "%d" + "%n"; # ref names

        format = format:
          "git -c color.ui=always log --graph --abbrev-commit --decorate"
          + " --date=format:'%Y-%m-%d %H:%M:%S' --format=format:'${format}'";

        less = command: "${command} | less -R";
      in {
        gl = less (format shortFormat);
        gll = less "${format longFormat} --all --stat";

        # replaces :fire: -> 🔥
        gle = less ''
          gl \
            | sed -E "$(
              gitmoji -l \
                | awk '{ print "s/" $3 "(.*37m)/" $1 "\\1" sprintf("%" (length($3) - 2) "s", "") "/g" }'
            )"'';
      });
  };
}

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
        advice.skippedCherryPicks = false;

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

    gh = {
      enable = true;
      extensions = [ pkgs.turbo.gh-dash ];
    };

    zsh = {
      plugins = [{
        name = "forgit";
        src = pkgs.forgit;
      }];

      shellAliases = {
        current_branch = "git rev-parse --abbrev-ref HEAD";
        repo_default_branch =
          "git remote show origin | rg 'HEAD branch' | cut -d' ' -f5";

        g = "git";

        "g.cl" = "git clone";
        "g.pull" = "git pull origin $(current_branch)";
        "g.push" = "git push origin $(current_branch)";
        "gpush!" = "gpush --force";
        "g.rpo" = "git remote prune origin";

        "g.s" = "git status -s";
        "g.cm" = "git commit -m";

        "g.co" = "git checkout";
        "g.com" = "git checkout $(repo_default_branch)";
        "g.compull" = "gcom && gpull";

        "g.r" = "git rebase";
        "g.rm" = "git rebase $(repo_default_branch)";
        "g.rmnew" =
          let colorised_log = text: ''echo "\e[1;34m> ${text} \e[0m"'';
          in ''
            CURRENT_BRANCH=$(current_branch) &&
              ${colorised_log "Checking out main branch"} &&
              gcom &&
              ${colorised_log "Pulling"} &&
              gpull &&
              ${colorised_log "Checking out back"} &&
              gco $CURRENT_BRANCH &&
              unset CURRENT_BRANCH &&
              ${colorised_log "Rebasing on main"} &&
              grm
          '';
        "g.rc" = "git rebase --continue";
      }
      # git log aliases
        // (let
          colored = color: text: "%C(${color})${text}%C(reset)";

          shortFormat = colored "bold blue" "%>|(13)%h" # commit hash
            + " - " + colored "bold yellow" "%<(12)%ad" # date, time
            + colored "bold green" " %<(60,trunc)%s" # message
            + colored "dim white" " - %an" # author
            + colored "bold red" "%d" + "%n"; # ref names

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
          "g.l" = less (format shortFormat);
          "g.ll" = less "${format longFormat} --all --stat";

          # replaces :fire: -> 🔥
          "g.le" = less ''
            gl \
              | sed -E "$(
                gitmoji -l \
                  | awk '{ print "s/" $3 "(.*37m)/" $1 "\\1" sprintf("%" (length($3) - 2) "s", "") "/g" }'
              )"'';
        });
    };
  };
}

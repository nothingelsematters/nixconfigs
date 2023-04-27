{ config, pkgs, ... }:

let editor = config.lib.packages.editor.command;
in {
  home.packages = with pkgs; [ nodePackages.gitmoji-cli lab ];

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

        core.editor = "${editor} --wait";
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

    zsh = {
      plugins = [{
        name = "forgit";
        src = pkgs.zsh-forgit + /share/zsh/zsh-forgit;
      }];

      shellAliases =
        let colorised_log = text: ''echo "\e[1;34m> ${text} \e[0m"'';
        in {
          g = "git";

          current_branch = "g rev-parse --abbrev-ref HEAD";

          # remote
          "g.cl" = "g clone --recurse-submodules";
          "g.pull" = "g pull origin $(current_branch) --recurse-submodules";
          "g.push" = "g push origin $(current_branch)";
          "g.push!" = "g.push --force";
          "g.rpo" = "g remote prune origin";

          # commit
          "g.s" = "g status -s";
          "g.a" = "forgit::add";
          "g.c.m" = "g commit -m";

          # checkout
          "g.co" = "g checkout";
          "g.co.b" = "forgit::checkout::branch";
          "g.co.m" = "g.co main || g.co master";
          "g.co.m.new" = "g.co.m && g.pull";

          # rebase
          "g.r" = "g rebase";
          "g.r.m" = "g.r main || g.r master";
          "g.r.m.new" = ''
            CURRENT_BRANCH=$(current_branch) &&
              ${colorised_log "checking out main branch"} &&
              g.co.m &&
              ${colorised_log "pulling"} &&
              g.pull &&
              ${colorised_log "checking out back"} &&
              g.co $CURRENT_BRANCH &&
              unset CURRENT_BRANCH &&
              ${colorised_log "rebasing on main"} &&
              g.r.m;
              ${colorised_log "status"} &&
              g.s &&
              ${colorised_log "opening in ${editor}"} &&
              g.s | rg UU | awk '{ print $2 }' | xargs --no-run-if-empty ${editor}
          '';
          "g.r.c" = ''
            ${colorised_log "continue rebasing"} &&
              GIT_EDITOR=true g.r --continue;
              ${colorised_log "status"} &&
              g.s &&
              ${colorised_log "opening in ${editor}"} &&
              g.s | rg UU | awk '{ print $2 }' | xargs --no-run-if-empty ${editor}
          '';
        }
        # log
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
            "g -c color.ui=always log --graph --abbrev-commit --decorate"
            + " --date=format:'%Y-%m-%d %H:%M:%S' --format=format:'${format}'";

          less = command: "${command} | less -R";
        in {
          "g.l" = less (format shortFormat);
          "g.ll" = less "${format longFormat} --all --stat";

          # replaces :fire: -> 🔥
          "g.le" = less ''
            g.l \
              | sed -E "$(
                gitmoji -l \
                  | awk '{ print "s/" $3 "(.*37m)/" $1 "\\1" sprintf("%" (length($3) - 2) "s", "") "/g" }'
              )"'';
        });
    };
  };
}

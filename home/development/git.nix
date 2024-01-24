{ config, pkgs, ... }:

let editor = config.lib.packages.editor;
in {
  home.packages = with pkgs; [ nodePackages.gitmoji-cli lab pre-commit ];

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

    zsh = rec {
      plugins = [{
        name = "forgit";
        src = pkgs.zsh-forgit + /share/zsh/zsh-forgit;
      }];

      shellAliases = let
        log_and_run = cmd: "echo '\\e[1;34m> ${cmd} \\e[0m' && ${cmd}";
        edit_conflicts = ''
          git status -s | rg UU | awk "{ print \$2 }" | xargs --no-run-if-empty ${editor}'';
      in {
        g = "git";

        current_branch = "git rev-parse --abbrev-ref HEAD";

        # remote
        "g.cl" = "git clone --recurse-submodules";
        "g.pull" = "git pull origin $(current_branch) --recurse-submodules";
        "g.push" = "git push origin $(current_branch)";
        "g.push!" = "git push origin $(current_branch) --force";
        "g.rpo" = "git remote prune origin";

        # commit
        "g.s" = "git status --short";
        "g.a" = "forgit::add";
        "g.c.m" = "git commit --message";

        # checkout
        "g.co" = "git checkout";
        "g.co.b" = "forgit::checkout::branch";
        "g.co.m" = "git checkout main || git checkout master";
        "g.co.m.pull" = "g.co.m && g.pull";

        # rebase
        "g.r" = "git rebase";
        "g.r.m" = "git rebase main || git rebase master";
        "g.r.m.pull" = ''
          CURRENT_BRANCH=$(current_branch) &&
            ${log_and_run "git checkout main || git checkout master"} &&
            ${log_and_run shellAliases."g.pull"} &&
            ${log_and_run "git checkout $CURRENT_BRANCH"} &&
            unset CURRENT_BRANCH &&
            ${log_and_run shellAliases."g.r.m"} &&
            ${log_and_run shellAliases."g.s"} &&
            ${log_and_run edit_conflicts} ||
            ${log_and_run "git checkout $CURRENT_BRANCH"} &&
            unset CURRENT_BRANCH &&
            false;
        '';
        "g.r.c" = ''
          ${log_and_run "GIT_EDITOR=true git rebase --continue"};
            ${log_and_run shellAliases."g.s"} &&
            ${log_and_run edit_conflicts}
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

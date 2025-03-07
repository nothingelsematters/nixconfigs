editor:

let
  shellAliases =
    {
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
      "g.rst.h" = "forgit::reset::head";
      "g.c.m" = "git commit --message";
      "g.c.tmp" = "git add . && git commit --message tmp";

      # checkout
      "g.co" = "git checkout";
      "g.co.f" = "forgit::checkout::file";
      "g.co.b" = "forgit::checkout::branch";
      "g.co.m" = "git checkout main || git checkout master";
      "g.co.m.pull" = "g.co.m && g.pull";

      # log
      "g.l" = "forgit::log";
    }

    # rebase
    // (
      let
        log_and_run = cmd: "echo '\\e[1;34m> ${cmd} \\e[0m' && ${cmd}";
        edit_conflicts = ''git status -s | rg UU | awk "{ print \$2 }" | xargs --no-run-if-empty ${editor}'';
      in
      {
        "g.r" = "git rebase";
        "g.r.m" = "git rebase main || git rebase master";

        # standard pipeline: checkout main, pull, checkout back, rebase
        "g.r.m.pull" = ''
          CURRENT_BRANCH=$(current_branch) &&
            (
              ${log_and_run shellAliases."g.co.m"} &&
              ${log_and_run shellAliases."g.pull"} &&
              ${log_and_run "git checkout $CURRENT_BRANCH"} &&
              unset CURRENT_BRANCH ||
              (
                ${log_and_run "git checkout $CURRENT_BRANCH"} &&
                unset CURRENT_BRANCH &&
                false
              )
            ) &&
            (
              ${log_and_run shellAliases."g.r.m"} ||
              ${log_and_run shellAliases."g.s"} &&
              ${log_and_run edit_conflicts}
            )
        '';
        "g.r.c" = ''
          ${log_and_run "GIT_EDITOR=true git rebase --continue"} ||
            (
              ${log_and_run shellAliases."g.s"} &&
              ${log_and_run edit_conflicts}
            )
        '';
      }
    );
in
shellAliases

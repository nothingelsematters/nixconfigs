{ config, pkgs, ... }:

with config.lib;
{
  home = {
    packages = with pkgs; [
      pre-commit
      emojify
      nodePackages.gitmoji-cli
    ];

    sessionVariables = rec {
      # forgit::log
      FORGIT_LOG_FORMAT = "%C(blue)%h %C(dim white)%ad%C(reset) %C(bold white)%s %C(dim white)%d%C(reset)";
      FORGIT_LOG_GIT_OPTS = "--date=short";
    };
  };

  programs = {
    gh = {
      enable = true;
      settings.editor = "${packages.editor} --wait";
    };

    zsh = rec {
      plugins = [
        {
          name = "forgit";
          src = pkgs.zsh-forgit + /share/zsh/zsh-forgit;
        }
      ];

      shellAliases = import ./aliases.nix packages.editor;
    };

    git = rec {
      enable = true;
      userName = "Simon Naumov";

      delta = {
        enable = true;
        package = pkgs.turbo.delta;
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

        core.editor = "${packages.editor} --wait";
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

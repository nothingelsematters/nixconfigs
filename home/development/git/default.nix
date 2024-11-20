{ config, pkgs, ... }:

let
  editor = config.lib.packages.editor;
in
{
  home.packages = with pkgs; [
    nodePackages.gitmoji-cli
    pre-commit
  ];

  programs = {
    gh = {
      enable = true;
      settings.editor = "${editor} --wait";
    };

    zsh = rec {
      plugins = [
        {
          name = "forgit";
          src = pkgs.zsh-forgit + /share/zsh/zsh-forgit;
        }
      ];

      shellAliases = import ./aliases.nix editor;
    };

    git = {
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
  };
}

{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; with gitAndTools; [ delta hub gh lazygit ];

  programs.git = {
    enable = true;
    userName = "Simon Naumov";
    userEmail = "daretoodefy@gmail.com";

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        decorations = true;
        theme = "OneHalf${if config.lib.theme.isDark then "Dark" else "Light"}";
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
}

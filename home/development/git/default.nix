{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs.gitAndTools; [ delta hub ];

  programs.git = {
    enable = true;
    userName = "Simon Naumov";
    userEmail = "daretoodefy@gmail.com";

    delta = {
      enable = true;
      options = [
        "--theme OneHalf${
          if config.lib.theme.isDark then "Dark" else "Light"
        } | less --tabs=4 -RFX"
      ];
    };

    extraConfig = {
      core.editor = "$EDITOR --wait";

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

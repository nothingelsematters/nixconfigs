{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ git gitAndTools.diff-so-fancy ];

  programs.git = {
    enable = true;
    userName = "Simon Naumov";
    userEmail = "daretoodefy@gmail.com";

    extraConfig = {
      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        editor = "atom --wait";
      };

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

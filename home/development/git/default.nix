{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.packages = [ pkgs.nodePackages.gitmoji-cli ];

  programs = {
    gh.enable = true;

    git = {
      enable = true;
      userName = "Simon Naumov";
      userEmail = "daretoodefy@gmail.com";

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
  };
}

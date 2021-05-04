{ config, pkgs, ... }:

{
  home.packages = [ pkgs.nodePackages.gitmoji-cli ];

  programs = {
    gh.enable = true;

    git = {
      userName = "Simon Naumov";
      userEmail = "daretoodefy@gmail.com";
    };

    vscode = {
      userSettings."gitmoji.outputType" = "code";

      extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "git-graph";
          publisher = "mhutchie";
          version = "1.30.0";
          sha256 = "sha256-sHeaMMr5hmQ0kAFZxxMiRk6f0mfjkg2XMnA4Gf+DHwA=";
        }
        {
          name = "gitmoji-vscode";
          publisher = "Vtrois";
          version = "1.0.5";
          sha256 = "sha256-zJbRle6dKT45gFR/S5dwPJJoIcJTd47pe905gjV9W6w=";
        }
      ];
    };
  };
}

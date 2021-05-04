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
          version = "1.22.0";
          sha256 = "06j49pxz9vp6z4hax60jsn4fa2iig76d8p9cjhdhbvmyil0dgggx";
        }
        {
          name = "gitmoji-vscode";
          publisher = "Vtrois";
          version = "0.1.9";
          sha256 = "0mhgl7sdqdzj5gsrajrfq4g6wqikk19fa59rrr2dhq6hrin7a9mb";
        }
      ];
    };
  };
}

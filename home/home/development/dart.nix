{ pkgs, ... }:

{
  home.packages = [ pkgs.dart ];

  programs.vscode = {
    userSettings."dart.checkForSdkUpdates" = false;

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "dart-code";
      publisher = "dart-code";
      version = "3.22.0";
      sha256 = "sha256-1nTewVmlrxbXdRR1EPts46u24LHdnP5BblFsMaGlNYg=";
    }];
  };
}

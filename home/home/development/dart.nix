{ pkgs, ... }:

{
  home.packages = with pkgs; [ dart flutter ];

  programs.vscode = {
    userSettings."dart.checkForSdkUpdates" = false;

    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        publisher = "dart-code";
        name = "flutter";
        version = "3.22.0";
        sha256 = "sha256-woygN6hOWlP2UayqwDhJh9KcZk1GzH7mDF5IueDRxs4=";
      }
      {
        publisher = "dart-code";
        name = "dart-code";
        version = "3.22.0";
        sha256 = "sha256-1nTewVmlrxbXdRR1EPts46u24LHdnP5BblFsMaGlNYg=";
      }
    ];
  };
}

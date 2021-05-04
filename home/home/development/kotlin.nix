{ pkgs, ... }:

{
  home.packages = with pkgs; [ kotlin ktlint ];

  programs = {
    zsh.shellAliases = {
      kt = "kotlin";
      ktc = "kotlinc";
      kts = "kotlinc -script";
    };

    vscode.extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "kotlin";
      publisher = "fwcd";
      version = "0.2.22";
      sha256 = "sha256-CkoAl2hmkrf+hnDQo6CdgWsqUeF6EgeS1Pjabqo7nVk=";
    }];
  };
}

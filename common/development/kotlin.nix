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
      version = "0.2.23";
      sha256 = "sha256-nKhQrDdpKnZmC5nnfSTevUES1G6H8WNlLF26zFWnTmQ=";
    }];
  };
}

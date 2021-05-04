{ pkgs, ... }:

{
  home.packages = with pkgs; [ kotlin ktlint ];

  programs = {
    zsh.shellAliases = {
      kt = "kotlin";
      ktc = "kotlinc";
      kts = "kotlinc -script";
    };

    vscode.extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "kotlin";
        publisher = "fwcd";
        version = "0.2.18";
        sha256 = "06ni65a2q75zlld3cx8mp7jl38icaqmb7wmcrnblxzr2sxkyjzp9";
      }
      {
        name = "kotlin-formatter";
        publisher = "esafirm";
        version = "0.0.6";
        sha256 = "00w7d0iyr3nf5jqzwy7kk7awyh3fnljzrjbkknxmpjyjyvaa7n0z";
      }
    ];
  };
}

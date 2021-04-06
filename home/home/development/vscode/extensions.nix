{ pkgs, ... }:

with pkgs;
with vscode-extensions;
[
  tomoki1207.pdf

  # theme
  file-icons.file-icons
  gruntfuggly.todo-tree
  github.github-vscode-theme

  # nix
  bbenoist.Nix
  brettm12345.nixfmt-vscode
  jnoortheen.nix-ide

  # haskell
  justusadam.language-haskell

  # rust
  matklad.rust-analyzer
  serayuzgur.crates

  # latex
  james-yu.latex-workshop

  # markdown
  yzhang.markdown-all-in-one
] ++ vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "vscode-diff";
    publisher = "fabiospampinato";
    version = "1.4.0";
    sha256 = "10ayc6677clpnid4lm6h22v5635k1aidp7pr2iwkiblbqq6ri5s0";
  }

  # git
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

  # kotlin
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

  # rust
  {
    name = "rust";
    publisher = "rust-lang";
    version = "0.7.8";
    sha256 = "039ns854v1k4jb9xqknrjkj8lf62nfcpfn0716ancmjc4f0xlzb3";
  }

  # haskell
  {
    name = "haskell-linter";
    publisher = "hoovercj";
    version = "0.0.6";
    sha256 = "0fb71cbjx1pyrjhi5ak29wj23b874b5hqjbh68njs61vkr3jlf1j";
  }
  {
    name = "stylish-haskell";
    publisher = "vigoo";
    version = "0.0.10";
    sha256 = "1zkvcan7zmgkg3cbzw6qfrs3772i0dwhnywx1cgwhy39g1l62r0q";
  }
  {
    name = "vscode-ghc-simple";
    publisher = "dramforever";
    version = "0.1.22";
    sha256 = "0x3csdn3pz5rhl9mhplpm8kxb40l1dw5rnwhh3zsif3rz0nqhk2a";
  }
]

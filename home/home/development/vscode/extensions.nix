{ pkgs, ... }:

with pkgs;
with vscode-extensions;
[
  # nix
  bbenoist.Nix

  # haskell
  justusadam.language-haskell

  # rust
  matklad.rust-analyzer
] ++ vscode-utils.extensionsFromVscodeMarketplace [
  {
    name = "github-vscode-theme";
    publisher = "github";
    version = "1.1.5";
    sha256 = "1llyrm4iwdp79ylnw4kn5g6qlp8blrpaddszhl61yv82rs60kw0h";
  }
  {
    name = "file-icons";
    publisher = "file-icons";
    version = "1.0.24";
    sha256 = "0mcaz4lv7zb0gw0i9zbd0cmxc41dnw344ggwj1wy9y40d627wdcx";
  }
  {
    name = "vscode-diff";
    publisher = "fabiospampinato";
    version = "1.4.0";
    sha256 = "10ayc6677clpnid4lm6h22v5635k1aidp7pr2iwkiblbqq6ri5s0";
  }
  {
    name = "todo-tree";
    publisher = "gruntfuggly";
    version = "0.0.177";
    sha256 = "1j3vgyimc4gamp3dnym9wfk445q5hipjq3cimvpqqa22pk4g0224";
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

  # nix
  {
    name = "nixfmt-vscode";
    publisher = "brettm12345";
    version = "0.0.1";
    sha256 = "07w35c69vk1l6vipnq3qfack36qcszqxn8j3v332bl0w6m02aa7k";
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

  # markdown
  {
    name = "markdown-all-in-one";
    publisher = "yzhang";
    version = "3.1.0";
    sha256 = "0b5fqwaxbdqpqx53gxjjfawghwrpbj9zmbvsw5wamn1jx3djgflk";
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

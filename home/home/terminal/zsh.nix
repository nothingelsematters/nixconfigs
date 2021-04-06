{ pkgs, inputs, ... }:

{
  programs.zsh.shellAliases = rec {
    nrs = "sudo nixos-rebuild switch --keep-going --show-trace";
    nsp = "cached-nix-shell --run zsh -p";

    confs = "z conf; $EDITOR .";

    copy = "wl-copy";
    paste = "wl-paste";
  };
}

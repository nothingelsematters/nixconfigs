{ pkgs, inputs, ... }:

{
  programs.zsh.shellAliases = rec {
    nrs = "sudo nixos-rebuild switch --keep-going";

    confs = "z conf; $EDITOR .";

    copy = "wl-copy";
    paste = "wl-paste";
  };
}

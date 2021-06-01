{ pkgs, inputs, ... }:

{
  programs.zsh.shellAliases = rec {
    confs = "z conf; $EDITOR .";
    copy = "wl-copy";
    paste = "wl-paste";
  };
}

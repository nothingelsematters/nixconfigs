{ pkgs, inputs, ... }:

{
  programs.zsh = {
    plugins = [{
      name = "forgit";
      src = inputs.forgit;
    }];

    shellAliases = rec {
      confs = "z conf; $EDITOR .";
      copy = "wl-copy";
      paste = "wl-paste";
    };
  };
}

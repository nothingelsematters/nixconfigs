{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--preview 'bat --color always {}'" ];
  };
}

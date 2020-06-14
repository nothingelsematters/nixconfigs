{ config, pkgs, ... }:

let
  files = "rg --files";
  preview = [ "--preview 'bat --color always {}'" ];
in {
  programs.fzf = {
    enable = true;
    defaultOptions = [ "-m" "--reverse" ] ++ preview;
    defaultCommand = files;
    fileWidgetCommand = files;
    fileWidgetOptions = preview;
    changeDirWidgetOptions = [ "--preview 'exa --tree {} | head -100'" ];
  };
}
